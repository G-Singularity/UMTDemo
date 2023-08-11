//
//  DecodableDefault.swift
//  BeersListDemo
//
//  Created by myth on 10/8/23.
//

@propertyWrapper
public struct DecodableString:Codable {
    public var wrappedValue: String
    
    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        var string: String = ""
        do {
            string = try container.decode(String.self)
        } catch  {
            //此处可添加一些其它类型,例如Int
            do {
                string = String(try container.decode(Bool.self))
            } catch {
                do {
                    string = String(try container.decode(Double.self))
                } catch {
                    
                }
            }
        }
        self.wrappedValue = string
    }
}

@propertyWrapper
public struct DecodableInt:Codable {
    public var wrappedValue: Int
    
    public init(wrappedValue: Int) {
        self.wrappedValue = wrappedValue
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        var num: Int = 0
        do {
            num = try container.decode(Int.self)
        } catch  {
            //此处可添加一些其它类型
            do {
                num = (try container.decode(Bool.self)) ? 1 : 0
            } catch {
                do {
                    num = Int(try container.decode(Double.self))
                } catch {
                    do {
                        num = Int(try container.decode(String.self)) ?? 0
                    } catch  {
                        
                    }
                    
                }
            }
        }
        self.wrappedValue = num
    }
}
@propertyWrapper
public struct DecodableDouble:Codable {
    public var wrappedValue: Double
    
    public init(wrappedValue: Double) {
        self.wrappedValue = wrappedValue
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        var num: Double = 0
        do {
            num = try container.decode(Double.self)
        } catch  {
            //此处可添加一些其它类型
            do {
                num = Double(try container.decode(String.self)) ?? 0
            } catch {
                
            }
        }
        self.wrappedValue = num
    }
}

@propertyWrapper
public struct DecodableBool:Codable {
    public var wrappedValue: Bool
    
    public init(wrappedValue: Bool) {
        self.wrappedValue = wrappedValue
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        var bo: Bool = false
        do {
            bo = try container.decode(Bool.self)
        } catch  {
            //此处可添加一些其它类型
            do {
                bo = (try container.decode(Bool.self)) ? false : true
            } catch {
                
            }
        }
        self.wrappedValue = bo
    }
}
