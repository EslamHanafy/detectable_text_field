/// Sample Regular expressions to set the argument detectionRegExp
///
/// Supports English, Japanese, Korean, Spanish, Arabic, and Thai

const _symbols = '·・ー_';

const _numbers = '0-9０-９';

const _englishLetters = 'a-zA-Zａ-ｚＡ-Ｚ';

const _japaneseLetters = 'ぁ-んァ-ン一-龠';

const _koreanLetters = '\u1100-\u11FF\uAC00-\uD7A3';

const _spanishLetters = 'áàãâéêíóôõúüçÁÀÃÂÉÊÍÓÔÕÚÜÇ';

const _arabicLetters = '\u0621-\u064A';

const _thaiLetters = '\u0E00-\u0E7F';

const detectionContentLetters = _symbols +
    _numbers +
    _englishLetters +
    _japaneseLetters +
    _koreanLetters +
    _spanishLetters +
    _arabicLetters +
    _thaiLetters;

const urlRegexContent = "((http|https)://)?(www.)?" +
    "[-a-zA-Z0-9@:%._\\+~#?&//=]" +
    "{1,256}\\.[a-z]" +
    "{2,6}\\b([-a-zA-Z0-9@:%" +
    "._\\+~#?&//=]*)";

/// Regular expression to extract hashtag with spaces like (#tag1 #tag2)
///
/// Supports English, Japanese, Korean, Spanish, Arabic, and Thai
final hashTagRegExp = RegExp(
  "(?!\\n)(?:^|\\s)(#([$detectionContentLetters]+))",
  multiLine: true,
);

/// Regular expression to extract hashtag without spaces like (#tag1#tag2)
///
/// Supports English, Japanese, Korean, Spanish, Arabic, and Thai
final hashTagRegExpWithoutSpaces = RegExp(
  "(#([$detectionContentLetters]+))",
  multiLine: true,
);

final atSignRegExp = RegExp(
  "(?!\\n)(?:^|\\s)([@]([$detectionContentLetters]+))",
  multiLine: true,
);

final atSignRegExpWithoutSpaces = RegExp(
  "([@]([$detectionContentLetters]+))",
  multiLine: true,
);

final urlRegex = RegExp(
  urlRegexContent,
  multiLine: true,
);

/// Regular expression when you select decorateAtSign
final hashTagAtSignRegExp = RegExp(
  "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))",
  multiLine: true,
);

/// Regular expression when you select decorateAtSign
final hashTagAtSignRegExpWithoutSpaces = RegExp(
  "([#@]([$detectionContentLetters]+))",
  multiLine: true,
);

final hashTagUrlRegExp = RegExp(
  "(?!\\n)(?:^|\\s)([#]([$detectionContentLetters]+))|$urlRegexContent",
  multiLine: true,
);

final hashTagUrlRegExpWithoutSpaces = RegExp(
  "([#]([$detectionContentLetters]+))|$urlRegexContent",
  multiLine: true,
);

final hashTagAtSignUrlRegExp = RegExp(
  "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
  multiLine: true,
);

final hashTagAtSignUrlRegExpWithoutSpaces = RegExp(
  "([#@]([$detectionContentLetters]+))|$urlRegexContent",
  multiLine: true,
);

final atSignUrlRegExp = RegExp(
  "(?!\\n)(?:^|\\s)([@]([$detectionContentLetters]+))|$urlRegexContent",
  multiLine: true,
);

final atSignUrlRegExpWithoutSpaces = RegExp(
  "([@]([$detectionContentLetters]+))|$urlRegexContent",
  multiLine: true,
);

/// When `ignoreSpaces` = true it will detect elements without spaces like this (#tag1#tag2) and when it = false it will require spaces like this (#tag1 #tag2)
RegExp? detectionRegExp({
  bool hashtag = true,
  bool atSign = true,
  bool url = true,
  bool ignoreSpaces = true,
}) {
  if (hashtag == true && atSign == true && url == true) {
    return ignoreSpaces
        ? hashTagAtSignUrlRegExpWithoutSpaces
        : hashTagAtSignUrlRegExp;
  }
  if (hashtag == true) {
    if (atSign == true) {
      return ignoreSpaces
          ? hashTagAtSignRegExpWithoutSpaces
          : hashTagAtSignRegExp;
    }
    if (url == true) {
      return ignoreSpaces ? hashTagUrlRegExpWithoutSpaces : hashTagUrlRegExp;
    }
    return ignoreSpaces ? hashTagRegExpWithoutSpaces : hashTagRegExp;
  }

  if (atSign == true) {
    if (url == true) {
      return ignoreSpaces ? atSignUrlRegExpWithoutSpaces : atSignUrlRegExp;
    }
    return ignoreSpaces ? atSignRegExpWithoutSpaces : atSignRegExp;
  }

  if (url == true) {
    return urlRegex;
  }
  assert(false,
      "Unexpected condition: hashtag:$hashtag, atSign:$atSign, url:$url");
  return null;
}
