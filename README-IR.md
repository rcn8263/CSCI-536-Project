### Install and Usage

1. Download Amazon review dataset "Cell_Phones_and_Accessories" 5-core from http://snap.stanford.edu/data/amazon/productGraph/categoryFiles/reviews_Cell_Phones_and_Accessories_5.json.gz`

    Place in `/drem/tmp_data/` folder and rename to `reviews.json.gz`

2. Download the meta data from http://snap.stanford.edu/data/amazon/productGraph/categoryFiles/meta_Cell_Phones_and_Accessories.json.gz

    Place in `/drem/tmp_data/` folder and rename to `meta.json.gz`

3. Run `DataPreperation.bat`

    Query data will be stored in `/drem/tmp_data/min_count5/random_query_split/` folder.

4. Train model by running `train.bat`

    Model parameters can be tweaked in the bat file before being run.
    Trained model will be output to `/ProductSearch/trained_models/` folder.

5. Test model by running `test.bat`


### Code Changes

TODO