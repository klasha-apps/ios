//
//  URLHelper.swift
//  RaveMobile
//
//  Created by Segun Solaja on 10/5/15.
//  Copyright © 2015 Segun Solaja. All rights reserved.
//

import UIKit

class RaveURLHelper: NSObject {
    static let isStaging = KlashaConfig.sharedConfig().isStaging
    class func getURL(_ URLKey:String) ->String{
        return self.getURL(URLKey, withURLParam: [:])
    }
    
    
    class func getURL(_ URLKey:String ,withURLParam:Dictionary<String,String>) -> String{
        if (!withURLParam.isEmpty){
            var str:String!
           str =  KlashaConstants.relativeURL()[URLKey]!
            for (key,value) in withURLParam{     
               str = str.replacingOccurrences(of: ":" + key, with: value)
            }
            return (isStaging == false ? KlashaConstants.liveBaseURL(): KlashaConstants.baseURL()) + str!
            
        }else{
            print((isStaging == false ? KlashaConstants.liveBaseURL(): KlashaConstants.baseURL()) + KlashaConstants.relativeURL()[URLKey]!)
            return (isStaging == false ? KlashaConstants.liveBaseURL(): KlashaConstants.baseURL()) + KlashaConstants.relativeURL()[URLKey]!
        }
    }
    
    class func getV2URL(_ URLKey:String ,withURLParam:Dictionary<String,String>) -> String{
        if (!withURLParam.isEmpty){
            var str:String!
            str =  KlashaConstants.relativeURL()[URLKey]!
            for (key,value) in withURLParam{
                str = str.replacingOccurrences(of: ":" + key, with: value)
            }
            return (isStaging == false ? KlashaConstants.v2liveBaseURL(): KlashaConstants.baseURL()) + str!
            
        }else{
            print((isStaging == false ? KlashaConstants.v2liveBaseURL(): KlashaConstants.baseURL()) + KlashaConstants.relativeURL()[URLKey]!)
            return (isStaging == false ? KlashaConstants.v2liveBaseURL(): KlashaConstants.baseURL()) + KlashaConstants.relativeURL()[URLKey]!
        }
    }
    
    class func getV3URL(_ URLKey:String ,withURLParam:Dictionary<String,String>) -> String{
         if (!withURLParam.isEmpty){
             var str:String!
             str =  KlashaConstants.relativeURL()[URLKey]!
             for (key,value) in withURLParam{
                 str = str.replacingOccurrences(of: ":" + key, with: value)
             }
             return (isStaging == false ? KlashaConstants.v2liveBaseURL(): KlashaConstants.baseURL()) + str!
             
         }else{
             print((isStaging == false ? KlashaConstants.v2liveBaseURL(): KlashaConstants.baseURL()) + KlashaConstants.relativeURL()[URLKey]!)
             return (isStaging == false ? KlashaConstants.v2liveBaseURL(): KlashaConstants.baseURL()) + KlashaConstants.relativeURL()[URLKey]!
         }
     }
    

}
