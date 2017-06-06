(ns org.sanwu.prreader
    "自带模式识别的文件读取器"
    (:require [fs] [path] [commander]
                 [wisp.sequence :refer [first second last count reduce rest
                                   conj partition assoc drop empty?]]))


; Sequence
; Index
; Segment
; IndexOffset

; 最小分片符号识别：（MinSplitSymbol）
; 1.每次读取一行作为一个sequence
; 2.分片sequence 得到 由一个字符组成的segment 并记录其 index
; 3.计算same segment在两行之间的偏移 累加 totalIndexOffset:
;    如果segment在该行不存在 记录为Infinity 如果两行都存在 记录为 | pos1 - pos2|
; 4.totalIndexOffset最小的 为需要的预分片单元
(defmacro ->
  [& operations]
  (reduce
   (fn [form operation]
     (cons (first operation)
           (cons form (rest operation))))
   (first operations)
   (rest operations)))

(def version 0.1)

(defn parse-params
  [params]
  (let [options (-> commander
                    (.version version)
                    (.usage "[options] <file ...>")
                    (.option "-d, --dir"
                             "需要读取的文件夹路径")
                    (.parse params))]
    (conj {:no-map (not (:map options))}
          options)))


(defn main
  []
  (let [options (parse-params process.argv)
        path (or options.dir (.cwd process))]
        
    ))        


(main)  