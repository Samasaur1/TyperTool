import Typer
import Foundation

guard CommandLine.arguments.count > 1 else {
    print("You must provide text to type!")
    exit(1)
}
let text = CommandLine.arguments[1].replacingOccurrences(of: "\\\\", with: "\\").replacingOccurrences(of: "\\n", with: "\n").replacingOccurrences(of: "\\r", with: "\r").replacingOccurrences(of: "\\t", with: "\t")
print("Text to print:")
print(text)

var countdown: Int = 10
if CommandLine.arguments.count >= 3 {
    if let int = Int(CommandLine.arguments[2]) {
        countdown = int
    }
}
print("Printing in...")
for i in 0..<countdown {
    print(countdown - i)
    sleep(1)
}
print("Printing...")
Typer.type(text)
print("Successfully typed:")
print(text)
