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
        return Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 60,
                child: TextField(
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide: BorderSide(
                        width: 1.5,
                        color: AppColors.appBlue,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide:
                            BorderSide(width: 2, color: AppColors.appBlue)),
                    isCollapsed: true,
                    contentPadding: EdgeInsets.all(20),
                    fillColor: AppColors.appTextBackground,
                    filled: true,
                    hintText: 'Введите код',
                    hintStyle: TextStyle(color: AppColors.appGrayHint),
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
            ElevatedButton(
              onPressed: () {
                context.read<ProductBloc>().add(
                      ProductGetProductEvent(
                        code: int.tryParse(controller.text),
                      ),
                    );
                FocusManager.instance.primaryFocus?.unfocus();
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(60, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Icon(Icons.search),
            ),
          ],
        );
      },
    );
  }
}

class _ButtonBacrode extends StatefulWidget {
  const _ButtonBacrode({
    super.key,
  });

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
    return ElevatedButton(
      onPressed: _scanBarcode,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(60, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Icon(Icons.qr_code_scanner_sharp),
    );
  }
}
