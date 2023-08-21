// ignore_for_file: override_on_non_overriding_member

import 'package:bloc/bloc.dart';

class PhoneEntryBloc extends Bloc<PhoneEntryBlocEvent, PhoneEntryBlocState> {
  String otpText = '';
  String phoneText = '';

  var isOtpError = false;
  var isPhoneError = false;

  PhoneEntryBloc(PhoneEntryBlocState initialState) : super(initialState);

  void onPhoneChanges(String phonNo) {
    phoneText = phonNo;
    otpText = '';
    isOtpError = false;

    if (phonNo.length >= 5) {
      isPhoneError = false;
    } else {
      isPhoneError = true;
    }
    if (phonNo.length == 0) {
      isPhoneError = false;
    }
    add(PhoneEntryBlocEvent.setUpdate);
  }

  void onOtpChanges(String otp) {
    otpText = otp;
    if (otp.length >= 4) {
      isOtpError = false;
    } else {
      isOtpError = true;
    }
    add(PhoneEntryBlocEvent.setUpdate);
  }

  PhoneEntryBlocState get initialState => PhoneEntryBlocState.initial();

  @override
  Stream<PhoneEntryBlocState> mapEventToState(PhoneEntryBlocEvent event) async* {
    if (event == PhoneEntryBlocEvent.setUpdate) {
      yield state.copyWith(
        isPhoneError: isPhoneError,
        isOtpError: isOtpError,
        otpText: otpText,
        phoneText: phoneText,
      );
    }
  }
}

enum PhoneEntryBlocEvent { setUpdate }

class PhoneEntryBlocState {
  bool isPhoneError;
  bool isOtpError;
  String otpText;
  String phoneText;

  PhoneEntryBlocState({
    this.isPhoneError = false,
    this.isOtpError = false,
    this.otpText = '',
    this.phoneText = '',
  });

  factory PhoneEntryBlocState.initial() {
    return PhoneEntryBlocState(
      isPhoneError: false,
      isOtpError: false,
      otpText: '',
      phoneText: '',
    );
  }

  PhoneEntryBlocState copyWith({
    bool? isPhoneError,
    bool? isOtpError,
    String? otpText,
    String? phoneText,
  }) {
    return PhoneEntryBlocState(
      isPhoneError: isPhoneError ?? false,
      isOtpError: isOtpError ?? false,
      otpText: otpText ?? "",
      phoneText: phoneText ?? "",
    );
  }
}
