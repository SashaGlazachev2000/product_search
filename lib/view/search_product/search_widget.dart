import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_search/assets/app_colors.dart';
import 'package:product_search/bloc/product_bloc/product_bloc.dart';
import 'package:product_search/bloc/product_bloc/product_event.dart';
import 'package:product_search/bloc/product_bloc/product_state.dart';

class SearchWidget extends StatelessWidget {
  final controller = TextEditingController();

  SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ErrorLoadedProductState) {
          controller.text = '';
        }
        if (state is LoadedProductState) {
          controller.text = state.product.barcode.toString();
        }
        return Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 60,
                child: TextField(
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide: BorderSide(
                        width: 1.5,
                        color: AppColors.appBlue,
                      ),
                    ),
                    enabledBorder: state is ErrorLoadedProductState
                        ? const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              width: 3,
                              color: AppColors.appRed,
                            ),
                          )
                        : null,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        width: 2,
                        color: AppColors.appBlue,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    fillColor: AppColors.appTextBackground,
                    filled: true,
                    hintText: 'Введите код',
                    hintStyle: const TextStyle(color: AppColors.appGrayHint),
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 22),
                  onTap: () {
                    controller.text = '';
                  },
                  onSubmitted: (value) {
                    context.read<ProductBloc>().add(
                          ProductGetProductEvent(
                            code: int.tryParse(controller.text),
                          ),
                        );
                  },
                  controller: controller,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const _ButtonBacrode(),
            const SizedBox(width: 10),
            _ButtonSearch(
              onTap: () {
                context.read<ProductBloc>().add(
                      ProductGetProductEvent(
                        code: int.tryParse(controller.text),
                      ),
                    );
                FocusManager.instance.primaryFocus?.unfocus();
              },
              iconData: Icons.search,
            ),
          ],
        );
      },
    );
  }
}

class _ButtonBacrode extends StatefulWidget {
  const _ButtonBacrode();

  @override
  State<_ButtonBacrode> createState() => _ButtonBacrodeState();
}

class _ButtonBacrodeState extends State<_ButtonBacrode> {
  Future<void> _scanBarcode() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.DEFAULT,
      );
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    context.read<ProductBloc>().add(
          ProductGetProductEvent(
            code: int.tryParse(barcodeScanRes),
          ),
        );
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return _ButtonSearch(
      onTap: _scanBarcode,
      iconData: Icons.qr_code_scanner_sharp,
    );
  }
}

class _ButtonSearch extends StatelessWidget {
  const _ButtonSearch({
    required this.onTap,
    required this.iconData,
  });

  final GestureTapCallback onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.appTextBackground,
            ),
            child: Icon(iconData),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: onTap,
            ),
          )
        ],
      ),
    );
  }
}
