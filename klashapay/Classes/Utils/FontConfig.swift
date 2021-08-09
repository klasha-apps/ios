//
//  FontConfig.swift
//  klashapay
//
//  Created by Adegoke Ayomikun on 19/07/2021.
//

import Foundation
import CoreText

public class CustomFonts: NSObject {

  public enum Style: CaseIterable {
    case regular
    case semibold
    case bold
    public var value: String {
      switch self {
      case .regular: return "Regular"
      case .semibold: return "Bold"
      case .bold: return "Bolds"
      }
    }
    public var font: UIFont {
      return UIFont(name: self.value, size: 14) ?? UIFont.init()
    }
  }

  // Lazy var instead of method so it's only ever called once per app session.
  public static var loadFonts: () -> Void = {
    let fontNames = Style.allCases.map { $0.value }
    for fontName in fontNames {
      loadFont(withName: fontName)
    }
    return {}
  }()

  private static func loadFont(withName fontName: String) {
    guard
        let bundleURL = Bundle(for: self).url(forResource: "klashapay", withExtension: "bundle"),
      let bundle = Bundle(url: bundleURL),
      let fontURL = bundle.url(forResource: fontName, withExtension: "ttf"),
      let fontData = try? Data(contentsOf: fontURL) as CFData,
      let provider = CGDataProvider(data: fontData),
      let font = CGFont(provider) else {
        return
    }
    CTFontManagerRegisterGraphicsFont(font, nil)
  }

}


public final class Fonts {
  static func podFont(name: String, size: CGFloat) -> UIFont {

    //Why do extra work if its available.
    if let font = UIFont(name: name, size: size) {return font}

    let bundle = Bundle.getResourcesBundle() ?? Bundle.main //get the current bundle

    print("BUNDLE: \(bundle)")
    let url = bundle.url(forResource: name, withExtension: nil)! //get the bundle url
    let data = NSData(contentsOf: url)! //get the font data
    let provider = CGDataProvider(data: data)! //convert the data into a provider
    let cgFont = CGFont(provider)! //convert provider to cgfont
    let fontName = cgFont.postScriptName as! String //crashes if can't get name
    CTFontManagerRegisterGraphicsFont(cgFont, nil) //Registers the font, like the plist
    return UIFont(name: fontName, size: size)!
  }
}
