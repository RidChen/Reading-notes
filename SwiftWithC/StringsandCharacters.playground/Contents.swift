//: Playground - noun: a place where people can play

import UIKit

/********字符串字面量*********/
/*
 swift 4.0
 引用自：https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/StringsAndCharacters.html#//apple_ref/doc/uid/TP40014097-CH7-ID285
 If you need a string that spans several lines, use a multiline string literal. A multiline string literal is a sequence of characters surrounded by three double quotes:
 如果需要一个多行显示的文本，你可以使用多行字符串字面量，将文本用三对双引号(""")包裹起来
(当前的xcode版本还不能支持swift 4.0的内容，下面代码还无法调试)
*/
//let quotation = """
//The White Rabbit put on his spectacles.  "Where shall I begin,
//please your Majesty?" he asked.
//
//"Begin at the beginning," the King said gravely, "and go on
//till you come to the end; then stop."
//"""

/*
 In its multiline form, the string literal includes all of the lines between its opening and closing quotes. The string begins on the first line after the opening quotes (""") and ends on the line before the closing quotes ("""), which means that quotation doesn’t start or end with a line feed. Both of the strings below are the same:
 如果使用三对双引号包裹的内容只有一行，等价于使用一对双引号 */
//let singleLineString = "These are the same."
//let multilineString = """
//These are the same.
//"""

/*
 A multiline string can be indented to match the surrounding code. The whitespace before the closing quotes (""") tells Swift what whitespace to ignore before all of the other lines. For example, even though the multiline string literal in the function below is indented, the lines in the actual string don’t begin with any whitespace.
 一个多行文本会自动缩进，在（"""）前的空格个数表示每行将要忽略的空格的个数
 
 However, if you write whitespace at the beginning of a line in addition to what’s before the closing quotes ("""), that whitespace is included.
 如果某一行的空格数比最开始那行的空格数多，多出来的空格将会显示出来
 */

//func generateQuotation() -> String {
// 第一个"This"前的空格表示要每行行首忽略4哥空格，实际显示的文本中，开头的空格不会被显示出来
//    let quotation = """
//        This line doesn't begin with whitespace. // 前面的四个空格不会显示
//            This line begins with four spaces. // 此行有八个空格，将会显示出四个空格
//        This line doesn't begin with whitespace. // 前面的四个空格不会显示
//    """
//    return quotation
//}

/********字符串索引*******/
/* 引用自：https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/StringsAndCharacters.html#//apple_ref/doc/uid/TP40014097-CH7-ID285
 Each String value has an associated index type, String.Index, which corresponds to the position of each Character in the string.
 使用String.Index可以访问字符串中某一个字符
 As mentioned above, different characters can require different amounts of memory to store, so in order to determine which Character is at a particular position, you must iterate over each Unicode scalar from the start or end of that String. For this reason, Swift strings cannot be indexed by integer values.
 为了找到某个指定位置的字符，你必须从开始或者结尾遍历每个Unicode标量，因为这个原因，swift的字符串不能通过整数进行索引
 You can use subscript syntax to access the Character at a particular String index.
 你可以使用下标访问特定index的字符
 */
var greeting = "Guten Tag!"
greeting[greeting.startIndex]
// G
greeting[greeting.index(before: greeting.endIndex)]
// !
greeting[greeting.index(after: greeting.startIndex)]
// u
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]
// a
