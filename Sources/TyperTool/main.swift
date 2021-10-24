import ArgumentParser
import Typer
import Foundation

extension Typer.Rate {
    struct Trate: Codable {
        let type: Int
        let delay: UInt32?
        let variance: UInt32?

        init(_ t: Typer.Rate) {
            switch t {
            case .allAtOnce:
                type = 1
            case .consistent:
                type = 2
            case .customConsistent(µsecondDelay: let d):
                type = 3
                delay = d
                variance = nil
                return
            case let .customVarying(µsecondBaseDelay: d, maxVariance: v):
                type = 4
                delay = d
                variance = v
                return
            case .natural:
                type = 5
            }
            delay = nil
            variance = nil
        }
    }
    init(_ t: Trate) {
        switch t.type {
        case 1:
            self = .allAtOnce
        case 2:
            self = .consistent
        case 3:
            self = .customConsistent(µsecondDelay: t.delay!)
        case 4:
            self = .customVarying(µsecondBaseDelay: t.delay!, maxVariance: t.variance!)
        case 5:
            self = .natural
        default:
            fatalError("Don't modify UserDefaults!")
        }
    }
}
extension Typer.Rate: ExpressibleByArgument {
    public init?(argument: String) {
        switch argument.lowercased() {
        case "allatonce": self = .allAtOnce
        case "consistent": self = .consistent
        case "natural": self = .natural
        default: return nil
        }
    }
}

class UserDefaultsHelper {
    #if DEBUG
    static func reset() {
        UserDefaults.standard.removeObject(forKey: "delay")
        UserDefaults.standard.removeObject(forKey: "rate")
        UserDefaults.standard.removeObject(forKey: "initialized")
        Self.shared = UserDefaultsHelper()
    }
    static var shared = UserDefaultsHelper()
    #else
    static let shared = UserDefaultsHelper()
    #endif
    private init() {
        let initialized = UserDefaults.standard.bool(forKey: "initialized")
        if initialized {
            delay = UserDefaults.standard.integer(forKey: "delay")
        } else {
            delay = 10
            UserDefaults.standard.setValue(10, forKey: "delay")
        }

        if let r = UserDefaults.standard.object(forKey: "rate") as? Data, let r2 = try? PropertyListDecoder().decode(Typer.Rate.Trate.self, from: r) {
            rate = Typer.Rate(r2)
        } else {
            rate = .natural
            UserDefaults.standard.setValue(try! PropertyListEncoder().encode(Typer.Rate.Trate(rate)), forKey: "rate")
        }


        UserDefaults.standard.set(true, forKey: "initialized")
    }

    var delay: Int {
        didSet {
            UserDefaults.standard.set(delay, forKey: "delay")
        }
    }

    var rate: Typer.Rate {
        didSet {
            UserDefaults.standard.setValue(try! PropertyListEncoder().encode(Typer.Rate.Trate(rate)), forKey: "rate")
        }
    }
}

struct TyperCommand: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "typer",
        abstract: "Types the given text",
        discussion: "This command types the given text at a 'natural' speed, designed to fool other software into thinking it was typed by the user",
        version: "2.0.0",
        shouldDisplay: true,
        subcommands: [],
        defaultSubcommand: nil,
        helpNames: .shortAndLong)

    @Argument(help: "The text to type", transform: { $0.replacingOccurrences(of: "\\\\", with: "\\").replacingOccurrences(of: "\\n", with: "\n").replacingOccurrences(of: "\\r", with: "\r").replacingOccurrences(of: "\\t", with: "\t")}) var text: String

    @Option(name: .customLong("delay"), help: .init("The time to wait, in seconds, before starting to type", valueName: "delay")) var countdown: Int = UserDefaultsHelper.shared.delay
    @Option(help: "The rate to type at") var rate: Typer.Rate = UserDefaultsHelper.shared.rate

    @Flag(help: .init("Save the given delay and/or rate as future defaults", discussion: "Due to restrictions in the argument parsing library used, you must still pass some text to type — however, this text WILL NOT be typed.")) var config = false

    func run() throws {
        if config {
            UserDefaultsHelper.shared.delay = countdown
            UserDefaultsHelper.shared.rate = rate
            return
        }
        print("Printing in...")
        for i in 0..<countdown {
            print(countdown - i)
            sleep(1)
        }
        print("Printing...")
        Typer.type(text, typing: rate)
        print("Successfully typed:")
        print(text)
    }
}
//struct TyperConfigCommand: ParsableCommand {
//    static var configuration = CommandConfiguration(
//        commandName: "typer-config",
//        abstract: "Set the defaults for typing",
//        discussion: "Currently, you can configure the delay and the rate",
//        version: "1.0.0",
//        shouldDisplay: true,
//        subcommands: [],
//        defaultSubcommand: nil,
//        helpNames: .shortAndLong
//    )
//
//    @Option(help: "The time to wait, in seconds, before starting to type") var delay: Int?
//    @Option(help: "The rate to type at") var rate: Typer.Rate?
//
//    func run() throws {
//        if let d = delay {
//            UserDefaultsHelper.shared.delay = d
//        }
//        if let r = rate {
//            UserDefaultsHelper.shared.rate = r
//        }
//    }
//}

TyperCommand.main()
