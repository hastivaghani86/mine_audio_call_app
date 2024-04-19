import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mine/utils/app_color.dart';
import 'package:mine/utils/app_size_config.dart';
import 'package:mine/utils/app_text_field.dart';

import '../../../../utils/app_button.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MySize().init(
      context,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                fit: FlexFit.loose,
                flex: 3,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MySize.getScaledSizeWidth(44.00),
                        right: MySize.getScaledSizeWidth(44.00),
                        top: MySize.getScaledSizeHeight(91.00),
                        bottom: MySize.getScaledSizeHeight(58.00)),
                    // child: Image(
                    //   image: AssetImage(AppImage.login),
                    //   width: MySize.screenWidth,
                    //   fit: BoxFit.fill,
                    // ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                flex: 7,
                child: Form(
                  key: controller.formKeyLogin,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: MySize.getScaledSizeWidth(24.00),
                      right: MySize.getScaledSizeWidth(24.00),
                    ),
                    child: Column(
                      children: [
                        Obx(
                              () => AppTextField(
                            // keyBoardTypeEnter: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,
                            controller: controller.emailController.value,
                            hintText:"Enter your email",
                            needValidation: true,
                            isEmailValidation: true,
                            upperCaseTextFormatter: false,
                            validationMessage: "Email",
                            // prefixIco: Padding(
                            //   padding: const EdgeInsets.symmetric(vertical: 14),
                            //   child: Image(
                            //     image: AssetImage(AppImage.email),
                            //     height: MySize.size16,
                            //     width: MySize.size14,
                            //   ),
                            // ),
                            obscureText: controller.isVisible.value,
                            maxLines: 1,
                            // tcPadding: 16,
                            // bcPadding: 16,
                          ),
                        ),
                        Space.height(20),
                        Obx(
                              () => AppTextField(
                            // keyBoardTypeEnter: TextInputType.text,
                            textCapitalization: TextCapitalization.none,
                            controller: controller.passwordController.value,
                            hintText: "Enter password",
                            needValidation: true,
                            isPassWordValidation: true,
                            validationMessage: "Password",
                            // prefixIco: Padding(
                            //   padding: const EdgeInsets.symmetric(vertical: 14),
                            //   child: Image(
                            //     image: AssetImage(AppImage.password),
                            //     height: MySize.size16,
                            //     width: MySize.size14,
                            //   ),
                            // ),
                            obscureText: controller.isVisible1.value,
                            maxLines: 1,
                            iconButton: InkWell(
                              onTap: () {
                                controller.isVisible1.value = !controller.isVisible1.value;
                                //setState(() {});
                              },
                              child: Icon(
                                !controller.isVisible1.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColor.grey,
                                size: MySize.size26,
                              ),
                            ),
                            // tcPadding: 16,
                            // bcPadding: 16,
                          ),
                        ),
                        Obx(() => isAdmin.value==false ?SizedBox():                        Space.height(20),
                        ),
                        Obx(
                                () =>isAdmin.value==false ?SizedBox():  AppTextField(
                            // keyBoardTypeEnter: TextInputType.text,
                            textCapitalization: TextCapitalization.none,
                            controller: controller.adminKeyController.value,
                            hintText: "Enter Admin Secret",
                            needValidation: true,
                            // isPassWordValidation: true,
                            validationMessage: "Admin Secret",
                            // prefixIco: Padding(
                            //   padding: const EdgeInsets.symmetric(vertical: 14),
                            //   child: Image(
                            //     image: AssetImage(AppImage.password),
                            //     height: MySize.size16,
                            //     width: MySize.size14,
                            //   ),
                            // ),
                            // obscureText: controller.isVisible1.value,
                            maxLines: 1,
                            // iconButton: InkWell(
                            //   onTap: () {
                            //     // controller.isVisible1.value = !controller.isVisible1.value;
                            //     //setState(() {});
                            //   },
                            //   child: Icon(
                            //     !controller.isVisible1.value
                            //         ? Icons.visibility_off_outlined
                            //         : Icons.visibility_outlined,
                            //     color: AppColor.grey,
                            //     size: MySize.size26,
                            //   ),
                            // ),
                            // tcPadding: 16,
                            // bcPadding: 16,
                          ),
                        ),
                        Space.height(38),

                        AppButton(
                            btnText: "Login",
                            btnTxtColor: AppColor.white,
                            bgColor: AppColor.primaryColor,
                            onTap: () async {
                              await controller.login(context: context);
                            }),
                        Space.height(15),
                        const Text("OR",style: TextStyle(fontSize: 18),),
                        Space.height(15),
                        AppButton(
                            btnText: "Sign Up",
                            btnTxtColor: AppColor.white,
                            bgColor: AppColor.primaryColor,
                            onTap: () async {
                              await controller.signUp(context: context);
                            }),
                        Space.height(60),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Obx(() => controller.isLoading.value ?  const Center(child: CircularProgressIndicator(color: AppColor.grey,)) : const SizedBox())
        ],
      ),
    );
  }
}
