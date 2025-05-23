abstract class HomeBlocEvent {}

class SelectIndexEvent extends HomeBlocEvent {
  final int currentIndex;
  SelectIndexEvent(this.currentIndex);
}
