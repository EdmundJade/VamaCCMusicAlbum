import Foundation

extension Dictionary {
    public static func readFrom(_ plistName:String) -> Dictionary? {
        
        do {
            guard let path = Bundle.main.path(forResource: plistName, ofType: "plist") else {
                return nil
            }
            
            var url:URL?
            if #available(iOS 16, *) {
                url = URL.init(filePath: path)
            } else {
                url = URL(fileURLWithPath: path)
            }
            
            guard let urlRetrieved = url else {
                return nil
            }
            
            let data = try Data(contentsOf: urlRetrieved, options: [])
            
            guard let plist = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? Dictionary else {
                return nil
            }
            
            return plist
        } catch {
            // Error Handling
            print("Unable to read from plist")
            return nil
        }
    }
}
