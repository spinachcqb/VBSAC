; ModuleID = './401_7.c'
source_filename = "./401_7.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@GLOBAL_CONST_TRUE = constant i32 1, align 4
@GLOBAL_CONST_FALSE = constant i32 0, align 4
@GLOBAL_CONST_FIVE = constant i32 5, align 4
@globalTrue = global i32 1, align 4
@globalFalse = global i32 0, align 4
@globalFive = global i32 5, align 4
@.str = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@staticFive = internal global i32 5, align 4
@.str.2 = private unnamed_addr constant [9 x i8] c"A String\00", align 1
@.str.3 = private unnamed_addr constant [21 x i8] c"Benign, fixed string\00", align 1

; Function Attrs: nounwind uwtable
define i32 @globalReturnsTrue() #0 !dbg !21 {
entry:
  ret i32 1, !dbg !24
}

; Function Attrs: nounwind uwtable
define i32 @globalReturnsFalse() #0 !dbg !25 {
entry:
  ret i32 0, !dbg !26
}

; Function Attrs: nounwind uwtable
define i32 @globalReturnsTrueOrFalse() #0 !dbg !27 {
entry:
  %call = call i32 @rand() #4, !dbg !28
  %rem = srem i32 %call, 2, !dbg !29
  ret i32 %rem, !dbg !30
}

; Function Attrs: nounwind
declare i32 @rand() #1

; Function Attrs: nounwind uwtable
define void @printLine(i8* %line) #0 !dbg !31 {
entry:
  %line.addr = alloca i8*, align 8
  store i8* %line, i8** %line.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %line.addr, metadata !36, metadata !37), !dbg !38
  %0 = load i8*, i8** %line.addr, align 8, !dbg !39
  %cmp = icmp ne i8* %0, null, !dbg !41
  br i1 %cmp, label %if.then, label %if.end, !dbg !42

if.then:                                          ; preds = %entry
  %1 = load i8*, i8** %line.addr, align 8, !dbg !43
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i8* %1), !dbg !45
  br label %if.end, !dbg !46

if.end:                                           ; preds = %if.then, %entry
  ret void, !dbg !47
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

declare i32 @printf(i8*, ...) #3

; Function Attrs: nounwind uwtable
define void @printIntLine(i32 %intNumber) #0 !dbg !48 {
entry:
  %intNumber.addr = alloca i32, align 4
  store i32 %intNumber, i32* %intNumber.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %intNumber.addr, metadata !51, metadata !37), !dbg !52
  %0 = load i32, i32* %intNumber.addr, align 4, !dbg !53
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i32 0, i32 0), i32 %0), !dbg !54
  ret void, !dbg !55
}

; Function Attrs: nounwind uwtable
define void @bad7() #0 !dbg !56 {
entry:
  %data = alloca i8*, align 8
  call void @llvm.dbg.declare(metadata i8** %data, metadata !59, metadata !37), !dbg !60
  store i8* null, i8** %data, align 8, !dbg !61
  %0 = load i32, i32* @staticFive, align 4, !dbg !62
  %cmp = icmp eq i32 %0, 5, !dbg !64
  br i1 %cmp, label %if.then, label %if.end4, !dbg !65

if.then:                                          ; preds = %entry
  %call = call noalias i8* @calloc(i64 100, i64 1) #4, !dbg !66
  store i8* %call, i8** %data, align 8, !dbg !68
  %1 = load i8*, i8** %data, align 8, !dbg !69
  %cmp1 = icmp eq i8* %1, null, !dbg !71
  br i1 %cmp1, label %if.then2, label %if.end, !dbg !72

if.then2:                                         ; preds = %if.then
  br label %if.end7, !dbg !73

if.end:                                           ; preds = %if.then
  %2 = load i8*, i8** %data, align 8, !dbg !75
  %call3 = call i8* @strcpy(i8* %2, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0)) #4, !dbg !76
  %3 = load i8*, i8** %data, align 8, !dbg !77
  call void @printLine(i8* %3), !dbg !78
  br label %if.end4, !dbg !79

if.end4:                                          ; preds = %if.end, %entry
  %4 = load i32, i32* @staticFive, align 4, !dbg !80
  %cmp5 = icmp eq i32 %4, 5, !dbg !82
  br i1 %cmp5, label %if.then6, label %if.end7, !dbg !83

if.then6:                                         ; preds = %if.end4
  br label %if.end7, !dbg !84

if.end7:                                          ; preds = %if.then2, %if.then6, %if.end4
  ret void, !dbg !86
}

; Function Attrs: nounwind
declare noalias i8* @calloc(i64, i64) #1

; Function Attrs: nounwind
declare i8* @strcpy(i8*, i8*) #1

; Function Attrs: nounwind uwtable
define void @good7() #0 !dbg !87 {
entry:
  %data = alloca i8*, align 8
  call void @llvm.dbg.declare(metadata i8** %data, metadata !88, metadata !37), !dbg !89
  store i8* null, i8** %data, align 8, !dbg !90
  %0 = load i32, i32* @staticFive, align 4, !dbg !91
  %cmp = icmp eq i32 %0, 5, !dbg !93
  br i1 %cmp, label %if.then, label %if.end4, !dbg !94

if.then:                                          ; preds = %entry
  %call = call noalias i8* @calloc(i64 100, i64 1) #4, !dbg !95
  store i8* %call, i8** %data, align 8, !dbg !97
  %1 = load i8*, i8** %data, align 8, !dbg !98
  %cmp1 = icmp eq i8* %1, null, !dbg !100
  br i1 %cmp1, label %if.then2, label %if.end, !dbg !101

if.then2:                                         ; preds = %if.then
  br label %if.end7, !dbg !102

if.end:                                           ; preds = %if.then
  %2 = load i8*, i8** %data, align 8, !dbg !104
  %call3 = call i8* @strcpy(i8* %2, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0)) #4, !dbg !105
  %3 = load i8*, i8** %data, align 8, !dbg !106
  call void @printLine(i8* %3), !dbg !107
  br label %if.end4, !dbg !108

if.end4:                                          ; preds = %if.end, %entry
  %4 = load i32, i32* @staticFive, align 4, !dbg !109
  %cmp5 = icmp ne i32 %4, 5, !dbg !111
  br i1 %cmp5, label %if.then6, label %if.else, !dbg !112

if.then6:                                         ; preds = %if.end4
  call void @printLine(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.3, i32 0, i32 0)), !dbg !113
  br label %if.end7, !dbg !115

if.else:                                          ; preds = %if.end4
  %5 = load i8*, i8** %data, align 8, !dbg !116
  call void @free(i8* %5) #4, !dbg !118
  br label %if.end7

if.end7:                                          ; preds = %if.then2, %if.else, %if.then6
  ret void, !dbg !119
}

; Function Attrs: nounwind
declare void @free(i8*) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 !dbg !120 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @good7(), !dbg !121
  call void @bad7(), !dbg !122
  ret i32 1, !dbg !123
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!18, !19}
!llvm.ident = !{!20}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 3.9.0 (tags/RELEASE_390/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, globals: !7)
!1 = !DIFile(filename: "401_7.c", directory: "/home/guzuxing/Documents/VBSAC/benchmark/Juliet_Test_Suite/401")
!2 = !{}
!3 = !{!4, !5}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64, align: 64)
!5 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6, size: 64, align: 64)
!6 = !DIBasicType(name: "char", size: 8, align: 8, encoding: DW_ATE_signed_char)
!7 = !{!8, !12, !13, !14, !15, !16, !17}
!8 = distinct !DIGlobalVariable(name: "GLOBAL_CONST_TRUE", scope: !0, file: !9, line: 10, type: !10, isLocal: false, isDefinition: true, variable: i32* @GLOBAL_CONST_TRUE)
!9 = !DIFile(filename: "./401_7.c", directory: "/home/guzuxing/Documents/VBSAC/benchmark/Juliet_Test_Suite/401")
!10 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !11)
!11 = !DIBasicType(name: "int", size: 32, align: 32, encoding: DW_ATE_signed)
!12 = distinct !DIGlobalVariable(name: "GLOBAL_CONST_FALSE", scope: !0, file: !9, line: 11, type: !10, isLocal: false, isDefinition: true, variable: i32* @GLOBAL_CONST_FALSE)
!13 = distinct !DIGlobalVariable(name: "GLOBAL_CONST_FIVE", scope: !0, file: !9, line: 12, type: !10, isLocal: false, isDefinition: true, variable: i32* @GLOBAL_CONST_FIVE)
!14 = distinct !DIGlobalVariable(name: "globalTrue", scope: !0, file: !9, line: 15, type: !11, isLocal: false, isDefinition: true, variable: i32* @globalTrue)
!15 = distinct !DIGlobalVariable(name: "globalFalse", scope: !0, file: !9, line: 16, type: !11, isLocal: false, isDefinition: true, variable: i32* @globalFalse)
!16 = distinct !DIGlobalVariable(name: "globalFive", scope: !0, file: !9, line: 17, type: !11, isLocal: false, isDefinition: true, variable: i32* @globalFive)
!17 = distinct !DIGlobalVariable(name: "staticFive", scope: !0, file: !9, line: 47, type: !11, isLocal: true, isDefinition: true, variable: i32* @staticFive)
!18 = !{i32 2, !"Dwarf Version", i32 4}
!19 = !{i32 2, !"Debug Info Version", i32 3}
!20 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
!21 = distinct !DISubprogram(name: "globalReturnsTrue", scope: !9, file: !9, line: 19, type: !22, isLocal: false, isDefinition: true, scopeLine: 20, isOptimized: false, unit: !0, variables: !2)
!22 = !DISubroutineType(types: !23)
!23 = !{!11}
!24 = !DILocation(line: 21, column: 5, scope: !21)
!25 = distinct !DISubprogram(name: "globalReturnsFalse", scope: !9, file: !9, line: 24, type: !22, isLocal: false, isDefinition: true, scopeLine: 25, isOptimized: false, unit: !0, variables: !2)
!26 = !DILocation(line: 26, column: 5, scope: !25)
!27 = distinct !DISubprogram(name: "globalReturnsTrueOrFalse", scope: !9, file: !9, line: 29, type: !22, isLocal: false, isDefinition: true, scopeLine: 30, isOptimized: false, unit: !0, variables: !2)
!28 = !DILocation(line: 31, column: 13, scope: !27)
!29 = !DILocation(line: 31, column: 20, scope: !27)
!30 = !DILocation(line: 31, column: 5, scope: !27)
!31 = distinct !DISubprogram(name: "printLine", scope: !9, file: !9, line: 34, type: !32, isLocal: false, isDefinition: true, scopeLine: 35, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!32 = !DISubroutineType(types: !33)
!33 = !{null, !34}
!34 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !35, size: 64, align: 64)
!35 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !6)
!36 = !DILocalVariable(name: "line", arg: 1, scope: !31, file: !9, line: 34, type: !34)
!37 = !DIExpression()
!38 = !DILocation(line: 34, column: 30, scope: !31)
!39 = !DILocation(line: 36, column: 8, scope: !40)
!40 = distinct !DILexicalBlock(scope: !31, file: !9, line: 36, column: 8)
!41 = !DILocation(line: 36, column: 13, scope: !40)
!42 = !DILocation(line: 36, column: 8, scope: !31)
!43 = !DILocation(line: 38, column: 24, scope: !44)
!44 = distinct !DILexicalBlock(scope: !40, file: !9, line: 37, column: 5)
!45 = !DILocation(line: 38, column: 9, scope: !44)
!46 = !DILocation(line: 39, column: 5, scope: !44)
!47 = !DILocation(line: 40, column: 1, scope: !31)
!48 = distinct !DISubprogram(name: "printIntLine", scope: !9, file: !9, line: 42, type: !49, isLocal: false, isDefinition: true, scopeLine: 43, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!49 = !DISubroutineType(types: !50)
!50 = !{null, !11}
!51 = !DILocalVariable(name: "intNumber", arg: 1, scope: !48, file: !9, line: 42, type: !11)
!52 = !DILocation(line: 42, column: 24, scope: !48)
!53 = !DILocation(line: 44, column: 20, scope: !48)
!54 = !DILocation(line: 44, column: 5, scope: !48)
!55 = !DILocation(line: 45, column: 1, scope: !48)
!56 = distinct !DISubprogram(name: "bad7", scope: !9, file: !9, line: 51, type: !57, isLocal: false, isDefinition: true, scopeLine: 52, isOptimized: false, unit: !0, variables: !2)
!57 = !DISubroutineType(types: !58)
!58 = !{null}
!59 = !DILocalVariable(name: "data", scope: !56, file: !9, line: 53, type: !5)
!60 = !DILocation(line: 53, column: 12, scope: !56)
!61 = !DILocation(line: 54, column: 10, scope: !56)
!62 = !DILocation(line: 55, column: 8, scope: !63)
!63 = distinct !DILexicalBlock(scope: !56, file: !9, line: 55, column: 8)
!64 = !DILocation(line: 55, column: 18, scope: !63)
!65 = !DILocation(line: 55, column: 8, scope: !56)
!66 = !DILocation(line: 58, column: 24, scope: !67)
!67 = distinct !DILexicalBlock(scope: !63, file: !9, line: 56, column: 5)
!68 = !DILocation(line: 58, column: 14, scope: !67)
!69 = !DILocation(line: 59, column: 13, scope: !70)
!70 = distinct !DILexicalBlock(scope: !67, file: !9, line: 59, column: 13)
!71 = !DILocation(line: 59, column: 18, scope: !70)
!72 = !DILocation(line: 59, column: 13, scope: !67)
!73 = !DILocation(line: 59, column: 27, scope: !74)
!74 = !DILexicalBlockFile(scope: !70, file: !9, discriminator: 1)
!75 = !DILocation(line: 61, column: 16, scope: !67)
!76 = !DILocation(line: 61, column: 9, scope: !67)
!77 = !DILocation(line: 62, column: 19, scope: !67)
!78 = !DILocation(line: 62, column: 9, scope: !67)
!79 = !DILocation(line: 63, column: 5, scope: !67)
!80 = !DILocation(line: 64, column: 8, scope: !81)
!81 = distinct !DILexicalBlock(scope: !56, file: !9, line: 64, column: 8)
!82 = !DILocation(line: 64, column: 18, scope: !81)
!83 = !DILocation(line: 64, column: 8, scope: !56)
!84 = !DILocation(line: 68, column: 5, scope: !85)
!85 = distinct !DILexicalBlock(scope: !81, file: !9, line: 65, column: 5)
!86 = !DILocation(line: 69, column: 1, scope: !56)
!87 = distinct !DISubprogram(name: "good7", scope: !9, file: !9, line: 75, type: !57, isLocal: false, isDefinition: true, scopeLine: 76, isOptimized: false, unit: !0, variables: !2)
!88 = !DILocalVariable(name: "data", scope: !87, file: !9, line: 77, type: !5)
!89 = !DILocation(line: 77, column: 12, scope: !87)
!90 = !DILocation(line: 78, column: 10, scope: !87)
!91 = !DILocation(line: 79, column: 8, scope: !92)
!92 = distinct !DILexicalBlock(scope: !87, file: !9, line: 79, column: 8)
!93 = !DILocation(line: 79, column: 18, scope: !92)
!94 = !DILocation(line: 79, column: 8, scope: !87)
!95 = !DILocation(line: 82, column: 24, scope: !96)
!96 = distinct !DILexicalBlock(scope: !92, file: !9, line: 80, column: 5)
!97 = !DILocation(line: 82, column: 14, scope: !96)
!98 = !DILocation(line: 83, column: 13, scope: !99)
!99 = distinct !DILexicalBlock(scope: !96, file: !9, line: 83, column: 13)
!100 = !DILocation(line: 83, column: 18, scope: !99)
!101 = !DILocation(line: 83, column: 13, scope: !96)
!102 = !DILocation(line: 83, column: 27, scope: !103)
!103 = !DILexicalBlockFile(scope: !99, file: !9, discriminator: 1)
!104 = !DILocation(line: 85, column: 16, scope: !96)
!105 = !DILocation(line: 85, column: 9, scope: !96)
!106 = !DILocation(line: 86, column: 19, scope: !96)
!107 = !DILocation(line: 86, column: 9, scope: !96)
!108 = !DILocation(line: 87, column: 5, scope: !96)
!109 = !DILocation(line: 88, column: 8, scope: !110)
!110 = distinct !DILexicalBlock(scope: !87, file: !9, line: 88, column: 8)
!111 = !DILocation(line: 88, column: 18, scope: !110)
!112 = !DILocation(line: 88, column: 8, scope: !87)
!113 = !DILocation(line: 91, column: 9, scope: !114)
!114 = distinct !DILexicalBlock(scope: !110, file: !9, line: 89, column: 5)
!115 = !DILocation(line: 92, column: 5, scope: !114)
!116 = !DILocation(line: 96, column: 14, scope: !117)
!117 = distinct !DILexicalBlock(scope: !110, file: !9, line: 94, column: 5)
!118 = !DILocation(line: 96, column: 9, scope: !117)
!119 = !DILocation(line: 98, column: 1, scope: !87)
!120 = distinct !DISubprogram(name: "main", scope: !9, file: !9, line: 103, type: !22, isLocal: false, isDefinition: true, scopeLine: 103, isOptimized: false, unit: !0, variables: !2)
!121 = !DILocation(line: 104, column: 5, scope: !120)
!122 = !DILocation(line: 105, column: 2, scope: !120)
!123 = !DILocation(line: 106, column: 5, scope: !120)
