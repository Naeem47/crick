// ignore_for_file: override_on_non_overriding_member

import 'dart:async';
import 'package:bloc/bloc.dart';

class PhoneVerificationBloc extends Bloc<PhoneVerificationBlocEvent, PhoneVerificationBlocState> {
  var countryCode = '+91';
  var phoneNo = '';
  var gotoNext = false;
  var isPhoneVerified = false;
  var isPhoneFailed = false;
  var isOtpVerified = false;
  var verificationId = '';

  PhoneVerificationBloc(PhoneVerificationBlocState initialState) : super(initialState);

  void onInisialList(String countryCodeData, String phoneNoData) {
    countryCode = countryCodeData;
    phoneNo = phoneNoData;
    gotoNext = false;
    isPhoneFailed = false;
    isPhoneVerified = false;
    add(PhoneVerificationBlocEvent.setUpdate);
  }

  void setResend() {
    gotoNext = false;
    isPhoneFailed = false;
    isPhoneVerified = false;
    add(PhoneVerificationBlocEvent.setUpdate);
  }

  PhoneVerificationBlocState get initialState => PhoneVerificationBlocState.initial();

  @override
  Stream<PhoneVerificationBlocState> mapEventToState(PhoneVerificationBlocEvent event) async* {
    if (event == PhoneVerificationBlocEvent.setUpdate) {
      yield state.copyWith(
        countryCode: countryCode,
        phoneNo: phoneNo,
        gotoNext: gotoNext,
        isPhoneVerified: isPhoneVerified,
        isPhoneFailed: isPhoneFailed,
        isOtpVerified: isOtpVerified,
      );
    }
  }
}

enum PhoneVerificationBlocEvent { setUpdate }

class PhoneVerificationBlocState {
  var countryCode = '+91';
  var phoneNo = '';
  bool gotoNext;
  bool isPhoneVerified = false;
  bool isPhoneFailed = false;
  bool isOtpVerified = false;

  PhoneVerificationBlocState({
    this.countryCode = '+91',
    this.phoneNo = '',
    this.gotoNext = false,
    this.isPhoneVerified = false,
    this.isPhoneFailed = false,
    this.isOtpVerified = false,
  });

  factory PhoneVerificationBlocState.initial() {
    return PhoneVerificationBlocState(
      countryCode: '+91',
      phoneNo: '',
      gotoNext: false,
      isPhoneVerified: false,
      isPhoneFailed: false,
      isOtpVerified: false,
    );
  }

  PhoneVerificationBlocState copyWith({
    String? countryCode,
    String? phoneNo,
    bool? gotoNext,
    bool? isPhoneVerified,
    bool? isPhoneFailed,
    bool? isOtpVerified,
  }) {
    return PhoneVerificationBlocState(
      countryCode: countryCode ?? this.countryCode,
      phoneNo: phoneNo ?? this.phoneNo,
      gotoNext: gotoNext ?? this.gotoNext,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      isPhoneFailed: isPhoneFailed ?? this.isPhoneFailed,
      isOtpVerified: isOtpVerified ?? this.isOtpVerified,
    );
  }
}
