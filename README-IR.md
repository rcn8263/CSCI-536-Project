### Requirements
    1. To run the DREM model in ./ProductSearch/ and the python scripts in ./utils/, python 3.0+ and Tensorflow v1.3+ are needed. (In the paper, Python 3.6 and Tensorflow v1.4.0 are used)
    2. To run the jar package in ./utils/AmazonDataset/jar/, JDK 1.7 is needed


### Install and Usage

1. Download Amazon review dataset "Cell_Phones_and_Accessories" 5-core from http://snap.stanford.edu/data/amazon/productGraph/categoryFiles/reviews_Cell_Phones_and_Accessories_5.json.gz`

    Place in `/drem/tmp_data/` folder and rename to `reviews.json.gz`

2. Download the meta data from http://snap.stanford.edu/data/amazon/productGraph/categoryFiles/meta_Cell_Phones_and_Accessories.json.gz

    Place in `/drem/tmp_data/` folder and rename to `meta.json.gz`

3. Stem and remove stop words from the Amazon review datasets if needed. Here, we stem the field of “reviewText” and “summary” without stop words removal.

	Run `java -Xmx4g -jar ./drem/utils/AmazonDataset/jar/AmazonReviewData_preprocess.jar false ./drem/tmp_data/reviews.json.gz ./drem/tmp_data/reviews.processed.gz`

4. Index datasets

	Run `python ./drem/utils/AmazonDataset/index_and_filter_review_file.py ./drem/tmp_data/reviews.processed.gz ./drem/tmp_data/ 5`

5. Match the meta data with the indexed data to extract queries

	Run `java -Xmx16G -jar ./drem/utils/AmazonDataset/jar/AmazonMetaData_matching.jar false ./drem/tmp_data/meta.json.gz ./drem/tmp_data/min_count5/`
	
6. Randomly split train/test data

	Run `python drem/utils/AmazonDataset/random_split_train_test_data.py drem/tmp_data/min_count5/ 0.2 0.3`

7. Tweak model parameters and train model

	Run `python ./ProductSearch/main.py --model_name review_transformer --mode train --pretrain_emb_dir "" --data_dir ./drem/tmp_data/min_count5 --input_train_dir ./drem/tmp_data/min_count5/random_query_split --save_dir ./ProductSearch/trained_models --decay_method adam --max_train_epoch 20 --lr 0.0005 --batch_size 384 --uprev_review_limit 20 --embedding_size 128 --inter_layers 1 --ff_size 512 --heads 8`

    Trained model will be output to `/ProductSearch/trained_models/` folder.

8. Test model

	Run `python ./ProductSearch/main.py --model_name review_transformer --mode test --pretrain_emb_dir "" --data_dir ./drem/tmp_data/min_count5 --input_train_dir ./drem/tmp_data/min_count5/random_query_split --save_dir ./ProductSearch/trained_models --decay_method adam --max_train_epoch 20 --lr 0.0005 --batch_size 384 --uprev_review_limit 20 --embedding_size 128 --inter_layers 1 --ff_size 512 --heads 8`


### Code Changes

TODO