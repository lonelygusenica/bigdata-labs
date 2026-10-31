#!/bin/bash

# Удаляем старые результаты
hdfs dfs -rm -R /user/output/py_wordcount_filtered

# Запускаем Hadoop Streaming MapReduce
yarn jar \
$HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-*.jar \
-files mapper.py,reducer.py \
-mapper "python3 mapper.py" \
-reducer "python3 reducer.py" \
-input /user/data/eng_wiki.txt \
-output /user/output/py_wordcount_filtered
