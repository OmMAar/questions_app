import 'package:equatable/equatable.dart';

class MomFilterArgs extends Equatable {
   String? title;
   bool? flagged;
   bool? chairedByMe;
   bool? reportedByMe;
   bool? hasAttachments;
   bool? sharedWithMe;
   List<String>? momStatus;
   DateTime? startDate;
   DateTime? endDate;
   int? period;
   List<String>? attendeeUserIds;
   List<String>? reportedUserIds;
   List<String>? chairUserIds;
   List<String>? momVisiblity;
   List<String>? tags;
   double? startActionProgress;
   double? endActionProgress;

   MomFilterArgs(
      {this.title,
      this.endDate,
      this.startDate,
      this.tags,
      this.attendeeUserIds,
      this.chairedByMe,
      this.endActionProgress,
      this.flagged,
      this.momStatus,
      this.momVisiblity,
      this.hasAttachments,
      this.sharedWithMe,
      this.period,
      this.reportedByMe,
      this.reportedUserIds,
      this.chairUserIds,
      this.startActionProgress});

  @override
  List<Object?> get props => [this.title,
    this.endDate,
    this.startDate,
    this.tags,
    this.hasAttachments,
    this.sharedWithMe,
    this.attendeeUserIds,
    this.chairedByMe,
    this.endActionProgress,
    this.chairUserIds,
    this.flagged,
    this.momStatus,
    this.momVisiblity,
    this.period,
    this.reportedByMe,
    this.reportedUserIds,
    this.startActionProgress];
}
