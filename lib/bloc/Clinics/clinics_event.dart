// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'clinics_bloc.dart';

abstract class ClinicsEvent extends Equatable {
  const ClinicsEvent();

  @override
  List<Object> get props => [];
}

class GetClinics extends ClinicsEvent {
  final BuildContext context;
  const GetClinics({required this.context});
}

class CreateClinic extends ClinicsEvent {
  final BuildContext context;
  final CreateClinicRequestDto request;
  const CreateClinic({required this.context, required this.request});
}
