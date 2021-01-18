//
//  LoggerMacros.h
//  ReplicaUIKit
//
//  Created by Werck, Ayrton on 18-07-16.
//

#ifndef LoggerMacros_h
#define LoggerMacros_h

#define LOG_INFO(categ, frmt, ...) [ObjcBridge info:[NSString stringWithFormat:frmt, ##__VA_ARGS__] category:categ]
#define LOG_ERROR(categ, frmt, ...) [ObjcBridge error:[NSString stringWithFormat:frmt, ##__VA_ARGS__] category:categ]
#define LOG_WARNING(categ, frmt, ...) [ObjcBridge warning:[NSString stringWithFormat:frmt, ##__VA_ARGS__] category:categ]

#endif /* LoggerMacros_h */
