# ASCII Cheatsheet

ASCII(American Standard Code for Information Interchange) - 7비트, 총 128개의 문자/기호를 0~127 정수 값으로 매핑.

## ASCII 표 (0~127)

| Dec | Char | 설명 |   | Dec | Char | 설명 |   | Dec | Char | 설명 |   | Dec | Char | 설명 |
|-----|------|------|---|-----|------|------|---|-----|------|------|---|-----|------|------|
|  0  | NUL  | Null |   | 32  | (space) | Space |   | 64  | `@`  | at |   | 96  | `` ` `` | backtick |
|  1  | SOH  | Start of Heading |   | 33  | `!`   | exclamation mark |   | 65  | `A`  | Uppercase A |   | 97  | `a`  | Lowercase a |
|  2  | STX  | Start of Text |   | 34  | `"`   | double quote |   | 66  | `B`  | Uppercase B |   | 98  | `b`  | Lowercase b |
|  3  | ETX  | End of Text |   | 35  | `#`   | hash |   | 67  | `C`  | Uppercase C |   | 99  | `c`  | Lowercase c |
|  4  | EOT  | End of Transmission |   | 36  | `$`   | dollar sign |   | 68  | `D`  | Uppercase D |   | 100 | `d`  | Lowercase d |
|  5  | ENQ  | Enquiry |   | 37  | `%`   | percent |   | 69  | `E`  | Uppercase E |   | 101 | `e`  | Lowercase e |
|  6  | ACK  | Acknowledge |   | 38  | `&`   | ampersand |   | 70  | `F`  | Uppercase F |   | 102 | `f`  | Lowercase f |
|  7  | BEL  | Bell |   | 39  | `'`   | single quote |   | 71  | `G`  | Uppercase G |   | 103 | `g`  | Lowercase g |
|  8  | BS   | Backspace |   | 40  | `(`   | left paren |   | 72  | `H`  | Uppercase H |   | 104 | `h`  | Lowercase h |
|  9  | TAB  | Horizontal Tab |   | 41  | `)`   | right paren |   | 73  | `I`  | Uppercase I |   | 105 | `i`  | Lowercase i |
| 10  | LF   | Line Feed |   | 42  | `*`   | asterisk |   | 74  | `J`  | Uppercase J |   | 106 | `j`  | Lowercase j |
| 11  | VT   | Vertical Tab |   | 43  | `+`   | plus |   | 75  | `K`  | Uppercase K |   | 107 | `k`  | Lowercase k |
| 12  | FF   | Form Feed |   | 44  | `,`   | comma |   | 76  | `L`  | Uppercase L |   | 108 | `l`  | Lowercase l |
| 13  | CR   | Carriage Return |   | 45  | `-`   | minus |   | 77  | `M`  | Uppercase M |   | 109 | `m`  | Lowercase m |
| 14  | SO   | Shift Out |   | 46  | `.`   | period |   | 78  | `N`  | Uppercase N |   | 110 | `n`  | Lowercase n |
| 15  | SI   | Shift In |   | 47  | `/`   | slash |   | 79  | `O`  | Uppercase O |   | 111 | `o`  | Lowercase o |
| 16  | DLE  | Data Link Escape |   | 48  | `0`   | zero |   | 80  | `P`  | Uppercase P |   | 112 | `p`  | Lowercase p |
| 17  | DC1  | Device Control 1 |   | 49  | `1`   | one |   | 81  | `Q`  | Uppercase Q |   | 113 | `q`  | Lowercase q |
| 18  | DC2  | Device Control 2 |   | 50  | `2`   | two |   | 82  | `R`  | Uppercase R |   | 114 | `r`  | Lowercase r |
| 19  | DC3  | Device Control 3 |   | 51  | `3`   | three |   | 83  | `S`  | Uppercase S |   | 115 | `s`  | Lowercase s |
| 20  | DC4  | Device Control 4 |   | 52  | `4`   | four |   | 84  | `T`  | Uppercase T |   | 116 | `t`  | Lowercase t |
| 21  | NAK  | Negative Acknowledge |   | 53  | `5`   | five |   | 85  | `U`  | Uppercase U |   | 117 | `u`  | Lowercase u |
| 22  | SYN  | Synchronous Idle |   | 54  | `6`   | six |   | 86  | `V`  | Uppercase V |   | 118 | `v`  | Lowercase v |
| 23  | ETB  | End of Trans. Block |   | 55  | `7`   | seven |   | 87  | `W`  | Uppercase W |   | 119 | `w`  | Lowercase w |
| 24  | CAN  | Cancel |   | 56  | `8`   | eight |   | 88  | `X`  | Uppercase X |   | 120 | `x`  | Lowercase x |
| 25  | EM   | End of Medium |   | 57  | `9`   | nine |   | 89  | `Y`  | Uppercase Y |   | 121 | `y`  | Lowercase y |
| 26  | SUB  | Substitute |   | 58  | `:`   | colon |   | 90  | `Z`  | Uppercase Z |   | 122 | `z`  | Lowercase z |
| 27  | ESC  | Escape |   | 59  | `;`   | semicolon |   | 91  | `[`  | left bracket |   | 123 | `{`  | left brace |
| 28  | FS   | File Separator |   | 60  | `<`   | less than |   | 92  | `\`  | backslash |   | 124 | `\|` | vertical bar |
| 29  | GS   | Group Separator |   | 61  | `=`   | equals |   | 93  | `]`  | right bracket |   | 125 | `}`  | right brace |
| 30  | RS   | Record Separator |   | 62  | `>`   | greater than |   | 94  | `^`  | caret |   | 126 | `~`  | tilde |
| 31  | US   | Unit Separator |   | 63  | `?`   | question mark |   | 95  | `_`  | underscore |   | 127 | DEL  | Delete |

## 자주 쓰는 값

| 범위 | Dec | 설명 |
|------|-----|------|
| `0-9` | 48-57 | 숫자 (`c - '0'`으로 정수 변환) |
| `A-Z` | 65-90 | 대문자 |
| `a-z` | 97-122 | 소문자 (`c ^ 32`로 대소문자 전환) |
| `space` | 32 | 공백 |
| `\n` | 10 | 개행 (LF) |
| `\r` | 13 | 캐리지 리턴 (CR) |
| `\t` | 9 | 탭 |
