abstract class AddNotesState {}

class AddNotesInitial extends AddNotesState {}

class AddNotesLoading extends AddNotesState {}

class AddNotesLoaded extends AddNotesState {}

class AddNotesError extends AddNotesState {
  final String errMessage;

  AddNotesError(this.errMessage);
}
