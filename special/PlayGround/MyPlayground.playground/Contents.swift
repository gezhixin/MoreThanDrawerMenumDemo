//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
str = "dasfasf"

for (var i = 0; i < 9; i++)
{
    println("\(i)")
}

var img = UIImage(named: "icon_menu.png")
var imgView = UIImageView(image: img)

var a = 12.0
var s = "dafadfadfa\(a)"
var l = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
l.text = "asdfa"



str
func t(inout str: String)
{
    str = "adfaf"
}

t(&str)

str
