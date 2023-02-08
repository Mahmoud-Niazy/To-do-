abstract class TodoStates {}
class TodoInitialState extends TodoStates{}

class ChangeScreenState extends TodoStates{}
class ChangeBottomSheet extends TodoStates {}

class CreateDatabaseSuccessfully extends TodoStates {}
class CreateDatabaseError extends TodoStates {}

class DataInsertedSuccessfully extends TodoStates {}
class DataInsertedError extends TodoStates {}

class GetDataSuccessfully extends TodoStates {}
class GetDataError extends TodoStates {}

class UpdateDataSuccessfully extends TodoStates {}
class UpdateDataError extends TodoStates {}

class DeleteDataSuccessfully extends TodoStates {}
class DeleteDataError extends TodoStates {}
