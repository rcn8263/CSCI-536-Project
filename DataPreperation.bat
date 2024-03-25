:: Stem and remove stop words from the Amazon review datasets if needed. Here, we stem the field of “reviewText” and “summary” without stop words removal.
java -Xmx4g -jar ./drem/utils/AmazonDataset/jar/AmazonReviewData_preprocess.jar false ./drem/tmp_data/reviews.json.gz ./drem/tmp_data/reviews.processed.gz

:: Index datasets
python ./drem/utils/AmazonDataset/index_and_filter_review_file.py ./drem/tmp_data/reviews.processed.gz ./drem/tmp_data/ 5

:: Match the meta data with the indexed data to extract queries:
java -Xmx16G -jar ./drem/utils/AmazonDataset/jar/AmazonMetaData_matching.jar false ./drem/tmp_data/meta.json.gz ./drem/tmp_data/min_count5/

:: Randomly split train/test
:: The 20% purchases of each user are used as test data
:: Also, we randomly sample 30% queries and make them unique in the test set.
python drem/utils/AmazonDataset/random_split_train_test_data.py drem/tmp_data/min_count5/ 0.2 0.3