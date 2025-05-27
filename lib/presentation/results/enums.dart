// enums.dart

enum ResultStatus { NA, Positive, Negative, Invalid }
enum PartnerResult { NA, Positive, Negative, Invalid }
enum ApprovalStatus { Approved, Rejected }

extension ResultStatusExtension on ResultStatus {
  String get label {
    switch (this) {
      case ResultStatus.Positive:
        return "Positive";
      case ResultStatus.Negative:
        return "Negative";
      case ResultStatus.Invalid:
        return "Invalid";
      case ResultStatus.NA:
        return "";
    }
  }
}

extension PartnerResultExtension on PartnerResult {
  String get label {
    switch (this) {
      case PartnerResult.Positive:
        return "Positive";
      case PartnerResult.Negative:
        return "Negative";
      case PartnerResult.Invalid:
        return "Invalid";
      case PartnerResult.NA:
        return "";
    }
  }
}

extension ApprovalStatusExtension on ApprovalStatus {
  String get label {
    switch (this) {
      case ApprovalStatus.Approved:
        return "Approved";
      case ApprovalStatus.Rejected:
        return "Rejected";
    }
  }
}
