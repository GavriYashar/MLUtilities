classdef Char < int32
% enumeration of UTF-8 characters
%
%% DESCRIPTION
% This class defines a lot of different UTF-8 characters. To be plattform (Windows CP1252, Unix UTF-8) compatible you should
% use for all none standard ASCII symboles this enumeration class to add the correct characters.
% E.g. use util.Char.GREEK_SMALL_LETTER_BETA.char() instead of typing the characters directly in Windows editor
%
% >|•| HowTo add new symbols:
% goto: ftp://ftp.unicode.org/Public/UNIDATA/NamesList.txt
% notepad++
% • replace all with ""
%     "^\t.*"
%     ";.*"
%     "\n\s\n"
%     "^@.*"
% • "\r" with "\n"
% • "\n\n" with "\n"
% • "(\w)[ -](\w)" with "$1_$2"
% • "(^\w+)\t(.*)" with "$2    \(hex2dec\('$1'\)\)"
% • plugin: "Code Alignment" align by
%     "\(hex2dec"
%
% >|•| Alternative listings of all characters
% http://www.fileformat.info/info/unicode/
% http://www.utf8-chartable.de/
%
%% VERSIONING
%             Author: Andreas Justin
%      Creation date: 2015-10-23
%             Matlab: 9.7, (R2019b)
%  Required Products: -
%
%% REVISONS
% V1.0 | 2015-10-23 | Andreas Justin      | Ersterstellung
% V1.1 | 2018-01-09 | Martin Lechner      | Spaces added
% V1.2 | 2019-06-15 | Martin Lechner      | PER_MILLE_SIGN ‰ and PER_TEN_THOUSAND_SIGN added
% V1.3 | 2020-02-27 | Martin Lechner      | searchByRegex returns an array, stringChar implemented
%
% See also ftp://ftp.unicode.org/Public/UNIDATA/NamesList.txt
%
%% EXAMPLES
%{

% search a symbol in all defined UTF-8 characters of this enumeration class
util.Char.searchByRegex('beta')

% create the enumeration object for one of the search results
util.Char.GREEK_SMALL_LETTER_BETA

% use the character in text creation functions
util.Char.GREEK_SMALL_LETTER_BETA.char()

% prints all defined UTF-8 characters (display of all enumeration of this class)
util.Char.checkEnumCharsDisplayable()
% or
util.Char.dispAll()


% other examples
util.Char.GREEK_BETA_SYMBOL        
util.Char.GREEK_BETA_SYMBOL.toString

util.Char.searchByRegex('zero')
    
%}  
%% --------------------------------------------------------------------------------------------

methods
    function s = toString(enum)
        s = enum.string;
    end
    function list = search(enum, expr)
        idx = util.regexStr(enum.toString(), expr, true);
        list = enum(idx);
    end
    function s = char(enum)
        % returns this enum array as character array (all rows are interpreted as one char vector)
        s = builtin('char',enum);
    end
    function s = stringChar(enum)
        % returns an array of strings where each enumeration is converted to the corresponding character
        s = string(enum(:).char());
        s = reshape(s, size(enum));
    end
    function disp(enum)
        for ii = 1:numel(enum)
            fprintf('\t%s\t<\t(%s)\t\t%s\n',enum(ii), dec2hex(enum(ii)+0,4), enum(ii).toString);
        end
    end
end
methods (Static = true)
    function [members, names] = all()
        [members, names] = enumeration(mfilename("class"));
        names = string(names);
    end
    function m = searchByRegex(expr)
        % returns the Char's found by the regular search expression 'expr'. If no chars are found the returned list is
        % an empty (0x1) util.Char array
        m = util.Char.all();
        m = m.search(expr);
        if nargout < 1
            if ~isempty(m)
                fprintf('\n %i found with "%s"\n',numel(m),expr);
                for ii = 1:numel(m)
                    fprintf('\t%s\t<\t(%s)\t\t%s\n',m(ii), dec2hex(m(ii)+0,4), m(ii).toString)
                end
            else
                fprintf('\nnothing found with "%s"\n',expr);
            end
        end
    end
    function dispAll()
        util.Char.checkEnumCharsDisplayable()
    end
    function checkEnumCharsDisplayable()
        m = util.Char.all();
        fprintf('\n-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=')
        for ii = 1:numel(m)
            fprintf('\n\t%s\t<\t(%s)\t\t%s',m(ii), dec2hex(m(ii)+0,4), m(ii).toString);
        end
        fprintf('\n-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=-~=\n')
    end
end

%{
        0 0000 ... 007F: Basic Latin
      128 0080 ... 00FF: Latin-1 Supplement
      256 0100 ... 017F: Latin Extended-A
      384 0180 ... 024F: Latin Extended-B
      592 0250 ... 02AF: IPA Extensions
      688 02B0 ... 02FF: Spacing Modifier Letters
      768 0300 ... 036F: Combining Diacritical Marks
      880 0370 ... 03FF: Greek and Coptic
     1024 0400 ... 04FF: Cyrillic
     1280 0500 ... 052F: Cyrillic Supplement
     1328 0530 ... 058F: Armenian
     1424 0590 ... 05FF: Hebrew
     1536 0600 ... 06FF: Arabic
     1792 0700 ... 074F: Syriac
     1872 0750 ... 077F: Arabic Supplement
     1920 0780 ... 07BF: Thaana
     1984 07C0 ... 07FF: NKo
     2048 0800 ... 083F: Samaritan
     2112 0840 ... 085F: Mandaic
     2208 08A0 ... 08FF: Arabic Extended-A
     2304 0900 ... 097F: Devanagari
     2432 0980 ... 09FF: Bengali
     2560 0A00 ... 0A7F: Gurmukhi
     2688 0A80 ... 0AFF: Gujarati
     2816 0B00 ... 0B7F: Oriya
     2944 0B80 ... 0BFF: Tamil
     3072 0C00 ... 0C7F: Telugu
     3200 0C80 ... 0CFF: Kannada
     3328 0D00 ... 0D7F: Malayalam
     3456 0D80 ... 0DFF: Sinhala
     3584 0E00 ... 0E7F: Thai
     3712 0E80 ... 0EFF: Lao
     3840 0F00 ... 0FFF: Tibetan
     4096 1000 ... 109F: Myanmar
     4256 10A0 ... 10FF: Georgian
     4352 1100 ... 11FF: Hangul Jamo
     4608 1200 ... 137F: Ethiopic
     4992 1380 ... 139F: Ethiopic Supplement
     5024 13A0 ... 13FF: Cherokee
     5120 1400 ... 167F: Unified Canadian Aboriginal Syllabics
     5760 1680 ... 169F: Ogham
     5792 16A0 ... 16FF: Runic
     5888 1700 ... 171F: Tagalog
     5920 1720 ... 173F: Hanunoo
     5952 1740 ... 175F: Buhid
     5984 1760 ... 177F: Tagbanwa
     6016 1780 ... 17FF: Khmer
     6144 1800 ... 18AF: Mongolian
     6320 18B0 ... 18FF: Unified Canadian Aboriginal Syllabics Extended
     6400 1900 ... 194F: Limbu
     6480 1950 ... 197F: Tai Le
     6528 1980 ... 19DF: New Tai Lue
     6624 19E0 ... 19FF: Khmer Symbols
     6656 1A00 ... 1A1F: Buginese
     6688 1A20 ... 1AAF: Tai Tham
     6832 1AB0 ... 1AFF: Combining Diacritical Marks Extended
     6912 1B00 ... 1B7F: Balinese
     7040 1B80 ... 1BBF: Sundanese
     7104 1BC0 ... 1BFF: Batak
     7168 1C00 ... 1C4F: Lepcha
     7248 1C50 ... 1C7F: Ol Chiki
     7360 1CC0 ... 1CCF: Sundanese Supplement
     7376 1CD0 ... 1CFF: Vedic Extensions
     7424 1D00 ... 1D7F: Phonetic Extensions
     7552 1D80 ... 1DBF: Phonetic Extensions Supplement
     7616 1DC0 ... 1DFF: Combining Diacritical Marks Supplement
     7680 1E00 ... 1EFF: Latin Extended Additional
     7936 1F00 ... 1FFF: Greek Extended
     8192 2000 ... 206F: General Punctuation
     8304 2070 ... 209F: Superscripts and Subscripts
     8352 20A0 ... 20CF: Currency Symbols
     8400 20D0 ... 20FF: Combining Diacritical Marks for Symbols
     8448 2100 ... 214F: Letterlike Symbols
     8528 2150 ... 218F: Number Forms
     8592 2190 ... 21FF: Arrows
     8704 2200 ... 22FF: Mathematical Operators
     8960 2300 ... 23FF: Miscellaneous Technical
     9216 2400 ... 243F: Control Pictures
     9280 2440 ... 245F: Optical Character Recognition
     9312 2460 ... 24FF: Enclosed Alphanumerics
     9472 2500 ... 257F: Box Drawing
     9600 2580 ... 259F: Block Elements
     9632 25A0 ... 25FF: Geometric Shapes
     9728 2600 ... 26FF: Miscellaneous Symbols
     9984 2700 ... 27BF: Dingbats
    10176 27C0 ... 27EF: Miscellaneous Mathematical Symbols-A
    10224 27F0 ... 27FF: Supplemental Arrows-A
    10240 2800 ... 28FF: Braille Patterns
    10496 2900 ... 297F: Supplemental Arrows-B
    10624 2980 ... 29FF: Miscellaneous Mathematical Symbols-B
    10752 2A00 ... 2AFF: Supplemental Mathematical Operators
    11008 2B00 ... 2BFF: Miscellaneous Symbols and Arrows
    11264 2C00 ... 2C5F: Glagolitic
    11360 2C60 ... 2C7F: Latin Extended-C
    11392 2C80 ... 2CFF: Coptic
    11520 2D00 ... 2D2F: Georgian Supplement
    11568 2D30 ... 2D7F: Tifinagh
    11648 2D80 ... 2DDF: Ethiopic Extended
    11744 2DE0 ... 2DFF: Cyrillic Extended-A
    11776 2E00 ... 2E7F: Supplemental Punctuation
    11904 2E80 ... 2EFF: CJK Radicals Supplement
    12032 2F00 ... 2FDF: Kangxi Radicals
    12272 2FF0 ... 2FFF: Ideographic Description Characters
    12288 3000 ... 303F: CJK Symbols and Punctuation
    12352 3040 ... 309F: Hiragana
    12448 30A0 ... 30FF: Katakana
    12544 3100 ... 312F: Bopomofo
    12592 3130 ... 318F: Hangul Compatibility Jamo
    12688 3190 ... 319F: Kanbun
    12704 31A0 ... 31BF: Bopomofo Extended
    12736 31C0 ... 31EF: CJK Strokes
    12784 31F0 ... 31FF: Katakana Phonetic Extensions
    12800 3200 ... 32FF: Enclosed CJK Letters and Months
    13056 3300 ... 33FF: CJK Compatibility
    13312 3400 ... 4DBF: CJK Unified Ideographs Extension A
    19904 4DC0 ... 4DFF: Yijing Hexagram Symbols
    19968 4E00 ... 9FFF: CJK Unified Ideographs
    40960 A000 ... A48F: Yi Syllables
    42128 A490 ... A4CF: Yi Radicals
    42192 A4D0 ... A4FF: Lisu
    42240 A500 ... A63F: Vai
    42560 A640 ... A69F: Cyrillic Extended-B
    42656 A6A0 ... A6FF: Bamum
    42752 A700 ... A71F: Modifier Tone Letters
    42784 A720 ... A7FF: Latin Extended-D
    43008 A800 ... A82F: Syloti Nagri
    43056 A830 ... A83F: Common Indic Number Forms
    43072 A840 ... A87F: Phags-pa
    43136 A880 ... A8DF: Saurashtra
    43232 A8E0 ... A8FF: Devanagari Extended
    43264 A900 ... A92F: Kayah Li
    43312 A930 ... A95F: Rejang
    43360 A960 ... A97F: Hangul Jamo Extended-A
    43392 A980 ... A9DF: Javanese
    43488 A9E0 ... A9FF: Myanmar Extended-B
    43520 AA00 ... AA5F: Cham
    43616 AA60 ... AA7F: Myanmar Extended-A
    43648 AA80 ... AADF: Tai Viet
    43744 AAE0 ... AAFF: Meetei Mayek Extensions
    43776 AB00 ... AB2F: Ethiopic Extended-A
    43824 AB30 ... AB6F: Latin Extended-E
    43888 AB70 ... ABBF: Cherokee Supplement
    43968 ABC0 ... ABFF: Meetei Mayek
    44032 AC00 ... D7AF: Hangul Syllables
    55216 D7B0 ... D7FF: Hangul Jamo Extended-B
    55296 D800 ... DB7F: High Surrogates
    56192 DB80 ... DBFF: High Private Use Surrogates
    56320 DC00 ... DFFF: Low Surrogates
    57344 E000 ... F8FF: Private Use Area
    63744 F900 ... FAFF: CJK Compatibility Ideographs
    64256 FB00 ... FB4F: Alphabetic Presentation Forms
    64336 FB50 ... FDFF: Arabic Presentation Forms-A
    65024 FE00 ... FE0F: Variation Selectors
    65040 FE10 ... FE1F: Vertical Forms
    65056 FE20 ... FE2F: Combining Half Marks
    65072 FE30 ... FE4F: CJK Compatibility Forms
    65104 FE50 ... FE6F: Small Form Variants
    65136 FE70 ... FEFF: Arabic Presentation Forms-B
    65280 FF00 ... FFEF: Halfwidth and Fullwidth Forms
    65520 FFF0 ... FFFF: Specials
%}
enumeration
    ZWSP                    (hex2dec('200b'))   % Zero Width SPace
    SPACE                   (hex2dec('07D4'))   % space (like a normal space, but multiple space will stay in the HTML text)
    EN_SPACE                (hex2dec('2002'))   % space for the letter N
    EM_SPACE                (hex2dec('2003'))   % space for the letter M (bigger than N)

    THREE_PER_EM_SPACE      (hex2dec('2004'))   % one third of the space for the letter M
    FOUR_PER_EM_SPACE       (hex2dec('2005'))   % fourth part of the space for the letter M
    SIX_PER_EM_SPACE        (hex2dec('2006'))   % sixth part of the space for the letter M
    
    FIGURE_SPACE            (hex2dec('2007'))   % figure space (bigger than SPACE)
    PUNCTUATION_SPACE       (hex2dec('2008'))   % punctuation space (a little bit smaller than SPACE)
    THIN_SPACE              (hex2dec('2009'))   % thin space (a little bit smaller than PUNCTUATION_SPACE)
    HAIR_SPACE              (hex2dec('200A'))   % a hair space (praktisch nix)
    NARROW_NO_BREAK_SPACE   (hex2dec('202F'))   % thin space acc. ISO-NORM 31-0 for thousand separator
    
    BULLET                  (hex2dec('2022'))
    TRIANGULAR_BULLET       (hex2dec('2023'))
    HYPHEN_BULLET           (hex2dec('2043'))
    
    NEW_LINE                (hex2dec('000a')) % newline, char(10), hard return
    SOFT_RETURN             (hex2dec('000b')) % newline, char(11), soft return
    
    DASH_FIGURE         (hex2dec('2012'))
    DASH_EN             (hex2dec('2013'))
    DASH_EM             (hex2dec('2014'))
    DASH_HORIZONTAL_BAR (hex2dec('2015'))
    DASH_SWUNG          (hex2dec('2053'))

    SUPERSCRIPT_ZERO                    (hex2dec('2070'))
    SUPERSCRIPT_ONE                     (hex2dec('00b9'))
    SUPERSCRIPT_TWO                     (hex2dec('00b2'))
    SUPERSCRIPT_THREE                   (hex2dec('00b3'))
    SUPERSCRIPT_FOUR                    (hex2dec('2074'))
    SUPERSCRIPT_FIVE                    (hex2dec('2075'))
    SUPERSCRIPT_SIX                     (hex2dec('2076'))
    SUPERSCRIPT_SEVEN                   (hex2dec('2077'))
    SUPERSCRIPT_EIGHT                   (hex2dec('2078'))
    SUPERSCRIPT_NINE                    (hex2dec('2079'))
    SUPERSCRIPT_PLUS_SIGN               (hex2dec('207A'))
    SUPERSCRIPT_MINUS                   (hex2dec('207B'))
    SUPERSCRIPT_EQUALS_SIGN             (hex2dec('207C'))
    SUPERSCRIPT_LEFT_PARENTHESIS        (hex2dec('207D'))
    SUPERSCRIPT_RIGHT_PARENTHESIS       (hex2dec('207E'))
    SUPERSCRIPT_LATIN_SMALL_LETTER_N    (hex2dec('207F'))
    SUBSCRIPT_ZERO                      (hex2dec('2080'))
    SUBSCRIPT_ONE                       (hex2dec('2081'))
    SUBSCRIPT_TWO                       (hex2dec('2082'))
    SUBSCRIPT_THREE                     (hex2dec('2083'))
    SUBSCRIPT_FOUR                      (hex2dec('2084'))
    SUBSCRIPT_FIVE                      (hex2dec('2085'))
    SUBSCRIPT_SIX                       (hex2dec('2086'))
    SUBSCRIPT_SEVEN                     (hex2dec('2087'))
    SUBSCRIPT_EIGHT                     (hex2dec('2088'))
    SUBSCRIPT_NINE                      (hex2dec('2089'))
    SUBSCRIPT_PLUS_SIGN                 (hex2dec('208A'))
    SUBSCRIPT_MINUS                     (hex2dec('208B'))
    SUBSCRIPT_EQUALS_SIGN               (hex2dec('208C'))
    SUBSCRIPT_LEFT_PARENTHESIS          (hex2dec('208D'))
    SUBSCRIPT_RIGHT_PARENTHESIS         (hex2dec('208E'))

    PER_MILLE_SIGN                      (hex2dec('2030'))        % ‰, Alt+0137 = permille, per thousand
    PER_TEN_THOUSAND_SIGN               (hex2dec('2031'))        % '?', PER TEN THOUSAND SIGN, * percent of a percent, rarely used
    
    FOR_ALL                                                           (hex2dec('2200'))
    COMPLEMENT                                                        (hex2dec('2201'))
    PARTIAL_DIFFERENTIAL                                              (hex2dec('2202'))
    THERE_EXISTS                                                      (hex2dec('2203'))
    THERE_DOES_NOT_EXIST                                              (hex2dec('2204'))
    EMPTY_SET                                                         (hex2dec('2205'))
    INCREMENT                                                         (hex2dec('2206'))
    NABLA                                                             (hex2dec('2207'))
    ELEMENT_OF                                                        (hex2dec('2208'))
    NOT_AN_ELEMENT_OF                                                 (hex2dec('2209'))
    SMALL_ELEMENT_OF                                                  (hex2dec('220A'))
    CONTAINS_AS_MEMBER                                                (hex2dec('220B'))
    DOES_NOT_CONTAIN_AS_MEMBER                                        (hex2dec('220C'))
    SMALL_CONTAINS_AS_MEMBER                                          (hex2dec('220D'))
    END_OF_PROOF                                                      (hex2dec('220E'))
    N_ARY_PRODUCT                                                     (hex2dec('220F'))
    N_ARY_COPRODUCT                                                   (hex2dec('2210'))
    N_ARY_SUMMATION                                                   (hex2dec('2211'))
    MINUS_SIGN                                                        (hex2dec('2212'))
    MINUS_OR_PLUS_SIGN                                                (hex2dec('2213'))
    DOT_PLUS                                                          (hex2dec('2214'))
    DIVISION_SLASH                                                    (hex2dec('2215'))
    SET_MINUS                                                         (hex2dec('2216'))
    ASTERISK_OPERATOR                                                 (hex2dec('2217'))
    RING_OPERATOR                                                     (hex2dec('2218'))
    BULLET_OPERATOR                                                   (hex2dec('2219'))
    SQUARE_ROOT                                                       (hex2dec('221A'))
    CUBE_ROOT                                                         (hex2dec('221B'))
    FOURTH_ROOT                                                       (hex2dec('221C'))
    PROPORTIONAL_TO                                                   (hex2dec('221D'))
    INFINITY                                                          (hex2dec('221E'))
    RIGHT_ANGLE                                                       (hex2dec('221F'))
    ANGLE                                                             (hex2dec('2220'))
    MEASURED_ANGLE                                                    (hex2dec('2221'))
    SPHERICAL_ANGLE                                                   (hex2dec('2222'))
    DIVIDES                                                           (hex2dec('2223'))
    DOES_NOT_DIVIDE                                                   (hex2dec('2224'))
    PARALLEL_TO                                                       (hex2dec('2225'))
    NOT_PARALLEL_TO                                                   (hex2dec('2226'))
    LOGICAL_AND                                                       (hex2dec('2227'))
    LOGICAL_OR                                                        (hex2dec('2228'))
    INTERSECTION                                                      (hex2dec('2229'))
    UNION                                                             (hex2dec('222A'))
    INTEGRAL                                                          (hex2dec('222B'))
    DOUBLE_INTEGRAL                                                   (hex2dec('222C'))
    TRIPLE_INTEGRAL                                                   (hex2dec('222D'))
    CONTOUR_INTEGRAL                                                  (hex2dec('222E'))
    SURFACE_INTEGRAL                                                  (hex2dec('222F'))
    VOLUME_INTEGRAL                                                   (hex2dec('2230'))
    CLOCKWISE_INTEGRAL                                                (hex2dec('2231'))
    CLOCKWISE_CONTOUR_INTEGRAL                                        (hex2dec('2232'))
    ANTICLOCKWISE_CONTOUR_INTEGRAL                                    (hex2dec('2233'))
    THEREFORE                                                         (hex2dec('2234'))
    BECAUSE                                                           (hex2dec('2235'))
    RATIO                                                             (hex2dec('2236'))
    PROPORTION                                                        (hex2dec('2237'))
    DOT_MINUS                                                         (hex2dec('2238'))
    EXCESS                                                            (hex2dec('2239'))
    GEOMETRIC_PROPORTION                                              (hex2dec('223A'))
    HOMOTHETIC                                                        (hex2dec('223B'))
    TILDE_OPERATOR                                                    (hex2dec('223C'))
    REVERSED_TILDE                                                    (hex2dec('223D'))
    INVERTED_LAZY_S                                                   (hex2dec('223E'))
    SINE_WAVE                                                         (hex2dec('223F'))
    WREATH_PRODUCT                                                    (hex2dec('2240'))
    NOT_TILDE                                                         (hex2dec('2241'))
    MINUS_TILDE                                                       (hex2dec('2242'))
    ASYMPTOTICALLY_EQUAL_TO                                           (hex2dec('2243'))
    NOT_ASYMPTOTICALLY_EQUAL_TO                                       (hex2dec('2244'))
    APPROXIMATELY_EQUAL_TO                                            (hex2dec('2245'))
    APPROXIMATELY_BUT_NOT_ACTUALLY_EQUAL_TO                           (hex2dec('2246'))
    NEITHER_APPROXIMATELY_NOR_ACTUALLY_EQUAL_TO                       (hex2dec('2247'))
    ALMOST_EQUAL_TO                                                   (hex2dec('2248'))
    NOT_ALMOST_EQUAL_TO                                               (hex2dec('2249'))
    ALMOST_EQUAL_OR_EQUAL_TO                                          (hex2dec('224A'))
    TRIPLE_TILDE                                                      (hex2dec('224B'))
    ALL_EQUAL_TO                                                      (hex2dec('224C'))
    EQUIVALENT_TO                                                     (hex2dec('224D'))
    GEOMETRICALLY_EQUIVALENT_TO                                       (hex2dec('224E'))
    DIFFERENCE_BETWEEN                                                (hex2dec('224F'))
    APPROACHES_THE_LIMIT                                              (hex2dec('2250'))
    GEOMETRICALLY_EQUAL_TO                                            (hex2dec('2251'))
    APPROXIMATELY_EQUAL_TO_OR_THE_IMAGE_OF                            (hex2dec('2252'))
    IMAGE_OF_OR_APPROXIMATELY_EQUAL_TO                                (hex2dec('2253'))
    COLON_EQUALS                                                      (hex2dec('2254'))
    EQUALS_COLON                                                      (hex2dec('2255'))
    RING_IN_EQUAL_TO                                                  (hex2dec('2256'))
    RING_EQUAL_TO                                                     (hex2dec('2257'))
    CORRESPONDS_TO                                                    (hex2dec('2258'))
    ESTIMATES                                                         (hex2dec('2259'))
    EQUIANGULAR_TO                                                    (hex2dec('225A'))
    STAR_EQUALS                                                       (hex2dec('225B'))
    DELTA_EQUAL_TO                                                    (hex2dec('225C'))
    EQUAL_TO_BY_DEFINITION                                            (hex2dec('225D'))
    MEASURED_BY                                                       (hex2dec('225E'))
    QUESTIONED_EQUAL_TO                                               (hex2dec('225F'))
    NOT_EQUAL_TO                                                      (hex2dec('2260'))
    IDENTICAL_TO                                                      (hex2dec('2261'))
    NOT_IDENTICAL_TO                                                  (hex2dec('2262'))
    STRICTLY_EQUIVALENT_TO                                            (hex2dec('2263'))
    LESS_THAN_OR_EQUAL_TO                                             (hex2dec('2264'))
    GREATER_THAN_OR_EQUAL_TO                                          (hex2dec('2265'))
    LESS_THAN_OVER_EQUAL_TO                                           (hex2dec('2266'))
    GREATER_THAN_OVER_EQUAL_TO                                        (hex2dec('2267'))
    LESS_THAN_BUT_NOT_EQUAL_TO                                        (hex2dec('2268'))
    GREATER_THAN_BUT_NOT_EQUAL_TO                                     (hex2dec('2269'))
    MUCH_LESS_THAN                                                    (hex2dec('226A'))
    MUCH_GREATER_THAN                                                 (hex2dec('226B'))
    BETWEEN                                                           (hex2dec('226C'))
    NOT_EQUIVALENT_TO                                                 (hex2dec('226D'))
    NOT_LESS_THAN                                                     (hex2dec('226E'))
    NOT_GREATER_THAN                                                  (hex2dec('226F'))
    NEITHER_LESS_THAN_NOR_EQUAL_TO                                    (hex2dec('2270'))
    NEITHER_GREATER_THAN_NOR_EQUAL_TO                                 (hex2dec('2271'))
    LESS_THAN_OR_EQUIVALENT_TO                                        (hex2dec('2272'))
    GREATER_THAN_OR_EQUIVALENT_TO                                     (hex2dec('2273'))
    NEITHER_LESS_THAN_NOR_EQUIVALENT_TO                               (hex2dec('2274'))
    NEITHER_GREATER_THAN_NOR_EQUIVALENT_TO                            (hex2dec('2275'))
    LESS_THAN_OR_GREATER_THAN                                         (hex2dec('2276'))
    GREATER_THAN_OR_LESS_THAN                                         (hex2dec('2277'))
    NEITHER_LESS_THAN_NOR_GREATER_THAN                                (hex2dec('2278'))
    NEITHER_GREATER_THAN_NOR_LESS_THAN                                (hex2dec('2279'))
    PRECEDES                                                          (hex2dec('227A'))
    SUCCEEDS                                                          (hex2dec('227B'))
    PRECEDES_OR_EQUAL_TO                                              (hex2dec('227C'))
    SUCCEEDS_OR_EQUAL_TO                                              (hex2dec('227D'))
    PRECEDES_OR_EQUIVALENT_TO                                         (hex2dec('227E'))
    SUCCEEDS_OR_EQUIVALENT_TO                                         (hex2dec('227F'))
    DOES_NOT_PRECEDE                                                  (hex2dec('2280'))
    DOES_NOT_SUCCEED                                                  (hex2dec('2281'))
    SUBSET_OF                                                         (hex2dec('2282'))
    SUPERSET_OF                                                       (hex2dec('2283'))
    NOT_A_SUBSET_OF                                                   (hex2dec('2284'))
    NOT_A_SUPERSET_OF                                                 (hex2dec('2285'))
    SUBSET_OF_OR_EQUAL_TO                                             (hex2dec('2286'))
    SUPERSET_OF_OR_EQUAL_TO                                           (hex2dec('2287'))
    NEITHER_A_SUBSET_OF_NOR_EQUAL_TO                                  (hex2dec('2288'))
    NEITHER_A_SUPERSET_OF_NOR_EQUAL_TO                                (hex2dec('2289'))
    SUBSET_OF_WITH_NOT_EQUAL_TO                                       (hex2dec('228A'))
    SUPERSET_OF_WITH_NOT_EQUAL_TO                                     (hex2dec('228B'))
    MULTISET                                                          (hex2dec('228C'))
    MULTISET_MULTIPLICATION                                           (hex2dec('228D'))
    MULTISET_UNION                                                    (hex2dec('228E'))
    SQUARE_IMAGE_OF                                                   (hex2dec('228F'))
    SQUARE_ORIGINAL_OF                                                (hex2dec('2290'))
    SQUARE_IMAGE_OF_OR_EQUAL_TO                                       (hex2dec('2291'))
    SQUARE_ORIGINAL_OF_OR_EQUAL_TO                                    (hex2dec('2292'))
    SQUARE_CAP                                                        (hex2dec('2293'))
    SQUARE_CUP                                                        (hex2dec('2294'))
    CIRCLED_PLUS                                                      (hex2dec('2295'))
    CIRCLED_MINUS                                                     (hex2dec('2296'))
    CIRCLED_TIMES                                                     (hex2dec('2297'))
    CIRCLED_DIVISION_SLASH                                            (hex2dec('2298'))
    CIRCLED_DOT_OPERATOR                                              (hex2dec('2299'))
    CIRCLED_RING_OPERATOR                                             (hex2dec('229A'))
    CIRCLED_ASTERISK_OPERATOR                                         (hex2dec('229B'))
    CIRCLED_EQUALS                                                    (hex2dec('229C'))
    CIRCLED_DASH                                                      (hex2dec('229D'))
    SQUARED_PLUS                                                      (hex2dec('229E'))
    SQUARED_MINUS                                                     (hex2dec('229F'))
    SQUARED_TIMES                                                     (hex2dec('22A0'))
    SQUARED_DOT_OPERATOR                                              (hex2dec('22A1'))
    RIGHT_TACK                                                        (hex2dec('22A2'))
    LEFT_TACK                                                         (hex2dec('22A3'))
    DOWN_TACK                                                         (hex2dec('22A4'))
    UP_TACK                                                           (hex2dec('22A5'))
    ASSERTION                                                         (hex2dec('22A6'))
    MODELS                                                            (hex2dec('22A7'))
    TRUE                                                              (hex2dec('22A8'))
    FORCES                                                            (hex2dec('22A9'))
    TRIPLE_VERTICAL_BAR_RIGHT_TURNSTILE                               (hex2dec('22AA'))
    DOUBLE_VERTICAL_BAR_DOUBLE_RIGHT_TURNSTILE                        (hex2dec('22AB'))
    DOES_NOT_PROVE                                                    (hex2dec('22AC'))
    NOT_TRUE                                                          (hex2dec('22AD'))
    DOES_NOT_FORCE                                                    (hex2dec('22AE'))
    NEGATED_DOUBLE_VERTICAL_BAR_DOUBLE_RIGHT_TURNSTILE                (hex2dec('22AF'))
    PRECEDES_UNDER_RELATION                                           (hex2dec('22B0'))
    SUCCEEDS_UNDER_RELATION                                           (hex2dec('22B1'))
    NORMAL_SUBGROUP_OF                                                (hex2dec('22B2'))
    CONTAINS_AS_NORMAL_SUBGROUP                                       (hex2dec('22B3'))
    NORMAL_SUBGROUP_OF_OR_EQUAL_TO                                    (hex2dec('22B4'))
    CONTAINS_AS_NORMAL_SUBGROUP_OR_EQUAL_TO                           (hex2dec('22B5'))
    ORIGINAL_OF                                                       (hex2dec('22B6'))
    IMAGE_OF                                                          (hex2dec('22B7'))
    MULTIMAP                                                          (hex2dec('22B8'))
    HERMITIAN_CONJUGATE_MATRIX                                        (hex2dec('22B9'))
    INTERCALATE                                                       (hex2dec('22BA'))
    XOR                                                               (hex2dec('22BB'))
    NAND                                                              (hex2dec('22BC'))
    NOR                                                               (hex2dec('22BD'))
    RIGHT_ANGLE_WITH_ARC                                              (hex2dec('22BE'))
    RIGHT_TRIANGLE                                                    (hex2dec('22BF'))
    N_ARY_LOGICAL_AND                                                 (hex2dec('22C0'))
    N_ARY_LOGICAL_OR                                                  (hex2dec('22C1'))
    N_ARY_INTERSECTION                                                (hex2dec('22C2'))
    N_ARY_UNION                                                       (hex2dec('22C3'))
    DIAMOND_OPERATOR                                                  (hex2dec('22C4'))
    DOT_OPERATOR                                                      (hex2dec('22C5'))
    STAR_OPERATOR                                                     (hex2dec('22C6'))
    DIVISION_TIMES                                                    (hex2dec('22C7'))
    BOWTIE                                                            (hex2dec('22C8'))
    LEFT_NORMAL_FACTOR_SEMIDIRECT_PRODUCT                             (hex2dec('22C9'))
    RIGHT_NORMAL_FACTOR_SEMIDIRECT_PRODUCT                            (hex2dec('22CA'))
    LEFT_SEMIDIRECT_PRODUCT                                           (hex2dec('22CB'))
    RIGHT_SEMIDIRECT_PRODUCT                                          (hex2dec('22CC'))
    REVERSED_TILDE_EQUALS                                             (hex2dec('22CD'))
    CURLY_LOGICAL_OR                                                  (hex2dec('22CE'))
    CURLY_LOGICAL_AND                                                 (hex2dec('22CF'))
    DOUBLE_SUBSET                                                     (hex2dec('22D0'))
    DOUBLE_SUPERSET                                                   (hex2dec('22D1'))
    DOUBLE_INTERSECTION                                               (hex2dec('22D2'))
    DOUBLE_UNION                                                      (hex2dec('22D3'))
    PITCHFORK                                                         (hex2dec('22D4'))
    EQUAL_AND_PARALLEL_TO                                             (hex2dec('22D5'))
    LESS_THAN_WITH_DOT                                                (hex2dec('22D6'))
    GREATER_THAN_WITH_DOT                                             (hex2dec('22D7'))
    VERY_MUCH_LESS_THAN                                               (hex2dec('22D8'))
    VERY_MUCH_GREATER_THAN                                            (hex2dec('22D9'))
    LESS_THAN_EQUAL_TO_OR_GREATER_THAN                                (hex2dec('22DA'))
    GREATER_THAN_EQUAL_TO_OR_LESS_THAN                                (hex2dec('22DB'))
    EQUAL_TO_OR_LESS_THAN                                             (hex2dec('22DC'))
    EQUAL_TO_OR_GREATER_THAN                                          (hex2dec('22DD'))
    EQUAL_TO_OR_PRECEDES                                              (hex2dec('22DE'))
    EQUAL_TO_OR_SUCCEEDS                                              (hex2dec('22DF'))
    DOES_NOT_PRECEDE_OR_EQUAL                                         (hex2dec('22E0'))
    DOES_NOT_SUCCEED_OR_EQUAL                                         (hex2dec('22E1'))
    NOT_SQUARE_IMAGE_OF_OR_EQUAL_TO                                   (hex2dec('22E2'))
    NOT_SQUARE_ORIGINAL_OF_OR_EQUAL_TO                                (hex2dec('22E3'))
    SQUARE_IMAGE_OF_OR_NOT_EQUAL_TO                                   (hex2dec('22E4'))
    SQUARE_ORIGINAL_OF_OR_NOT_EQUAL_TO                                (hex2dec('22E5'))
    LESS_THAN_BUT_NOT_EQUIVALENT_TO                                   (hex2dec('22E6'))
    GREATER_THAN_BUT_NOT_EQUIVALENT_TO                                (hex2dec('22E7'))
    PRECEDES_BUT_NOT_EQUIVALENT_TO                                    (hex2dec('22E8'))
    SUCCEEDS_BUT_NOT_EQUIVALENT_TO                                    (hex2dec('22E9'))
    NOT_NORMAL_SUBGROUP_OF                                            (hex2dec('22EA'))
    DOES_NOT_CONTAIN_AS_NORMAL_SUBGROUP                               (hex2dec('22EB'))
    NOT_NORMAL_SUBGROUP_OF_OR_EQUAL_TO                                (hex2dec('22EC'))
    DOES_NOT_CONTAIN_AS_NORMAL_SUBGROUP_OR_EQUAL                      (hex2dec('22ED'))
    VERTICAL_ELLIPSIS                                                 (hex2dec('22EE'))
    MIDLINE_HORIZONTAL_ELLIPSIS                                       (hex2dec('22EF'))
    UP_RIGHT_DIAGONAL_ELLIPSIS                                        (hex2dec('22F0'))
    DOWN_RIGHT_DIAGONAL_ELLIPSIS                                      (hex2dec('22F1'))

    CHECK_MARK                                             (hex2dec('2713'))
    HEAVY_CHECK_MARK                                       (hex2dec('2714'))
    MULTIPLICATION_X                                       (hex2dec('2715'))
    HEAVY_MULTIPLICATION_X                                 (hex2dec('2716'))
    BALLOT_X                                               (hex2dec('2717'))
    HEAVY_BALLOT_X                                         (hex2dec('2718'))
    BLACK_QUESTION_MARK_ORNAMENT                           (hex2dec('2753'))
    HEAVY_EXCLAMATION_MARK_SYMBOL                          (hex2dec('2757'))
    
    GREEK_SMALL_REVERSED_LUNATE_SIGMA_SYMBOL               (hex2dec('037B'))
    GREEK_SMALL_DOTTED_LUNATE_SIGMA_SYMBOL                 (hex2dec('037C'))
    GREEK_SMALL_REVERSED_DOTTED_LUNATE_SIGMA_SYMBOL        (hex2dec('037D'))
    GREEK_CAPITAL_LETTER_ALPHA_WITH_TONOS                  (hex2dec('0386'))
    GREEK_CAPITAL_LETTER_EPSILON_WITH_TONOS                (hex2dec('0388'))
    GREEK_CAPITAL_LETTER_ETA_WITH_TONOS                    (hex2dec('0389'))
    GREEK_CAPITAL_LETTER_IOTA_WITH_TONOS                   (hex2dec('038A'))
    GREEK_CAPITAL_LETTER_OMICRON_WITH_TONOS                (hex2dec('038C'))
    GREEK_CAPITAL_LETTER_UPSILON_WITH_TONOS                (hex2dec('038E'))
    GREEK_CAPITAL_LETTER_OMEGA_WITH_TONOS                  (hex2dec('038F'))
    GREEK_SMALL_LETTER_IOTA_WITH_DIALYTIKA_AND_TONOS       (hex2dec('0390'))
    GREEK_CAPITAL_LETTER_ALPHA                             (hex2dec('0391'))
    GREEK_CAPITAL_LETTER_BETA                              (hex2dec('0392'))
    GREEK_CAPITAL_LETTER_GAMMA                             (hex2dec('0393'))
    GREEK_CAPITAL_LETTER_DELTA                             (hex2dec('0394'))
    GREEK_CAPITAL_LETTER_EPSILON                           (hex2dec('0395'))
    GREEK_CAPITAL_LETTER_ZETA                              (hex2dec('0396'))
    GREEK_CAPITAL_LETTER_ETA                               (hex2dec('0397'))
    GREEK_CAPITAL_LETTER_THETA                             (hex2dec('0398'))
    GREEK_CAPITAL_LETTER_IOTA                              (hex2dec('0399'))
    GREEK_CAPITAL_LETTER_KAPPA                             (hex2dec('039A'))
    GREEK_CAPITAL_LETTER_LAMDA                             (hex2dec('039B'))
    GREEK_CAPITAL_LETTER_MU                                (hex2dec('039C'))
    GREEK_CAPITAL_LETTER_NU                                (hex2dec('039D'))
    GREEK_CAPITAL_LETTER_XI                                (hex2dec('039E'))
    GREEK_CAPITAL_LETTER_OMICRON                           (hex2dec('039F'))
    GREEK_CAPITAL_LETTER_PI                                (hex2dec('03A0'))
    GREEK_CAPITAL_LETTER_RHO                               (hex2dec('03A1'))
    GREEK_CAPITAL_LETTER_SIGMA                             (hex2dec('03A3'))
    GREEK_CAPITAL_LETTER_TAU                               (hex2dec('03A4'))
    GREEK_CAPITAL_LETTER_UPSILON                           (hex2dec('03A5'))
    GREEK_CAPITAL_LETTER_PHI                               (hex2dec('03A6'))
    GREEK_CAPITAL_LETTER_CHI                               (hex2dec('03A7'))
    GREEK_CAPITAL_LETTER_PSI                               (hex2dec('03A8'))
    GREEK_CAPITAL_LETTER_OMEGA                             (hex2dec('03A9'))
    GREEK_CAPITAL_LETTER_IOTA_WITH_DIALYTIKA               (hex2dec('03AA'))
    GREEK_CAPITAL_LETTER_UPSILON_WITH_DIALYTIKA            (hex2dec('03AB'))
    GREEK_SMALL_LETTER_ALPHA_WITH_TONOS                    (hex2dec('03AC'))
    GREEK_SMALL_LETTER_EPSILON_WITH_TONOS                  (hex2dec('03AD'))
    GREEK_SMALL_LETTER_ETA_WITH_TONOS                      (hex2dec('03AE'))
    GREEK_SMALL_LETTER_IOTA_WITH_TONOS                     (hex2dec('03AF'))
    GREEK_SMALL_LETTER_UPSILON_WITH_DIALYTIKA_AND_TONOS    (hex2dec('03B0'))
    GREEK_SMALL_LETTER_ALPHA                               (hex2dec('03B1'))
    GREEK_SMALL_LETTER_BETA                                (hex2dec('03B2'))
    GREEK_SMALL_LETTER_GAMMA                               (hex2dec('03B3'))
    GREEK_SMALL_LETTER_DELTA                               (hex2dec('03B4'))
    GREEK_SMALL_LETTER_EPSILON                             (hex2dec('03B5'))
    GREEK_SMALL_LETTER_ZETA                                (hex2dec('03B6'))
    GREEK_SMALL_LETTER_ETA                                 (hex2dec('03B7'))
    GREEK_SMALL_LETTER_THETA                               (hex2dec('03B8'))
    GREEK_SMALL_LETTER_IOTA                                (hex2dec('03B9'))
    GREEK_SMALL_LETTER_KAPPA                               (hex2dec('03BA'))
    GREEK_SMALL_LETTER_LAMDA                               (hex2dec('03BB'))
    GREEK_SMALL_LETTER_MU                                  (hex2dec('03BC'))
    GREEK_SMALL_LETTER_NU                                  (hex2dec('03BD'))
    GREEK_SMALL_LETTER_XI                                  (hex2dec('03BE'))
    GREEK_SMALL_LETTER_OMICRON                             (hex2dec('03BF'))
    GREEK_SMALL_LETTER_PI                                  (hex2dec('03C0'))
    GREEK_SMALL_LETTER_RHO                                 (hex2dec('03C1'))
    GREEK_SMALL_LETTER_FINAL_SIGMA                         (hex2dec('03C2'))
    GREEK_SMALL_LETTER_SIGMA                               (hex2dec('03C3'))
    GREEK_SMALL_LETTER_TAU                                 (hex2dec('03C4'))
    GREEK_SMALL_LETTER_UPSILON                             (hex2dec('03C5'))
    GREEK_SMALL_LETTER_PHI                                 (hex2dec('03C6'))
    GREEK_SMALL_LETTER_CHI                                 (hex2dec('03C7'))
    GREEK_SMALL_LETTER_PSI                                 (hex2dec('03C8'))
    GREEK_SMALL_LETTER_OMEGA                               (hex2dec('03C9'))
    GREEK_SMALL_LETTER_IOTA_WITH_DIALYTIKA                 (hex2dec('03CA'))
    GREEK_SMALL_LETTER_UPSILON_WITH_DIALYTIKA              (hex2dec('03CB'))
    GREEK_SMALL_LETTER_OMICRON_WITH_TONOS                  (hex2dec('03CC'))
    GREEK_SMALL_LETTER_UPSILON_WITH_TONOS                  (hex2dec('03CD'))
    GREEK_SMALL_LETTER_OMEGA_WITH_TONOS                    (hex2dec('03CE'))
    GREEK_BETA_SYMBOL                                      (hex2dec('03D0'))
    GREEK_THETA_SYMBOL                                     (hex2dec('03D1'))
    GREEK_UPSILON_WITH_HOOK_SYMBOL                         (hex2dec('03D2'))
    GREEK_UPSILON_WITH_ACUTE_AND_HOOK_SYMBOL               (hex2dec('03D3'))
    GREEK_UPSILON_WITH_DIAERESIS_AND_HOOK_SYMBOL           (hex2dec('03D4'))
    GREEK_PHI_SYMBOL                                       (hex2dec('03D5'))
    GREEK_PI_SYMBOL                                        (hex2dec('03D6'))
    GREEK_KAI_SYMBOL                                       (hex2dec('03D7'))
    GREEK_LETTER_ARCHAIC_KOPPA                             (hex2dec('03D8'))
    GREEK_SMALL_LETTER_ARCHAIC_KOPPA                       (hex2dec('03D9'))
    GREEK_LETTER_STIGMA                                    (hex2dec('03DA'))
    GREEK_SMALL_LETTER_STIGMA                              (hex2dec('03DB'))
    GREEK_LETTER_DIGAMMA                                   (hex2dec('03DC'))
    GREEK_SMALL_LETTER_DIGAMMA                             (hex2dec('03DD'))
    GREEK_LETTER_KOPPA                                     (hex2dec('03DE'))
    GREEK_SMALL_LETTER_KOPPA                               (hex2dec('03DF'))
    GREEK_LETTER_SAMPI                                     (hex2dec('03E0'))
    GREEK_SMALL_LETTER_SAMPI                               (hex2dec('03E1'))
    COPTIC_CAPITAL_LETTER_SHEI                             (hex2dec('03E2'))
    COPTIC_SMALL_LETTER_SHEI                               (hex2dec('03E3'))
    COPTIC_CAPITAL_LETTER_FEI                              (hex2dec('03E4'))
    COPTIC_SMALL_LETTER_FEI                                (hex2dec('03E5'))
    COPTIC_CAPITAL_LETTER_KHEI                             (hex2dec('03E6'))
    COPTIC_SMALL_LETTER_KHEI                               (hex2dec('03E7'))
    COPTIC_CAPITAL_LETTER_HORI                             (hex2dec('03E8'))
    COPTIC_SMALL_LETTER_HORI                               (hex2dec('03E9'))
    COPTIC_CAPITAL_LETTER_GANGIA                           (hex2dec('03EA'))
    COPTIC_SMALL_LETTER_GANGIA                             (hex2dec('03EB'))
    COPTIC_CAPITAL_LETTER_SHIMA                            (hex2dec('03EC'))
    COPTIC_SMALL_LETTER_SHIMA                              (hex2dec('03ED'))
    COPTIC_CAPITAL_LETTER_DEI                              (hex2dec('03EE'))
    COPTIC_SMALL_LETTER_DEI                                (hex2dec('03EF'))
    GREEK_KAPPA_SYMBOL                                     (hex2dec('03F0'))
    GREEK_RHO_SYMBOL                                       (hex2dec('03F1'))
    GREEK_LUNATE_SIGMA_SYMBOL                              (hex2dec('03F2'))
    GREEK_LETTER_YOT                                       (hex2dec('03F3'))
    GREEK_CAPITAL_THETA_SYMBOL                             (hex2dec('03F4'))
    GREEK_LUNATE_EPSILON_SYMBOL                            (hex2dec('03F5'))
    GREEK_REVERSED_LUNATE_EPSILON_SYMBOL                   (hex2dec('03F6'))
    GREEK_CAPITAL_LETTER_SHO                               (hex2dec('03F7'))
    GREEK_SMALL_LETTER_SHO                                 (hex2dec('03F8'))
    GREEK_CAPITAL_LUNATE_SIGMA_SYMBOL                      (hex2dec('03F9'))
    GREEK_CAPITAL_LETTER_SAN                               (hex2dec('03FA'))
    GREEK_SMALL_LETTER_SAN                                 (hex2dec('03FB'))
    GREEK_RHO_WITH_STROKE_SYMBOL                           (hex2dec('03FC'))
    GREEK_CAPITAL_REVERSED_LUNATE_SIGMA_SYMBOL             (hex2dec('03FD'))
    GREEK_CAPITAL_DOTTED_LUNATE_SIGMA_SYMBOL               (hex2dec('03FE'))
    GREEK_CAPITAL_REVERSED_DOTTED_LUNATE_SIGMA_SYMBOL      (hex2dec('03FF'))

    % General Punctuation (0x2000 ... 0x206F)
    ONE_DOT_LEADER                                         (0x2024)
    TWO_DOT_LEADER                                         (0x2025)
    HORIZONTAL_ELLIPSIS                                    (0x2026)

    ACCOUNT_OF                                             (hex2dec('2100'))
    ADDRESSED_TO_THE_SUBJECT                               (hex2dec('2101'))
    DOUBLE_STRUCK_CAPITAL_C                                (hex2dec('2102'))
    DEGREE_CELSIUS                                         (hex2dec('2103'))
    CENTRE_LINE_SYMBOL                                     (hex2dec('2104'))
    CARE_OF                                                (hex2dec('2105'))
    CADA_UNA                                               (hex2dec('2106'))
    EULER_CONSTANT                                         (hex2dec('2107'))
    SCRUPLE                                                (hex2dec('2108'))
    DEGREE_FAHRENHEIT                                      (hex2dec('2109'))
    SCRIPT_SMALL_G                                         (hex2dec('210A'))
    SCRIPT_CAPITAL_H                                       (hex2dec('210B'))
    BLACK_LETTER_CAPITAL_H                                 (hex2dec('210C'))
    DOUBLE_STRUCK_CAPITAL_H                                (hex2dec('210D'))
    PLANCK_CONSTANT                                        (hex2dec('210E'))
    PLANCK_CONSTANT_OVER_TWO_PI                            (hex2dec('210F'))
    SCRIPT_CAPITAL_I                                       (hex2dec('2110'))
    BLACK_LETTER_CAPITAL_I                                 (hex2dec('2111'))
    SCRIPT_CAPITAL_L                                       (hex2dec('2112'))
    SCRIPT_SMALL_L                                         (hex2dec('2113'))
    L_B_BAR_SYMBOL                                         (hex2dec('2114'))
    DOUBLE_STRUCK_CAPITAL_N                                (hex2dec('2115'))
    NUMERO_SIGN                                            (hex2dec('2116'))
    SOUND_RECORDING_COPYRIGHT                              (hex2dec('2117'))
    SCRIPT_CAPITAL_P                                       (hex2dec('2118'))
    DOUBLE_STRUCK_CAPITAL_P                                (hex2dec('2119'))
    DOUBLE_STRUCK_CAPITAL_Q                                (hex2dec('211A'))
    SCRIPT_CAPITAL_R                                       (hex2dec('211B'))
    BLACK_LETTER_CAPITAL_R                                 (hex2dec('211C'))
    DOUBLE_STRUCK_CAPITAL_R                                (hex2dec('211D'))
    PRESCRIPTION_TAKE                                      (hex2dec('211E'))
    RESPONSE                                               (hex2dec('211F'))
    SERVICE_MARK                                           (hex2dec('2120'))
    TELEPHONE_SIGN                                         (hex2dec('2121'))
    TRADE_MARK_SIGN                                        (hex2dec('2122'))
    VERSICLE                                               (hex2dec('2123'))
    DOUBLE_STRUCK_CAPITAL_Z                                (hex2dec('2124'))
    OUNCE_SIGN                                             (hex2dec('2125'))
    OHM_SIGN                                               (hex2dec('2126'))
    INVERTED_OHM_SIGN                                      (hex2dec('2127'))
    BLACK_LETTER_CAPITAL_Z                                 (hex2dec('2128'))
    TURNED_GREEK_SMALL_LETTER_IOTA                         (hex2dec('2129'))
    KELVIN_SIGN                                            (hex2dec('212A'))
    ANGSTROM_SIGN                                          (hex2dec('212B'))
    SCRIPT_CAPITAL_B                                       (hex2dec('212C'))
    BLACK_LETTER_CAPITAL_C                                 (hex2dec('212D'))
    ESTIMATED_SYMBOL                                       (hex2dec('212E'))
    SCRIPT_SMALL_E                                         (hex2dec('212F'))
    SCRIPT_CAPITAL_E                                       (hex2dec('2130'))
    SCRIPT_CAPITAL_F                                       (hex2dec('2131'))
    TURNED_CAPITAL_F                                       (hex2dec('2132'))
    SCRIPT_CAPITAL_M                                       (hex2dec('2133'))
    SCRIPT_SMALL_O                                         (hex2dec('2134'))
    ALEF_SYMBOL                                            (hex2dec('2135'))
    BET_SYMBOL                                             (hex2dec('2136'))
    GIMEL_SYMBOL                                           (hex2dec('2137'))
    DALET_SYMBOL                                           (hex2dec('2138'))
    VULGAR_FRACTION_ONE_THIRD                              (hex2dec('2153'))
    VULGAR_FRACTION_TWO_THIRDS                             (hex2dec('2154'))
    VULGAR_FRACTION_ONE_FIFTH                              (hex2dec('2155'))
    VULGAR_FRACTION_TWO_FIFTHS                             (hex2dec('2156'))
    VULGAR_FRACTION_THREE_FIFTHS                           (hex2dec('2157'))
    VULGAR_FRACTION_FOUR_FIFTHS                            (hex2dec('2158'))
    VULGAR_FRACTION_ONE_SIXTH                              (hex2dec('2159'))
    VULGAR_FRACTION_FIVE_SIXTHS                            (hex2dec('215A'))
    VULGAR_FRACTION_ONE_EIGHTH                             (hex2dec('215B'))
    VULGAR_FRACTION_THREE_EIGHTHS                          (hex2dec('215C'))
    VULGAR_FRACTION_FIVE_EIGHTHS                           (hex2dec('215D'))
    VULGAR_FRACTION_SEVEN_EIGHTHS                          (hex2dec('215E'))
    FRACTION_NUMERATOR_ONE                                 (hex2dec('215F'))
    ROMAN_NUMERAL_ONE                                      (hex2dec('2160'))
    ROMAN_NUMERAL_TWO                                      (hex2dec('2161'))
    ROMAN_NUMERAL_THREE                                    (hex2dec('2162'))
    ROMAN_NUMERAL_FOUR                                     (hex2dec('2163'))
    ROMAN_NUMERAL_FIVE                                     (hex2dec('2164'))
    ROMAN_NUMERAL_SIX                                      (hex2dec('2165'))
    ROMAN_NUMERAL_SEVEN                                    (hex2dec('2166'))
    ROMAN_NUMERAL_EIGHT                                    (hex2dec('2167'))
    ROMAN_NUMERAL_NINE                                     (hex2dec('2168'))
    ROMAN_NUMERAL_TEN                                      (hex2dec('2169'))
    ROMAN_NUMERAL_ELEVEN                                   (hex2dec('216A'))
    ROMAN_NUMERAL_TWELVE                                   (hex2dec('216B'))
    ROMAN_NUMERAL_FIFTY                                    (hex2dec('216C'))
    ROMAN_NUMERAL_ONE_HUNDRED                              (hex2dec('216D'))
    ROMAN_NUMERAL_FIVE_HUNDRED                             (hex2dec('216E'))
    ROMAN_NUMERAL_ONE_THOUSAND                             (hex2dec('216F'))
    SMALL_ROMAN_NUMERAL_ONE                                (hex2dec('2170'))
    SMALL_ROMAN_NUMERAL_TWO                                (hex2dec('2171'))
    SMALL_ROMAN_NUMERAL_THREE                              (hex2dec('2172'))
    SMALL_ROMAN_NUMERAL_FOUR                               (hex2dec('2173'))
    SMALL_ROMAN_NUMERAL_FIVE                               (hex2dec('2174'))
    SMALL_ROMAN_NUMERAL_SIX                                (hex2dec('2175'))
    SMALL_ROMAN_NUMERAL_SEVEN                              (hex2dec('2176'))
    SMALL_ROMAN_NUMERAL_EIGHT                              (hex2dec('2177'))
    SMALL_ROMAN_NUMERAL_NINE                               (hex2dec('2178'))
    SMALL_ROMAN_NUMERAL_TEN                                (hex2dec('2179'))
    SMALL_ROMAN_NUMERAL_ELEVEN                             (hex2dec('217A'))
    SMALL_ROMAN_NUMERAL_TWELVE                             (hex2dec('217B'))
    SMALL_ROMAN_NUMERAL_FIFTY                              (hex2dec('217C'))
    SMALL_ROMAN_NUMERAL_ONE_HUNDRED                        (hex2dec('217D'))
    SMALL_ROMAN_NUMERAL_FIVE_HUNDRED                       (hex2dec('217E'))
    SMALL_ROMAN_NUMERAL_ONE_THOUSAND                       (hex2dec('217F'))
    ROMAN_NUMERAL_ONE_THOUSAND_C_D                         (hex2dec('2180'))
    ROMAN_NUMERAL_FIVE_THOUSAND                            (hex2dec('2181'))
    ROMAN_NUMERAL_TEN_THOUSAND                             (hex2dec('2182'))
    LEFTWARDS_ARROW                                        (hex2dec('2190'))
    UPWARDS_ARROW                                          (hex2dec('2191'))
    RIGHTWARDS_ARROW                                       (hex2dec('2192'))
    DOWNWARDS_ARROW                                        (hex2dec('2193'))
    LEFT_RIGHT_ARROW                                       (hex2dec('2194'))
    UP_DOWN_ARROW                                          (hex2dec('2195'))
    NORTH_WEST_ARROW                                       (hex2dec('2196'))
    NORTH_EAST_ARROW                                       (hex2dec('2197'))
    SOUTH_EAST_ARROW                                       (hex2dec('2198'))
    SOUTH_WEST_ARROW                                       (hex2dec('2199'))
    LEFTWARDS_ARROW_WITH_STROKE                            (hex2dec('219A'))
    RIGHTWARDS_ARROW_WITH_STROKE                           (hex2dec('219B'))
    LEFTWARDS_WAVE_ARROW                                   (hex2dec('219C'))
    RIGHTWARDS_WAVE_ARROW                                  (hex2dec('219D'))
    LEFTWARDS_TWO_HEADED_ARROW                             (hex2dec('219E'))
    UPWARDS_TWO_HEADED_ARROW                               (hex2dec('219F'))
    RIGHTWARDS_TWO_HEADED_ARROW                            (hex2dec('21A0'))
    DOWNWARDS_TWO_HEADED_ARROW                             (hex2dec('21A1'))
    LEFTWARDS_ARROW_WITH_TAIL                              (hex2dec('21A2'))
    RIGHTWARDS_ARROW_WITH_TAIL                             (hex2dec('21A3'))
    LEFTWARDS_ARROW_FROM_BAR                               (hex2dec('21A4'))
    UPWARDS_ARROW_FROM_BAR                                 (hex2dec('21A5'))
    RIGHTWARDS_ARROW_FROM_BAR                              (hex2dec('21A6'))
    DOWNWARDS_ARROW_FROM_BAR                               (hex2dec('21A7'))
    UP_DOWN_ARROW_WITH_BASE                                (hex2dec('21A8'))
    LEFTWARDS_ARROW_WITH_HOOK                              (hex2dec('21A9'))
    RIGHTWARDS_ARROW_WITH_HOOK                             (hex2dec('21AA'))
    LEFTWARDS_ARROW_WITH_LOOP                              (hex2dec('21AB'))
    RIGHTWARDS_ARROW_WITH_LOOP                             (hex2dec('21AC'))
    LEFT_RIGHT_WAVE_ARROW                                  (hex2dec('21AD'))
    LEFT_RIGHT_ARROW_WITH_STROKE                           (hex2dec('21AE'))
    DOWNWARDS_ZIGZAG_ARROW                                 (hex2dec('21AF'))
    UPWARDS_ARROW_WITH_TIP_LEFTWARDS                       (hex2dec('21B0'))
    UPWARDS_ARROW_WITH_TIP_RIGHTWARDS                      (hex2dec('21B1'))
    DOWNWARDS_ARROW_WITH_TIP_LEFTWARDS                     (hex2dec('21B2'))
    DOWNWARDS_ARROW_WITH_TIP_RIGHTWARDS                    (hex2dec('21B3'))
    RIGHTWARDS_ARROW_WITH_CORNER_DOWNWARDS                 (hex2dec('21B4'))
    DOWNWARDS_ARROW_WITH_CORNER_LEFTWARDS                  (hex2dec('21B5'))
    ANTICLOCKWISE_TOP_SEMICIRCLE_ARROW                     (hex2dec('21B6'))
    CLOCKWISE_TOP_SEMICIRCLE_ARROW                         (hex2dec('21B7'))
    NORTH_WEST_ARROW_TO_LONG_BAR                           (hex2dec('21B8'))
    LEFTWARDS_ARROW_TO_BAR_OVER_RIGHTWARDS_ARROW_TO_BAR    (hex2dec('21B9'))
    ANTICLOCKWISE_OPEN_CIRCLE_ARROW                        (hex2dec('21BA'))
    CLOCKWISE_OPEN_CIRCLE_ARROW                            (hex2dec('21BB'))
    LEFTWARDS_HARPOON_WITH_BARB_UPWARDS                    (hex2dec('21BC'))
    LEFTWARDS_HARPOON_WITH_BARB_DOWNWARDS                  (hex2dec('21BD'))
    UPWARDS_HARPOON_WITH_BARB_RIGHTWARDS                   (hex2dec('21BE'))
    UPWARDS_HARPOON_WITH_BARB_LEFTWARDS                    (hex2dec('21BF'))
    RIGHTWARDS_HARPOON_WITH_BARB_UPWARDS                   (hex2dec('21C0'))
    RIGHTWARDS_HARPOON_WITH_BARB_DOWNWARDS                 (hex2dec('21C1'))
    DOWNWARDS_HARPOON_WITH_BARB_RIGHTWARDS                 (hex2dec('21C2'))
    DOWNWARDS_HARPOON_WITH_BARB_LEFTWARDS                  (hex2dec('21C3'))
    RIGHTWARDS_ARROW_OVER_LEFTWARDS_ARROW                  (hex2dec('21C4'))
    UPWARDS_ARROW_LEFTWARDS_OF_DOWNWARDS_ARROW             (hex2dec('21C5'))
    LEFTWARDS_ARROW_OVER_RIGHTWARDS_ARROW                  (hex2dec('21C6'))
    LEFTWARDS_PAIRED_ARROWS                                (hex2dec('21C7'))
    UPWARDS_PAIRED_ARROWS                                  (hex2dec('21C8'))
    RIGHTWARDS_PAIRED_ARROWS                               (hex2dec('21C9'))
    DOWNWARDS_PAIRED_ARROWS                                (hex2dec('21CA'))
    LEFTWARDS_HARPOON_OVER_RIGHTWARDS_HARPOON              (hex2dec('21CB'))
    RIGHTWARDS_HARPOON_OVER_LEFTWARDS_HARPOON              (hex2dec('21CC'))
    LEFTWARDS_DOUBLE_ARROW_WITH_STROKE                     (hex2dec('21CD'))
    LEFT_RIGHT_DOUBLE_ARROW_WITH_STROKE                    (hex2dec('21CE'))
    RIGHTWARDS_DOUBLE_ARROW_WITH_STROKE                    (hex2dec('21CF'))
    LEFTWARDS_DOUBLE_ARROW                                 (hex2dec('21D0'))
    UPWARDS_DOUBLE_ARROW                                   (hex2dec('21D1'))
    RIGHTWARDS_DOUBLE_ARROW                                (hex2dec('21D2'))
    DOWNWARDS_DOUBLE_ARROW                                 (hex2dec('21D3'))
    LEFT_RIGHT_DOUBLE_ARROW                                (hex2dec('21D4'))
    UP_DOWN_DOUBLE_ARROW                                   (hex2dec('21D5'))
    NORTH_WEST_DOUBLE_ARROW                                (hex2dec('21D6'))
    NORTH_EAST_DOUBLE_ARROW                                (hex2dec('21D7'))
    SOUTH_EAST_DOUBLE_ARROW                                (hex2dec('21D8'))
    SOUTH_WEST_DOUBLE_ARROW                                (hex2dec('21D9'))
    LEFTWARDS_TRIPLE_ARROW                                 (hex2dec('21DA'))
    RIGHTWARDS_TRIPLE_ARROW                                (hex2dec('21DB'))
    LEFTWARDS_SQUIGGLE_ARROW                               (hex2dec('21DC'))
    RIGHTWARDS_SQUIGGLE_ARROW                              (hex2dec('21DD'))
    UPWARDS_ARROW_WITH_DOUBLE_STROKE                       (hex2dec('21DE'))
    DOWNWARDS_ARROW_WITH_DOUBLE_STROKE                     (hex2dec('21DF'))
    LEFTWARDS_DASHED_ARROW                                 (hex2dec('21E0'))
    UPWARDS_DASHED_ARROW                                   (hex2dec('21E1'))
    RIGHTWARDS_DASHED_ARROW                                (hex2dec('21E2'))
    DOWNWARDS_DASHED_ARROW                                 (hex2dec('21E3'))
    LEFTWARDS_ARROW_TO_BAR                                 (hex2dec('21E4'))
    RIGHTWARDS_ARROW_TO_BAR                                (hex2dec('21E5'))
    LEFTWARDS_WHITE_ARROW                                  (hex2dec('21E6'))
    UPWARDS_WHITE_ARROW                                    (hex2dec('21E7'))
    RIGHTWARDS_WHITE_ARROW                                 (hex2dec('21E8'))
    DOWNWARDS_WHITE_ARROW                                  (hex2dec('21E9'))
    UPWARDS_WHITE_ARROW_FROM_BAR                           (hex2dec('21EA'))

    CIRCLED_DIGIT_ONE                                        (hex2dec('2460'))
    CIRCLED_DIGIT_TWO                                        (hex2dec('2461'))
    CIRCLED_DIGIT_THREE                                      (hex2dec('2462'))
    CIRCLED_DIGIT_FOUR                                       (hex2dec('2463'))
    CIRCLED_DIGIT_FIVE                                       (hex2dec('2464'))
    CIRCLED_DIGIT_SIX                                        (hex2dec('2465'))
    CIRCLED_DIGIT_SEVEN                                      (hex2dec('2466'))
    CIRCLED_DIGIT_EIGHT                                      (hex2dec('2467'))
    CIRCLED_DIGIT_NINE                                       (hex2dec('2468'))
    CIRCLED_NUMBER_TEN                                       (hex2dec('2469'))
    CIRCLED_NUMBER_ELEVEN                                    (hex2dec('246A'))
    CIRCLED_NUMBER_TWELVE                                    (hex2dec('246B'))
    CIRCLED_NUMBER_THIRTEEN                                  (hex2dec('246C'))
    CIRCLED_NUMBER_FOURTEEN                                  (hex2dec('246D'))
    CIRCLED_NUMBER_FIFTEEN                                   (hex2dec('246E'))
    CIRCLED_NUMBER_SIXTEEN                                   (hex2dec('246F'))
    CIRCLED_NUMBER_SEVENTEEN                                 (hex2dec('2470'))
    CIRCLED_NUMBER_EIGHTEEN                                  (hex2dec('2471'))
    CIRCLED_NUMBER_NINETEEN                                  (hex2dec('2472'))
    CIRCLED_NUMBER_TWENTY                                    (hex2dec('2473'))
    PARENTHESIZED_DIGIT_ONE                                  (hex2dec('2474'))
    PARENTHESIZED_DIGIT_TWO                                  (hex2dec('2475'))
    PARENTHESIZED_DIGIT_THREE                                (hex2dec('2476'))
    PARENTHESIZED_DIGIT_FOUR                                 (hex2dec('2477'))
    PARENTHESIZED_DIGIT_FIVE                                 (hex2dec('2478'))
    PARENTHESIZED_DIGIT_SIX                                  (hex2dec('2479'))
    PARENTHESIZED_DIGIT_SEVEN                                (hex2dec('247A'))
    PARENTHESIZED_DIGIT_EIGHT                                (hex2dec('247B'))
    PARENTHESIZED_DIGIT_NINE                                 (hex2dec('247C'))
    PARENTHESIZED_NUMBER_TEN                                 (hex2dec('247D'))
    PARENTHESIZED_NUMBER_ELEVEN                              (hex2dec('247E'))
    PARENTHESIZED_NUMBER_TWELVE                              (hex2dec('247F'))
    PARENTHESIZED_NUMBER_THIRTEEN                            (hex2dec('2480'))
    PARENTHESIZED_NUMBER_FOURTEEN                            (hex2dec('2481'))
    PARENTHESIZED_NUMBER_FIFTEEN                             (hex2dec('2482'))
    PARENTHESIZED_NUMBER_SIXTEEN                             (hex2dec('2483'))
    PARENTHESIZED_NUMBER_SEVENTEEN                           (hex2dec('2484'))
    PARENTHESIZED_NUMBER_EIGHTEEN                            (hex2dec('2485'))
    PARENTHESIZED_NUMBER_NINETEEN                            (hex2dec('2486'))
    PARENTHESIZED_NUMBER_TWENTY                              (hex2dec('2487'))
    DIGIT_ONE_FULL_STOP                                      (hex2dec('2488'))
    DIGIT_TWO_FULL_STOP                                      (hex2dec('2489'))
    DIGIT_THREE_FULL_STOP                                    (hex2dec('248A'))
    DIGIT_FOUR_FULL_STOP                                     (hex2dec('248B'))
    DIGIT_FIVE_FULL_STOP                                     (hex2dec('248C'))
    DIGIT_SIX_FULL_STOP                                      (hex2dec('248D'))
    DIGIT_SEVEN_FULL_STOP                                    (hex2dec('248E'))
    DIGIT_EIGHT_FULL_STOP                                    (hex2dec('248F'))
    DIGIT_NINE_FULL_STOP                                     (hex2dec('2490'))
    NUMBER_TEN_FULL_STOP                                     (hex2dec('2491'))
    NUMBER_ELEVEN_FULL_STOP                                  (hex2dec('2492'))
    NUMBER_TWELVE_FULL_STOP                                  (hex2dec('2493'))
    NUMBER_THIRTEEN_FULL_STOP                                (hex2dec('2494'))
    NUMBER_FOURTEEN_FULL_STOP                                (hex2dec('2495'))
    NUMBER_FIFTEEN_FULL_STOP                                 (hex2dec('2496'))
    NUMBER_SIXTEEN_FULL_STOP                                 (hex2dec('2497'))
    NUMBER_SEVENTEEN_FULL_STOP                               (hex2dec('2498'))
    NUMBER_EIGHTEEN_FULL_STOP                                (hex2dec('2499'))
    NUMBER_NINETEEN_FULL_STOP                                (hex2dec('249A'))
    NUMBER_TWENTY_FULL_STOP                                  (hex2dec('249B'))
    PARENTHESIZED_LATIN_SMALL_LETTER_A                       (hex2dec('249C'))
    PARENTHESIZED_LATIN_SMALL_LETTER_B                       (hex2dec('249D'))
    PARENTHESIZED_LATIN_SMALL_LETTER_C                       (hex2dec('249E'))
    PARENTHESIZED_LATIN_SMALL_LETTER_D                       (hex2dec('249F'))
    PARENTHESIZED_LATIN_SMALL_LETTER_E                       (hex2dec('24A0'))
    PARENTHESIZED_LATIN_SMALL_LETTER_F                       (hex2dec('24A1'))
    PARENTHESIZED_LATIN_SMALL_LETTER_G                       (hex2dec('24A2'))
    PARENTHESIZED_LATIN_SMALL_LETTER_H                       (hex2dec('24A3'))
    PARENTHESIZED_LATIN_SMALL_LETTER_I                       (hex2dec('24A4'))
    PARENTHESIZED_LATIN_SMALL_LETTER_J                       (hex2dec('24A5'))
    PARENTHESIZED_LATIN_SMALL_LETTER_K                       (hex2dec('24A6'))
    PARENTHESIZED_LATIN_SMALL_LETTER_L                       (hex2dec('24A7'))
    PARENTHESIZED_LATIN_SMALL_LETTER_M                       (hex2dec('24A8'))
    PARENTHESIZED_LATIN_SMALL_LETTER_N                       (hex2dec('24A9'))
    PARENTHESIZED_LATIN_SMALL_LETTER_O                       (hex2dec('24AA'))
    PARENTHESIZED_LATIN_SMALL_LETTER_P                       (hex2dec('24AB'))
    PARENTHESIZED_LATIN_SMALL_LETTER_Q                       (hex2dec('24AC'))
    PARENTHESIZED_LATIN_SMALL_LETTER_R                       (hex2dec('24AD'))
    PARENTHESIZED_LATIN_SMALL_LETTER_S                       (hex2dec('24AE'))
    PARENTHESIZED_LATIN_SMALL_LETTER_T                       (hex2dec('24AF'))
    PARENTHESIZED_LATIN_SMALL_LETTER_U                       (hex2dec('24B0'))
    PARENTHESIZED_LATIN_SMALL_LETTER_V                       (hex2dec('24B1'))
    PARENTHESIZED_LATIN_SMALL_LETTER_W                       (hex2dec('24B2'))
    PARENTHESIZED_LATIN_SMALL_LETTER_X                       (hex2dec('24B3'))
    PARENTHESIZED_LATIN_SMALL_LETTER_Y                       (hex2dec('24B4'))
    PARENTHESIZED_LATIN_SMALL_LETTER_Z                       (hex2dec('24B5'))
    CIRCLED_LATIN_CAPITAL_LETTER_A                           (hex2dec('24B6'))
    CIRCLED_LATIN_CAPITAL_LETTER_B                           (hex2dec('24B7'))
    CIRCLED_LATIN_CAPITAL_LETTER_C                           (hex2dec('24B8'))
    CIRCLED_LATIN_CAPITAL_LETTER_D                           (hex2dec('24B9'))
    CIRCLED_LATIN_CAPITAL_LETTER_E                           (hex2dec('24BA'))
    CIRCLED_LATIN_CAPITAL_LETTER_F                           (hex2dec('24BB'))
    CIRCLED_LATIN_CAPITAL_LETTER_G                           (hex2dec('24BC'))
    CIRCLED_LATIN_CAPITAL_LETTER_H                           (hex2dec('24BD'))
    CIRCLED_LATIN_CAPITAL_LETTER_I                           (hex2dec('24BE'))
    CIRCLED_LATIN_CAPITAL_LETTER_J                           (hex2dec('24BF'))
    CIRCLED_LATIN_CAPITAL_LETTER_K                           (hex2dec('24C0'))
    CIRCLED_LATIN_CAPITAL_LETTER_L                           (hex2dec('24C1'))
    CIRCLED_LATIN_CAPITAL_LETTER_M                           (hex2dec('24C2'))
    CIRCLED_LATIN_CAPITAL_LETTER_N                           (hex2dec('24C3'))
    CIRCLED_LATIN_CAPITAL_LETTER_O                           (hex2dec('24C4'))
    CIRCLED_LATIN_CAPITAL_LETTER_P                           (hex2dec('24C5'))
    CIRCLED_LATIN_CAPITAL_LETTER_Q                           (hex2dec('24C6'))
    CIRCLED_LATIN_CAPITAL_LETTER_R                           (hex2dec('24C7'))
    CIRCLED_LATIN_CAPITAL_LETTER_S                           (hex2dec('24C8'))
    CIRCLED_LATIN_CAPITAL_LETTER_T                           (hex2dec('24C9'))
    CIRCLED_LATIN_CAPITAL_LETTER_U                           (hex2dec('24CA'))
    CIRCLED_LATIN_CAPITAL_LETTER_V                           (hex2dec('24CB'))
    CIRCLED_LATIN_CAPITAL_LETTER_W                           (hex2dec('24CC'))
    CIRCLED_LATIN_CAPITAL_LETTER_X                           (hex2dec('24CD'))
    CIRCLED_LATIN_CAPITAL_LETTER_Y                           (hex2dec('24CE'))
    CIRCLED_LATIN_CAPITAL_LETTER_Z                           (hex2dec('24CF'))
    CIRCLED_LATIN_SMALL_LETTER_A                             (hex2dec('24D0'))
    CIRCLED_LATIN_SMALL_LETTER_B                             (hex2dec('24D1'))
    CIRCLED_LATIN_SMALL_LETTER_C                             (hex2dec('24D2'))
    CIRCLED_LATIN_SMALL_LETTER_D                             (hex2dec('24D3'))
    CIRCLED_LATIN_SMALL_LETTER_E                             (hex2dec('24D4'))
    CIRCLED_LATIN_SMALL_LETTER_F                             (hex2dec('24D5'))
    CIRCLED_LATIN_SMALL_LETTER_G                             (hex2dec('24D6'))
    CIRCLED_LATIN_SMALL_LETTER_H                             (hex2dec('24D7'))
    CIRCLED_LATIN_SMALL_LETTER_I                             (hex2dec('24D8'))
    CIRCLED_LATIN_SMALL_LETTER_J                             (hex2dec('24D9'))
    CIRCLED_LATIN_SMALL_LETTER_K                             (hex2dec('24DA'))
    CIRCLED_LATIN_SMALL_LETTER_L                             (hex2dec('24DB'))
    CIRCLED_LATIN_SMALL_LETTER_M                             (hex2dec('24DC'))
    CIRCLED_LATIN_SMALL_LETTER_N                             (hex2dec('24DD'))
    CIRCLED_LATIN_SMALL_LETTER_O                             (hex2dec('24DE'))
    CIRCLED_LATIN_SMALL_LETTER_P                             (hex2dec('24DF'))
    CIRCLED_LATIN_SMALL_LETTER_Q                             (hex2dec('24E0'))
    CIRCLED_LATIN_SMALL_LETTER_R                             (hex2dec('24E1'))
    CIRCLED_LATIN_SMALL_LETTER_S                             (hex2dec('24E2'))
    CIRCLED_LATIN_SMALL_LETTER_T                             (hex2dec('24E3'))
    CIRCLED_LATIN_SMALL_LETTER_U                             (hex2dec('24E4'))
    CIRCLED_LATIN_SMALL_LETTER_V                             (hex2dec('24E5'))
    CIRCLED_LATIN_SMALL_LETTER_W                             (hex2dec('24E6'))
    CIRCLED_LATIN_SMALL_LETTER_X                             (hex2dec('24E7'))
    CIRCLED_LATIN_SMALL_LETTER_Y                             (hex2dec('24E8'))
    CIRCLED_LATIN_SMALL_LETTER_Z                             (hex2dec('24E9'))
    CIRCLED_DIGIT_ZERO                                       (hex2dec('24EA'))
    NEGATIVE_CIRCLED_NUMBER_ELEVEN                           (hex2dec('24EB'))
    NEGATIVE_CIRCLED_NUMBER_TWELVE                           (hex2dec('24EC'))
    NEGATIVE_CIRCLED_NUMBER_THIRTEEN                         (hex2dec('24ED'))
    NEGATIVE_CIRCLED_NUMBER_FOURTEEN                         (hex2dec('24EE'))
    NEGATIVE_CIRCLED_NUMBER_FIFTEEN                          (hex2dec('24EF'))
    NEGATIVE_CIRCLED_NUMBER_SIXTEEN                          (hex2dec('24F0'))
    NEGATIVE_CIRCLED_NUMBER_SEVENTEEN                        (hex2dec('24F1'))
    NEGATIVE_CIRCLED_NUMBER_EIGHTEEN                         (hex2dec('24F2'))
    NEGATIVE_CIRCLED_NUMBER_NINETEEN                         (hex2dec('24F3'))
    NEGATIVE_CIRCLED_NUMBER_TWENTY                           (hex2dec('24F4'))
    DOUBLE_CIRCLED_DIGIT_ONE                                 (hex2dec('24F5'))
    DOUBLE_CIRCLED_DIGIT_TWO                                 (hex2dec('24F6'))
    DOUBLE_CIRCLED_DIGIT_THREE                               (hex2dec('24F7'))
    DOUBLE_CIRCLED_DIGIT_FOUR                                (hex2dec('24F8'))
    DOUBLE_CIRCLED_DIGIT_FIVE                                (hex2dec('24F9'))
    DOUBLE_CIRCLED_DIGIT_SIX                                 (hex2dec('24FA'))
    DOUBLE_CIRCLED_DIGIT_SEVEN                               (hex2dec('24FB'))
    DOUBLE_CIRCLED_DIGIT_EIGHT                               (hex2dec('24FC'))
    DOUBLE_CIRCLED_DIGIT_NINE                                (hex2dec('24FD'))
    DOUBLE_CIRCLED_NUMBER_TEN                                (hex2dec('24FE'))
    
    
    BOX_DRAWINGS_LIGHT_HORIZONTAL                            (hex2dec('2500'))
    BOX_DRAWINGS_HEAVY_HORIZONTAL                            (hex2dec('2501'))
    BOX_DRAWINGS_LIGHT_VERTICAL                              (hex2dec('2502'))
    BOX_DRAWINGS_HEAVY_VERTICAL                              (hex2dec('2503'))
    BOX_DRAWINGS_LIGHT_TRIPLE_DASH_HORIZONTAL                (hex2dec('2504'))
    BOX_DRAWINGS_HEAVY_TRIPLE_DASH_HORIZONTAL                (hex2dec('2505'))
    BOX_DRAWINGS_LIGHT_TRIPLE_DASH_VERTICAL                  (hex2dec('2506'))
    BOX_DRAWINGS_HEAVY_TRIPLE_DASH_VERTICAL                  (hex2dec('2507'))
    BOX_DRAWINGS_LIGHT_QUADRUPLE_DASH_HORIZONTAL             (hex2dec('2508'))
    BOX_DRAWINGS_HEAVY_QUADRUPLE_DASH_HORIZONTAL             (hex2dec('2509'))
    BOX_DRAWINGS_LIGHT_QUADRUPLE_DASH_VERTICAL               (hex2dec('250A'))
    BOX_DRAWINGS_HEAVY_QUADRUPLE_DASH_VERTICAL               (hex2dec('250B'))
    BOX_DRAWINGS_LIGHT_DOWN_AND_RIGHT                        (hex2dec('250C'))
    BOX_DRAWINGS_DOWN_LIGHT_AND_RIGHT_HEAVY                  (hex2dec('250D'))
    BOX_DRAWINGS_DOWN_HEAVY_AND_RIGHT_LIGHT                  (hex2dec('250E'))
    BOX_DRAWINGS_HEAVY_DOWN_AND_RIGHT                        (hex2dec('250F'))
    BOX_DRAWINGS_LIGHT_DOWN_AND_LEFT                         (hex2dec('2510'))
    BOX_DRAWINGS_DOWN_LIGHT_AND_LEFT_HEAVY                   (hex2dec('2511'))
    BOX_DRAWINGS_DOWN_HEAVY_AND_LEFT_LIGHT                   (hex2dec('2512'))
    BOX_DRAWINGS_HEAVY_DOWN_AND_LEFT                         (hex2dec('2513'))
    BOX_DRAWINGS_LIGHT_UP_AND_RIGHT                          (hex2dec('2514'))
    BOX_DRAWINGS_UP_LIGHT_AND_RIGHT_HEAVY                    (hex2dec('2515'))
    BOX_DRAWINGS_UP_HEAVY_AND_RIGHT_LIGHT                    (hex2dec('2516'))
    BOX_DRAWINGS_HEAVY_UP_AND_RIGHT                          (hex2dec('2517'))
    BOX_DRAWINGS_LIGHT_UP_AND_LEFT                           (hex2dec('2518'))
    BOX_DRAWINGS_UP_LIGHT_AND_LEFT_HEAVY                     (hex2dec('2519'))
    BOX_DRAWINGS_UP_HEAVY_AND_LEFT_LIGHT                     (hex2dec('251A'))
    BOX_DRAWINGS_HEAVY_UP_AND_LEFT                           (hex2dec('251B'))
    BOX_DRAWINGS_LIGHT_VERTICAL_AND_RIGHT                    (hex2dec('251C'))
    BOX_DRAWINGS_VERTICAL_LIGHT_AND_RIGHT_HEAVY              (hex2dec('251D'))
    BOX_DRAWINGS_UP_HEAVY_AND_RIGHT_DOWN_LIGHT               (hex2dec('251E'))
    BOX_DRAWINGS_DOWN_HEAVY_AND_RIGHT_UP_LIGHT               (hex2dec('251F'))
    BOX_DRAWINGS_VERTICAL_HEAVY_AND_RIGHT_LIGHT              (hex2dec('2520'))
    BOX_DRAWINGS_DOWN_LIGHT_AND_RIGHT_UP_HEAVY               (hex2dec('2521'))
    BOX_DRAWINGS_UP_LIGHT_AND_RIGHT_DOWN_HEAVY               (hex2dec('2522'))
    BOX_DRAWINGS_HEAVY_VERTICAL_AND_RIGHT                    (hex2dec('2523'))
    BOX_DRAWINGS_LIGHT_VERTICAL_AND_LEFT                     (hex2dec('2524'))
    BOX_DRAWINGS_VERTICAL_LIGHT_AND_LEFT_HEAVY               (hex2dec('2525'))
    BOX_DRAWINGS_UP_HEAVY_AND_LEFT_DOWN_LIGHT                (hex2dec('2526'))
    BOX_DRAWINGS_DOWN_HEAVY_AND_LEFT_UP_LIGHT                (hex2dec('2527'))
    BOX_DRAWINGS_VERTICAL_HEAVY_AND_LEFT_LIGHT               (hex2dec('2528'))
    BOX_DRAWINGS_DOWN_LIGHT_AND_LEFT_UP_HEAVY                (hex2dec('2529'))
    BOX_DRAWINGS_UP_LIGHT_AND_LEFT_DOWN_HEAVY                (hex2dec('252A'))
    BOX_DRAWINGS_HEAVY_VERTICAL_AND_LEFT                     (hex2dec('252B'))
    BOX_DRAWINGS_LIGHT_DOWN_AND_HORIZONTAL                   (hex2dec('252C'))
    BOX_DRAWINGS_LEFT_HEAVY_AND_RIGHT_DOWN_LIGHT             (hex2dec('252D'))
    BOX_DRAWINGS_RIGHT_HEAVY_AND_LEFT_DOWN_LIGHT             (hex2dec('252E'))
    BOX_DRAWINGS_DOWN_LIGHT_AND_HORIZONTAL_HEAVY             (hex2dec('252F'))
    BOX_DRAWINGS_DOWN_HEAVY_AND_HORIZONTAL_LIGHT             (hex2dec('2530'))
    BOX_DRAWINGS_RIGHT_LIGHT_AND_LEFT_DOWN_HEAVY             (hex2dec('2531'))
    BOX_DRAWINGS_LEFT_LIGHT_AND_RIGHT_DOWN_HEAVY             (hex2dec('2532'))
    BOX_DRAWINGS_HEAVY_DOWN_AND_HORIZONTAL                   (hex2dec('2533'))
    BOX_DRAWINGS_LIGHT_UP_AND_HORIZONTAL                     (hex2dec('2534'))
    BOX_DRAWINGS_LEFT_HEAVY_AND_RIGHT_UP_LIGHT               (hex2dec('2535'))
    BOX_DRAWINGS_RIGHT_HEAVY_AND_LEFT_UP_LIGHT               (hex2dec('2536'))
    BOX_DRAWINGS_UP_LIGHT_AND_HORIZONTAL_HEAVY               (hex2dec('2537'))
    BOX_DRAWINGS_UP_HEAVY_AND_HORIZONTAL_LIGHT               (hex2dec('2538'))
    BOX_DRAWINGS_RIGHT_LIGHT_AND_LEFT_UP_HEAVY               (hex2dec('2539'))
    BOX_DRAWINGS_LEFT_LIGHT_AND_RIGHT_UP_HEAVY               (hex2dec('253A'))
    BOX_DRAWINGS_HEAVY_UP_AND_HORIZONTAL                     (hex2dec('253B'))
    BOX_DRAWINGS_LIGHT_VERTICAL_AND_HORIZONTAL               (hex2dec('253C'))
    BOX_DRAWINGS_LEFT_HEAVY_AND_RIGHT_VERTICAL_LIGHT         (hex2dec('253D'))
    BOX_DRAWINGS_RIGHT_HEAVY_AND_LEFT_VERTICAL_LIGHT         (hex2dec('253E'))
    BOX_DRAWINGS_VERTICAL_LIGHT_AND_HORIZONTAL_HEAVY         (hex2dec('253F'))
    BOX_DRAWINGS_UP_HEAVY_AND_DOWN_HORIZONTAL_LIGHT          (hex2dec('2540'))
    BOX_DRAWINGS_DOWN_HEAVY_AND_UP_HORIZONTAL_LIGHT          (hex2dec('2541'))
    BOX_DRAWINGS_VERTICAL_HEAVY_AND_HORIZONTAL_LIGHT         (hex2dec('2542'))
    BOX_DRAWINGS_LEFT_UP_HEAVY_AND_RIGHT_DOWN_LIGHT          (hex2dec('2543'))
    BOX_DRAWINGS_RIGHT_UP_HEAVY_AND_LEFT_DOWN_LIGHT          (hex2dec('2544'))
    BOX_DRAWINGS_LEFT_DOWN_HEAVY_AND_RIGHT_UP_LIGHT          (hex2dec('2545'))
    BOX_DRAWINGS_RIGHT_DOWN_HEAVY_AND_LEFT_UP_LIGHT          (hex2dec('2546'))
    BOX_DRAWINGS_DOWN_LIGHT_AND_UP_HORIZONTAL_HEAVY          (hex2dec('2547'))
    BOX_DRAWINGS_UP_LIGHT_AND_DOWN_HORIZONTAL_HEAVY          (hex2dec('2548'))
    BOX_DRAWINGS_RIGHT_LIGHT_AND_LEFT_VERTICAL_HEAVY         (hex2dec('2549'))
    BOX_DRAWINGS_LEFT_LIGHT_AND_RIGHT_VERTICAL_HEAVY         (hex2dec('254A'))
    BOX_DRAWINGS_HEAVY_VERTICAL_AND_HORIZONTAL               (hex2dec('254B'))
    BOX_DRAWINGS_LIGHT_DOUBLE_DASH_HORIZONTAL                (hex2dec('254C'))
    BOX_DRAWINGS_HEAVY_DOUBLE_DASH_HORIZONTAL                (hex2dec('254D'))
    BOX_DRAWINGS_LIGHT_DOUBLE_DASH_VERTICAL                  (hex2dec('254E'))
    BOX_DRAWINGS_HEAVY_DOUBLE_DASH_VERTICAL                  (hex2dec('254F'))
    BOX_DRAWINGS_DOUBLE_HORIZONTAL                           (hex2dec('2550'))
    BOX_DRAWINGS_DOUBLE_VERTICAL                             (hex2dec('2551'))
    BOX_DRAWINGS_DOWN_SINGLE_AND_RIGHT_DOUBLE                (hex2dec('2552'))
    BOX_DRAWINGS_DOWN_DOUBLE_AND_RIGHT_SINGLE                (hex2dec('2553'))
    BOX_DRAWINGS_DOUBLE_DOWN_AND_RIGHT                       (hex2dec('2554'))
    BOX_DRAWINGS_DOWN_SINGLE_AND_LEFT_DOUBLE                 (hex2dec('2555'))
    BOX_DRAWINGS_DOWN_DOUBLE_AND_LEFT_SINGLE                 (hex2dec('2556'))
    BOX_DRAWINGS_DOUBLE_DOWN_AND_LEFT                        (hex2dec('2557'))
    BOX_DRAWINGS_UP_SINGLE_AND_RIGHT_DOUBLE                  (hex2dec('2558'))
    BOX_DRAWINGS_UP_DOUBLE_AND_RIGHT_SINGLE                  (hex2dec('2559'))
    BOX_DRAWINGS_DOUBLE_UP_AND_RIGHT                         (hex2dec('255A'))
    BOX_DRAWINGS_UP_SINGLE_AND_LEFT_DOUBLE                   (hex2dec('255B'))
    BOX_DRAWINGS_UP_DOUBLE_AND_LEFT_SINGLE                   (hex2dec('255C'))
    BOX_DRAWINGS_DOUBLE_UP_AND_LEFT                          (hex2dec('255D'))
    BOX_DRAWINGS_VERTICAL_SINGLE_AND_RIGHT_DOUBLE            (hex2dec('255E'))
    BOX_DRAWINGS_VERTICAL_DOUBLE_AND_RIGHT_SINGLE            (hex2dec('255F'))
    BOX_DRAWINGS_DOUBLE_VERTICAL_AND_RIGHT                   (hex2dec('2560'))
    BOX_DRAWINGS_VERTICAL_SINGLE_AND_LEFT_DOUBLE             (hex2dec('2561'))
    BOX_DRAWINGS_VERTICAL_DOUBLE_AND_LEFT_SINGLE             (hex2dec('2562'))
    BOX_DRAWINGS_DOUBLE_VERTICAL_AND_LEFT                    (hex2dec('2563'))
    BOX_DRAWINGS_DOWN_SINGLE_AND_HORIZONTAL_DOUBLE           (hex2dec('2564'))
    BOX_DRAWINGS_DOWN_DOUBLE_AND_HORIZONTAL_SINGLE           (hex2dec('2565'))
    BOX_DRAWINGS_DOUBLE_DOWN_AND_HORIZONTAL                  (hex2dec('2566'))
    BOX_DRAWINGS_UP_SINGLE_AND_HORIZONTAL_DOUBLE             (hex2dec('2567'))
    BOX_DRAWINGS_UP_DOUBLE_AND_HORIZONTAL_SINGLE             (hex2dec('2568'))
    BOX_DRAWINGS_DOUBLE_UP_AND_HORIZONTAL                    (hex2dec('2569'))
    BOX_DRAWINGS_VERTICAL_SINGLE_AND_HORIZONTAL_DOUBLE       (hex2dec('256A'))
    BOX_DRAWINGS_VERTICAL_DOUBLE_AND_HORIZONTAL_SINGLE       (hex2dec('256B'))
    BOX_DRAWINGS_DOUBLE_VERTICAL_AND_HORIZONTAL              (hex2dec('256C'))
    BOX_DRAWINGS_LIGHT_ARC_DOWN_AND_RIGHT                    (hex2dec('256D'))
    BOX_DRAWINGS_LIGHT_ARC_DOWN_AND_LEFT                     (hex2dec('256E'))
    BOX_DRAWINGS_LIGHT_ARC_UP_AND_LEFT                       (hex2dec('256F'))
    BOX_DRAWINGS_LIGHT_ARC_UP_AND_RIGHT                      (hex2dec('2570'))
    BOX_DRAWINGS_LIGHT_DIAGONAL_UPPER_RIGHT_TO_LOWER_LEFT    (hex2dec('2571'))
    BOX_DRAWINGS_LIGHT_DIAGONAL_UPPER_LEFT_TO_LOWER_RIGHT    (hex2dec('2572'))
    BOX_DRAWINGS_LIGHT_DIAGONAL_CROSS                        (hex2dec('2573'))
    BOX_DRAWINGS_LIGHT_LEFT                                  (hex2dec('2574'))
    BOX_DRAWINGS_LIGHT_UP                                    (hex2dec('2575'))
    BOX_DRAWINGS_LIGHT_RIGHT                                 (hex2dec('2576'))
    BOX_DRAWINGS_LIGHT_DOWN                                  (hex2dec('2577'))
    BOX_DRAWINGS_HEAVY_LEFT                                  (hex2dec('2578'))
    BOX_DRAWINGS_HEAVY_UP                                    (hex2dec('2579'))
    BOX_DRAWINGS_HEAVY_RIGHT                                 (hex2dec('257A'))
    BOX_DRAWINGS_HEAVY_DOWN                                  (hex2dec('257B'))
    BOX_DRAWINGS_LIGHT_LEFT_AND_HEAVY_RIGHT                  (hex2dec('257C'))
    BOX_DRAWINGS_LIGHT_UP_AND_HEAVY_DOWN                     (hex2dec('257D'))
    BOX_DRAWINGS_HEAVY_LEFT_AND_LIGHT_RIGHT                  (hex2dec('257E'))
    BOX_DRAWINGS_HEAVY_UP_AND_LIGHT_DOWN                     (hex2dec('257F'))
    UPPER_HALF_BLOCK                                         (hex2dec('2580'))
    LOWER_ONE_EIGHTH_BLOCK                                   (hex2dec('2581'))
    LOWER_ONE_QUARTER_BLOCK                                  (hex2dec('2582'))
    LOWER_THREE_EIGHTHS_BLOCK                                (hex2dec('2583'))
    LOWER_HALF_BLOCK                                         (hex2dec('2584'))
    LOWER_FIVE_EIGHTHS_BLOCK                                 (hex2dec('2585'))
    LOWER_THREE_QUARTERS_BLOCK                               (hex2dec('2586'))
    LOWER_SEVEN_EIGHTHS_BLOCK                                (hex2dec('2587'))
    FULL_BLOCK                                               (hex2dec('2588'))
    LEFT_SEVEN_EIGHTHS_BLOCK                                 (hex2dec('2589'))
    LEFT_THREE_QUARTERS_BLOCK                                (hex2dec('258A'))
    LEFT_FIVE_EIGHTHS_BLOCK                                  (hex2dec('258B'))
    LEFT_HALF_BLOCK                                          (hex2dec('258C'))
    LEFT_THREE_EIGHTHS_BLOCK                                 (hex2dec('258D'))
    LEFT_ONE_QUARTER_BLOCK                                   (hex2dec('258E'))
    LEFT_ONE_EIGHTH_BLOCK                                    (hex2dec('258F'))
    RIGHT_HALF_BLOCK                                         (hex2dec('2590'))
    LIGHT_SHADE                                              (hex2dec('2591'))
    MEDIUM_SHADE                                             (hex2dec('2592'))
    DARK_SHADE                                               (hex2dec('2593'))
    UPPER_ONE_EIGHTH_BLOCK                                   (hex2dec('2594'))
    RIGHT_ONE_EIGHTH_BLOCK                                   (hex2dec('2595'))

    BLACK_SQUARE                                             (hex2dec('25A0'))
    WHITE_SQUARE                                             (hex2dec('25A1'))
    WHITE_SQUARE_WITH_ROUNDED_CORNERS                        (hex2dec('25A2'))
    WHITE_SQUARE_CONTAINING_BLACK_SMALL_SQUARE               (hex2dec('25A3'))
    SQUARE_WITH_HORIZONTAL_FILL                              (hex2dec('25A4'))
    SQUARE_WITH_VERTICAL_FILL                                (hex2dec('25A5'))
    SQUARE_WITH_ORTHOGONAL_CROSSHATCH_FILL                   (hex2dec('25A6'))
    SQUARE_WITH_UPPER_LEFT_TO_LOWER_RIGHT_FILL               (hex2dec('25A7'))
    SQUARE_WITH_UPPER_RIGHT_TO_LOWER_LEFT_FILL               (hex2dec('25A8'))
    SQUARE_WITH_DIAGONAL_CROSSHATCH_FILL                     (hex2dec('25A9'))
    BLACK_SMALL_SQUARE                                       (hex2dec('25AA'))
    WHITE_SMALL_SQUARE                                       (hex2dec('25AB'))
    BLACK_RECTANGLE                                          (hex2dec('25AC'))
    WHITE_RECTANGLE                                          (hex2dec('25AD'))
    BLACK_VERTICAL_RECTANGLE                                 (hex2dec('25AE'))
    WHITE_VERTICAL_RECTANGLE                                 (hex2dec('25AF'))
    BLACK_PARALLELOGRAM                                      (hex2dec('25B0'))
    WHITE_PARALLELOGRAM                                      (hex2dec('25B1'))
    BLACK_UP_POINTING_TRIANGLE                               (hex2dec('25B2'))
    WHITE_UP_POINTING_TRIANGLE                               (hex2dec('25B3'))
    BLACK_UP_POINTING_SMALL_TRIANGLE                         (hex2dec('25B4'))
    WHITE_UP_POINTING_SMALL_TRIANGLE                         (hex2dec('25B5'))
    BLACK_RIGHT_POINTING_TRIANGLE                            (hex2dec('25B6'))
    WHITE_RIGHT_POINTING_TRIANGLE                            (hex2dec('25B7'))
    BLACK_RIGHT_POINTING_SMALL_TRIANGLE                      (hex2dec('25B8'))
    WHITE_RIGHT_POINTING_SMALL_TRIANGLE                      (hex2dec('25B9'))
    BLACK_RIGHT_POINTING_POINTER                             (hex2dec('25BA'))
    WHITE_RIGHT_POINTING_POINTER                             (hex2dec('25BB'))
    BLACK_DOWN_POINTING_TRIANGLE                             (hex2dec('25BC'))
    WHITE_DOWN_POINTING_TRIANGLE                             (hex2dec('25BD'))
    BLACK_DOWN_POINTING_SMALL_TRIANGLE                       (hex2dec('25BE'))
    WHITE_DOWN_POINTING_SMALL_TRIANGLE                       (hex2dec('25BF'))
    BLACK_LEFT_POINTING_TRIANGLE                             (hex2dec('25C0'))
    WHITE_LEFT_POINTING_TRIANGLE                             (hex2dec('25C1'))
    BLACK_LEFT_POINTING_SMALL_TRIANGLE                       (hex2dec('25C2'))
    WHITE_LEFT_POINTING_SMALL_TRIANGLE                       (hex2dec('25C3'))
    BLACK_LEFT_POINTING_POINTER                              (hex2dec('25C4'))
    WHITE_LEFT_POINTING_POINTER                              (hex2dec('25C5'))
    BLACK_DIAMOND                                            (hex2dec('25C6'))
    WHITE_DIAMOND                                            (hex2dec('25C7'))
    WHITE_DIAMOND_CONTAINING_BLACK_SMALL_DIAMOND             (hex2dec('25C8'))
    FISHEYE                                                  (hex2dec('25C9'))
    LOZENGE                                                  (hex2dec('25CA'))
    WHITE_CIRCLE                                             (hex2dec('25CB'))
    DOTTED_CIRCLE                                            (hex2dec('25CC'))
    CIRCLE_WITH_VERTICAL_FILL                                (hex2dec('25CD'))
    BULLSEYE                                                 (hex2dec('25CE'))
    BLACK_CIRCLE                                             (hex2dec('25CF'))
    CIRCLE_WITH_LEFT_HALF_BLACK                              (hex2dec('25D0'))
    CIRCLE_WITH_RIGHT_HALF_BLACK                             (hex2dec('25D1'))
    CIRCLE_WITH_LOWER_HALF_BLACK                             (hex2dec('25D2'))
    CIRCLE_WITH_UPPER_HALF_BLACK                             (hex2dec('25D3'))
    CIRCLE_WITH_UPPER_RIGHT_QUADRANT_BLACK                   (hex2dec('25D4'))
    CIRCLE_WITH_ALL_BUT_UPPER_LEFT_QUADRANT_BLACK            (hex2dec('25D5'))
    LEFT_HALF_BLACK_CIRCLE                                   (hex2dec('25D6'))
    RIGHT_HALF_BLACK_CIRCLE                                  (hex2dec('25D7'))
    INVERSE_BULLET                                           (hex2dec('25D8'))
    INVERSE_WHITE_CIRCLE                                     (hex2dec('25D9'))
    UPPER_HALF_INVERSE_WHITE_CIRCLE                          (hex2dec('25DA'))
    LOWER_HALF_INVERSE_WHITE_CIRCLE                          (hex2dec('25DB'))
    UPPER_LEFT_QUADRANT_CIRCULAR_ARC                         (hex2dec('25DC'))
    UPPER_RIGHT_QUADRANT_CIRCULAR_ARC                        (hex2dec('25DD'))
    LOWER_RIGHT_QUADRANT_CIRCULAR_ARC                        (hex2dec('25DE'))
    LOWER_LEFT_QUADRANT_CIRCULAR_ARC                         (hex2dec('25DF'))
    UPPER_HALF_CIRCLE                                        (hex2dec('25E0'))
    LOWER_HALF_CIRCLE                                        (hex2dec('25E1'))
    BLACK_LOWER_RIGHT_TRIANGLE                               (hex2dec('25E2'))
    BLACK_LOWER_LEFT_TRIANGLE                                (hex2dec('25E3'))
    BLACK_UPPER_LEFT_TRIANGLE                                (hex2dec('25E4'))
    BLACK_UPPER_RIGHT_TRIANGLE                               (hex2dec('25E5'))
    WHITE_BULLET                                             (hex2dec('25E6'))
    SQUARE_WITH_LEFT_HALF_BLACK                              (hex2dec('25E7'))
    SQUARE_WITH_RIGHT_HALF_BLACK                             (hex2dec('25E8'))
    SQUARE_WITH_UPPER_LEFT_DIAGONAL_HALF_BLACK               (hex2dec('25E9'))
    SQUARE_WITH_LOWER_RIGHT_DIAGONAL_HALF_BLACK              (hex2dec('25EA'))
    WHITE_SQUARE_WITH_VERTICAL_BISECTING_LINE                (hex2dec('25EB'))
    WHITE_UP_POINTING_TRIANGLE_WITH_DOT                      (hex2dec('25EC'))
    UP_POINTING_TRIANGLE_WITH_LEFT_HALF_BLACK                (hex2dec('25ED'))
    UP_POINTING_TRIANGLE_WITH_RIGHT_HALF_BLACK               (hex2dec('25EE'))
    LARGE_CIRCLE                                             (hex2dec('25EF'))
end     % enumeration
end     % classdef
