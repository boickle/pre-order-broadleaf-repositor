--
-- The Archetype is configured with "hibernate.hbm2ddl.auto" value="create-drop" in "persistence.xml".
--
-- This will cause hibernate to populate the database when the application is started by processing the files that
-- were configured in the hibernate.hbm2ddl.import_files property.
--
-- This file is responsible for loading the the catalog data used in the Archetype.   Implementers can change this file
-- to load their initial catalog.
--

-- BLC Admin Required Categories
INSERT INTO BLC_CATEGORY (CATEGORY_ID,DESCRIPTION,NAME,URL,DEFAULT_PARENT_CATEGORY_ID,ACTIVE_START_DATE) VALUES (1,'Root','Root',NULL,NULL,CURRENT_TIMESTAMP);
INSERT INTO BLC_CATEGORY (CATEGORY_ID,DESCRIPTION,NAME,URL,DEFAULT_PARENT_CATEGORY_ID,ACTIVE_START_DATE) VALUES (2, 'Primary Nav','Primary Nav',NULL,1,CURRENT_TIMESTAMP);

-- Custom store navigation (default template uses these for the header navigation)
INSERT INTO BLC_CATEGORY (CATEGORY_ID,DESCRIPTION,NAME,URL,DEFAULT_PARENT_CATEGORY_ID,ACTIVE_START_DATE, DISPLAY_TEMPLATE) VALUES (2001,'Home','Home','/',2,CURRENT_TIMESTAMP, 'layout/home');
INSERT INTO BLC_CATEGORY (CATEGORY_ID,DESCRIPTION,NAME,URL,DEFAULT_PARENT_CATEGORY_ID,ACTIVE_START_DATE) VALUES (2002,'Hot Sauces','Hot Sauces','/hot-sauces',2,CURRENT_TIMESTAMP);
INSERT INTO BLC_CATEGORY (CATEGORY_ID,DESCRIPTION,NAME,URL,DEFAULT_PARENT_CATEGORY_ID,ACTIVE_START_DATE) VALUES (2003,'Merchandise','Merchandise','/merchandise',2,CURRENT_TIMESTAMP);
INSERT INTO BLC_CATEGORY (CATEGORY_ID,DESCRIPTION,NAME,URL,DEFAULT_PARENT_CATEGORY_ID,ACTIVE_START_DATE) VALUES (2004,'Clearance','Clearance','/clearance',2,CURRENT_TIMESTAMP);
INSERT INTO BLC_CATEGORY (CATEGORY_ID,DESCRIPTION,NAME,URL,DEFAULT_PARENT_CATEGORY_ID,ACTIVE_START_DATE) VALUES (2005,'New to Hot Sauce?','New to Hot Sauce?','/new-to-hot-sauce',2,CURRENT_TIMESTAMP);
INSERT INTO BLC_CATEGORY (CATEGORY_ID,DESCRIPTION,NAME,URL,DEFAULT_PARENT_CATEGORY_ID,ACTIVE_START_DATE) VALUES (2006,'FAQs','FAQs','/faq',2,CURRENT_TIMESTAMP);
INSERT INTO BLC_CATEGORY (CATEGORY_ID,DESCRIPTION,NAME,URL,DEFAULT_PARENT_CATEGORY_ID,ACTIVE_START_DATE) VALUES (2007,'Meals','Meals','/meals',2,CURRENT_TIMESTAMP);

-- Builds the category hierarchy (simple in this case) - Root --> Nav --> All other categories
INSERT INTO BLC_CATEGORY_XREF (CATEGORY_XREF_ID, SUB_CATEGORY_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (1,2,1,1)
INSERT INTO BLC_CATEGORY_XREF (CATEGORY_XREF_ID, SUB_CATEGORY_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (2,2001,2,1);
INSERT INTO BLC_CATEGORY_XREF (CATEGORY_XREF_ID, SUB_CATEGORY_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (3,2002,2,2);
INSERT INTO BLC_CATEGORY_XREF (CATEGORY_XREF_ID, SUB_CATEGORY_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (4,2003,2,3);
INSERT INTO BLC_CATEGORY_XREF (CATEGORY_XREF_ID, SUB_CATEGORY_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (5,2004,2,4);
INSERT INTO BLC_CATEGORY_XREF (CATEGORY_XREF_ID, SUB_CATEGORY_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (6,2005,2,5);
INSERT INTO BLC_CATEGORY_XREF (CATEGORY_XREF_ID, SUB_CATEGORY_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (7,2006,2,6);
INSERT INTO BLC_CATEGORY_XREF (CATEGORY_XREF_ID, SUB_CATEGORY_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (8,2007,2,7);

-- Add in any applicable search facets for the given category
INSERT INTO BLC_FIELD (FIELD_ID, ENTITY_TYPE, PROPERTY_NAME, ABBREVIATION, SEARCHABLE, FACET_FIELD_TYPE) VALUES (1, 'PRODUCT', 'manufacturer', 'mfg', TRUE, 's');
INSERT INTO BLC_FIELD (FIELD_ID, ENTITY_TYPE, PROPERTY_NAME, ABBREVIATION, SEARCHABLE, FACET_FIELD_TYPE) VALUES (2, 'PRODUCT', 'productAttributes.heatRange', 'heatRange', FALSE, 'i');
INSERT INTO BLC_FIELD (FIELD_ID, ENTITY_TYPE, PROPERTY_NAME, ABBREVIATION, SEARCHABLE, FACET_FIELD_TYPE) VALUES (3, 'PRODUCT', 'defaultSku.retailPrice', 'price', FALSE, 'p');
INSERT INTO BLC_FIELD (FIELD_ID, ENTITY_TYPE, PROPERTY_NAME, ABBREVIATION, SEARCHABLE, TRANSLATABLE, FACET_FIELD_TYPE) VALUES (4, 'PRODUCT', 'defaultSku.name', 'name', TRUE, TRUE, 's');
INSERT INTO BLC_FIELD (FIELD_ID, ENTITY_TYPE, PROPERTY_NAME, ABBREVIATION, SEARCHABLE, FACET_FIELD_TYPE) VALUES (5, 'PRODUCT', 'model', 'model', TRUE, 's');
INSERT INTO BLC_FIELD (FIELD_ID, ENTITY_TYPE, PROPERTY_NAME, ABBREVIATION, SEARCHABLE, TRANSLATABLE) VALUES (6, 'PRODUCT', 'defaultSku.description', 'desc', TRUE, TRUE);
INSERT INTO BLC_FIELD (FIELD_ID, ENTITY_TYPE, PROPERTY_NAME, ABBREVIATION, SEARCHABLE, TRANSLATABLE) VALUES (7, 'PRODUCT', 'defaultSku.longDescription', 'ldesc', TRUE, TRUE);
INSERT INTO BLC_FIELD (FIELD_ID, ENTITY_TYPE, PROPERTY_NAME, ABBREVIATION, SEARCHABLE, FACET_FIELD_TYPE) VALUES (8, 'PRODUCT', 'productAttributes.color', 'color', TRUE, 's');

INSERT INTO BLC_FIELD_SEARCH_TYPES (FIELD_ID, SEARCHABLE_FIELD_TYPE) VALUES (1, 't');
-- Note that we are don't search on heat range
-- Note that we are don't search on price
INSERT INTO BLC_FIELD_SEARCH_TYPES (FIELD_ID, SEARCHABLE_FIELD_TYPE) VALUES (4, 't');
INSERT INTO BLC_FIELD_SEARCH_TYPES (FIELD_ID, SEARCHABLE_FIELD_TYPE) VALUES (5, 't');
INSERT INTO BLC_FIELD_SEARCH_TYPES (FIELD_ID, SEARCHABLE_FIELD_TYPE) VALUES (6, 't');
INSERT INTO BLC_FIELD_SEARCH_TYPES (FIELD_ID, SEARCHABLE_FIELD_TYPE) VALUES (7, 't');

INSERT INTO BLC_SEARCH_FACET (SEARCH_FACET_ID, FIELD_ID, LABEL, SHOW_ON_SEARCH, MULTISELECT, SEARCH_DISPLAY_PRIORITY) VALUES (1, 1, 'Manufacturer', FALSE, TRUE, 0);
INSERT INTO BLC_CAT_SEARCH_FACET_XREF (CATEGORY_SEARCH_FACET_ID, CATEGORY_ID, SEARCH_FACET_ID, SEQUENCE) VALUES (1, 2002, 1, 1);

INSERT INTO BLC_SEARCH_FACET (SEARCH_FACET_ID, FIELD_ID, LABEL, SHOW_ON_SEARCH, MULTISELECT, SEARCH_DISPLAY_PRIORITY) VALUES (2, 2, 'Heat Range', FALSE, TRUE, 0);
INSERT INTO BLC_CAT_SEARCH_FACET_XREF (CATEGORY_SEARCH_FACET_ID, CATEGORY_ID, SEARCH_FACET_ID, SEQUENCE) VALUES (2, 2002, 2, 2);

INSERT INTO BLC_SEARCH_FACET (SEARCH_FACET_ID, FIELD_ID, LABEL, SHOW_ON_SEARCH, MULTISELECT, SEARCH_DISPLAY_PRIORITY) VALUES (4, 8, 'Color', TRUE, TRUE, 0);
INSERT INTO BLC_CAT_SEARCH_FACET_XREF (CATEGORY_SEARCH_FACET_ID, CATEGORY_ID, SEARCH_FACET_ID, SEQUENCE) VALUES (4,2003, 4, 1);

INSERT INTO BLC_SEARCH_FACET (SEARCH_FACET_ID, FIELD_ID, LABEL, SHOW_ON_SEARCH, MULTISELECT, SEARCH_DISPLAY_PRIORITY) VALUES (3, 3, 'Price', TRUE, TRUE, 1);
INSERT INTO BLC_CAT_SEARCH_FACET_XREF (CATEGORY_SEARCH_FACET_ID, CATEGORY_ID, SEARCH_FACET_ID, SEQUENCE) VALUES (3, 1, 3, 3);
INSERT INTO BLC_SEARCH_FACET_RANGE (SEARCH_FACET_RANGE_ID, SEARCH_FACET_ID, MIN_VALUE, MAX_VALUE) VALUES (1, 3, 0, 5);
INSERT INTO BLC_SEARCH_FACET_RANGE (SEARCH_FACET_RANGE_ID, SEARCH_FACET_ID, MIN_VALUE, MAX_VALUE) VALUES (2, 3, 5, 10);
INSERT INTO BLC_SEARCH_FACET_RANGE (SEARCH_FACET_RANGE_ID, SEARCH_FACET_ID, MIN_VALUE, MAX_VALUE) VALUES (3, 3, 10, 15);
INSERT INTO BLC_SEARCH_FACET_RANGE (SEARCH_FACET_RANGE_ID, SEARCH_FACET_ID, MIN_VALUE, MAX_VALUE) VALUES (4, 3, 15, null);

------------------------------------------------------------------------------------------------------------------
-- Inserting products manually involves five steps which are outlined below.   Typically, products are loaded 
-- up front in the project and then managed via the Broadleaf Commerce admin.   
--
-- Loading through this script is a convenient way to get started when prototyping and can be useful in development
-- as a way to share data-setup without requiring a shared DB connection. 
------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------
-- Load Catalog - Step 1:  Create the products
-- =============================================
-- In this step, we are also populating the manufacturer for the product
------------------------------------------------------------------------------------------------------------------
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (1,2002,'/hot-sauces/sudden_death_sauce','Blair''s',TRUE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (2,2002,'/hot-sauces/sweet_death_sauce','Blair''s',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (3,2002,'/hot-sauces/hoppin_hot_sauce','Salsa Express',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (4,2002,'/hot-sauces/day_of_the_dead_chipotle_hot_sauce','Spice Exchange',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (5,2002,'/hot-sauces/day_of_the_dead_habanero_hot_sauce','Spice Exchange',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (6,2002,'/hot-sauces/day_of_the_dead_scotch_bonnet_sauce','Spice Exchange',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (7,2002,'/hot-sauces/green_ghost','Garden Row',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (8,2002,'/hot-sauces/blazin_saddle_hot_habanero_pepper_sauce','D. L. Jardine''s',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (9,2002,'/hot-sauces/armageddon_hot_sauce_to_end_all','Figueroa Brothers',TRUE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (10,2002,'/hot-sauces/dr_chilemeisters_insane_hot_sauce','Figueroa Brothers',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (11,2002,'/hot-sauces/bull_snort_cowboy_cayenne_pepper_hot_sauce','Brazos Legends',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (12,2002,'/hot-sauces/cafe_louisiane_sweet_cajun_blackening_sauce','Garden Row',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (13,2002,'/hot-sauces/bull_snort_smokin_toncils_hot_sauce','Brazos Legends',TRUE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (14,2002,'/hot-sauces/cool_cayenne_pepper_hot_sauce','Dave''s Gourmet',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (15,2002,'/hot-sauces/roasted_garlic_hot_sauce','Dave''s Gourmet',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (16,2002,'/hot-sauces/scotch_bonnet_hot_sauce','Dave''s Gourmet',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (17,2002,'/hot-sauces/insanity_sauce','Dave''s Gourmet',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (18,2002,'/hot-sauces/hurtin_jalepeno_hot_sauce','Dave''s Gourmet',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (19,2002,'/hot-sauces/roasted_red_pepper_chipotle_hot_sauce','Dave''s Gourmet',FALSE);

-- Merchandise (products with options)
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (100,2003,'/merchandise/hawt_like_a_habanero_mens','The Heat Clinic',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (200,2003,'/merchandise/hawt_like_a_habanero_womens','The Heat Clinic',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (300,2003,'/merchandise/heat_clinic_hand-drawn_mens','The Heat Clinic',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (400,2003,'/merchandise/heat_clinic_hand-drawn_womens','The Heat Clinic',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (500,2003,'/merchandise/heat_clinic_mascot_mens','The Heat Clinic',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (600,2003,'/merchandise/heat_clinic_mascot_womens','The Heat Clinic',FALSE);

-- Meals
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (700,2007,'/meals/mac-and-cheese','My Restaurant',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (701,2007,'/meals/falafel','My Restaurant',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (702,2007,'/meals/brisket','My Restaurant',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (703,2007,'/meals/cranberryisland','My Restaurant',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (704,2007,'/meals/poahedsalmon','My Restaurant',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (705,2007,'/meals/conchiglie','My Restaurant',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (706,2007,'/meals/cereal','My Restaurant',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (707,2007,'/meals/omelette','My Restaurant',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (708,2007,'/meals/beef-lunch','My Restaurant',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (709,2007,'/meals/chicken-lunch','My Restaurant',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (710,2007,'/meals/fish-lunch','My Restaurant',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (711,2007,'/meals/veggie-lunch','My Restaurant',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (712,2007,'/meals/beef-dinner','My Restaurant',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (713,2007,'/meals/chicken-dinner','My Restaurant',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (714,2007,'/meals/fish-dinner','My Restaurant',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (715,2007,'/meals/veggie-dinner','My Restaurant',FALSE);

INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (716,2007,'/meals/atlanticsalmon','Air Canada',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (717,2007,'/meals/cheese-tortellini','Air Canada',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (718,2007,'/meals/beef-tenderloin','Air Canada',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (719,2007,'/meals/green-curry-chicken','Air Canada',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (720,2007,'/meals/parsley-omelet','Air Canada',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (721,2007,'/meals/pancake-cranapple','Air Canada',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (722,2007,'/meals/oatmeal-cold','Air Canada',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (723,2007,'/meals/atlanticsalmon','Air Canada',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (724,2007,'/meals/cheese-tortellini','Air Canada',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (725,2007,'/meals/beef-tenderloin','Air Canada',FALSE);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,  DEFAULT_CATEGORY_ID, URL, MANUFACTURE, IS_FEATURED_PRODUCT) VALUES (726,2007,'/meals/green-curry-chicken','Air Canada',FALSE);


-- Bundles
INSERT INTO BLC_PRODUCT (PRODUCT_ID,ARCHIVED,CAN_SELL_WITHOUT_OPTIONS,DISPLAY_TEMPLATE,IS_FEATURED_PRODUCT,MANUFACTURE,MODEL,URL,URL_KEY,DEFAULT_CATEGORY_ID) VALUES (992,'N',false,null,false,null,null,'/bundle1',null,null);
INSERT INTO BLC_PRODUCT_BUNDLE (AUTO_BUNDLE,BUNDLE_PROMOTABLE,ITEMS_PROMOTABLE,PRICING_MODEL,BUNDLE_PRIORITY,PRODUCT_ID) VALUES (false,false,false,'ITEM_SUM',99,992);
INSERT INTO BLC_PRODUCT (PRODUCT_ID,ARCHIVED,CAN_SELL_WITHOUT_OPTIONS,DISPLAY_TEMPLATE,IS_FEATURED_PRODUCT,MANUFACTURE,MODEL,URL,URL_KEY,DEFAULT_CATEGORY_ID) VALUES (993,'N',false,null,false,null,null,'/bundle2',null,null);
INSERT INTO BLC_PRODUCT_BUNDLE (AUTO_BUNDLE,BUNDLE_PROMOTABLE,ITEMS_PROMOTABLE,PRICING_MODEL,BUNDLE_PRIORITY,PRODUCT_ID) VALUES (false,false,false,'BUNDLE',99,993);



------------------------------------------------------------------------------------------------------------------
-- Load Catalog - Step 2:  Create "default" SKUs
-- =============================================
-- The Broadleaf Commerce product model is setup such that every product has a default SKU.   For many products,
-- a product only has one SKU.    SKUs hold the pricing information for the product and are the actual entity
-- that is added to the cart.    Inventory, Pricing, and Fulfillment concerns are done at the SKU level
------------------------------------------------------------------------------------------------------------------
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (1,1,'Sudden Death Sauce','As my Chilipals know, I am never one to be satisfied. Hence, the creation of Sudden Death. When you need to go beyond... Sudden Death will deliver! ',10.99,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (2,2,'Sweet Death Sauce','The perfect topper for chicken, fish, burgers or pizza. A great blend of Habanero, Mango, Passion Fruit and more make this Death Sauce an amazing tropical treat.',10.99,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (3,3,'Hoppin'' Hot Sauce','Tangy, ripe cayenne peppes flow together with garlic, onion, tomato paste and a hint of cane sugar to make this a smooth sauce with a bite.  Wonderful on eggs, poultry, pork, or fish, this sauce blends to make rich marinades and soups.',4.99,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (4,4,'Day of the Dead Chipotle Hot Sauce','When any pepper is dried and smoked, it is referred to as a Chipotle. Usually with a wrinkled, drak brown appearance, the Chipotle delivers a smokey, sweet flavor which is generally used for adding a smokey, roasted flavor to salsas, stews and marinades.',6.99,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (5,5,'Day of the Dead Habanero Hot Sauce','If you want hot, this is the chile to choose. Native to the Carribean, Yucatan and Northern Coast of South America, the Habanero presents itself in a variety of colors ranging from light green to a bright red. The Habanero''s bold heat, unique flavor and aroma has made it the favorite of chile lovers.',6.99,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (6,6,'Day of the Dead Scotch Bonnet Hot Sauce','Often mistaken for the Habanero, the Scotch Bonnet has a deeply inverted tip as opposed to the pointed end of the Habanero. Ranging in many colors from green to yellow-orange, the Scotch Bonnet is a staple in West Indies and Barbados style pepper sauces.',6.99,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (7,7,'Green Ghost','Made with Naga Bhut Jolokia, the World''s Hottest pepper.',11.99,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (8,8,'Blazin'' Saddle XXX Hot Habanero Pepper Sauce','You bet your boots, this hot sauce earned its name from folks that appreciate an outstanding hot sauce. What you''ll find here is a truly original zesty flavor, not an overpowering pungency that is found in those ordinary Tabasco pepper sauces - even though the pepper used in this product was tested at 285,000 Scoville units. So, saddle up for a ride to remember. To make sure we brought you only the finest Habanero pepper sauce, we went to the foothills of the Mayan mountains in Belize, Central America. This product is prepared entirely by hand using only fresh vegetables and all natural ingredients.',4.99,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (9,9,'Armageddon The Hot Sauce To End All','All Hell is breaking loose, fire &amp; brimstone rain down? prepare to meet your maker.',12.99,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (10,10,'Dr. Chilemeister''s Insane Hot Sauce','Here is the Prescription for those who enjoy intolerable heat. Dr. Chilemeister''s sick and evil deadly brew should be used with caution. Pain can become addictive!',12.99,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (11,11,'Bull Snort Cowboy Cayenne Pepper Hot Sauce','Been there, roped that. Hotter than a buckin'' mare in heat! Sprinkle on meat entrees, seafood and vegetables. Use as additive in barbecue sauce or any food that needs a spicy flavor. Start with a few drops and work up to the desired flavor.',3.99,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (12,12,'Cafe Louisiane Sweet Cajun Blackening Sauce','One of the more unusual sauces we sell. The original was an old style Cajun sauce and this is it''s updated blackening version. It''s sweet but you get a great hit of cinnamon and cloves with a nice kick of cayenne heat. Use on all foods to give that Cajun flair!',4.99,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (13,13,'Bull Snort Smokin'' Toncils Hot Sauce','Everything is bigger in Texas, even the burn of a Bull Snortin'' Hot Sauce! shower on that Texas sized steak they call the Ole 96er or your plane Jane vegetables. If you are a fan on making BBQ sauce from scratch like I am, you can use Bull Snort Smokin'' Tonsils Hot Sauce as an additive. Red hot habaneros and cayenne peppers give this tonsil tingler it''s famous flavor and red hot heat. Bull Snort Smokin'' Tonsils Hot Sauce''ll have your bowels buckin'' with just a drop!',3.99,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (14,14,'Cool Cayenne Pepper Hot Sauce','This sauce gets its great flavor from aged peppers and cane vinegar. It will enhance the flavor of most any meal.',5.99,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (15,15,'Roasted Garlic Hot Sauce','This sauce gets its great flavor from aged peppers and cane vinegar. It will enhance the flavor of most any meal.',5.99,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (16,16,'Scotch Bonnet Hot Sauce','This sauce gets its great flavor from aged peppers and cane vinegar. It will enhance the flavor of most any meal.',5.99,'Y','Y',CURRENT_TIMESTAMP);

-- Meals
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (700,700,'Macaroni and Cheese','Oven-fresh home style serving of corkscrew pasta in a savoury four-cheese sauce with a parmesan-paprika topping.',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (701,701,'Falafel Wrap','Falafels with red peppers, baby spinach, tzatziki, and red onions in a whole wheat wrap.',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (702,702,'Beef Brisket Sandwich','Shaved smoked beef brisket, caramelized onions, fire roasted mushrooms, lettuce, and cream cheese on a potato scallion bun.',7.95,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (703,703,'Cranberry Island Salad','Oven-fresh home style serving of corkscrew pasta in a savoury four-cheese sauce with a parmesan-paprika topping. ',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (704,704,'Poached Salmon with Watercress and Peaches','Poached to perfection with a peach sauce and side salad.',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (705,705,'Conchiglie with Shrimp','Pimenton, a Spanish paprika, adds an unexpected hint of earthy, smoky flavor to shrimp and roasted tomatoes lightly coated in a cream sauce with pasta.',7.95,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (706,706,'Cereal (breakfast)','Great tasting grains start your day right',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (707,707,'Omelette (breakfast)','Great tasting eggs',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (708,708,'Beef (lunch)','Great tasting beef for lunch',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (709,709,'Chicken (lunch)','Great tasting chicken for lunch',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (710,710,'Fish (lunch)','Great tasting fish for lunch',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (711,711,'Vegetables (lunch)','Good stuff for you for lunch',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (712,712,'Beef (dinner)','Great tasting beef for dinner',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (713,713,'Chicken (dinner)','Great tasting chicken for dinner',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (714,714,'Fish (dinner)','Great tasting fish for dinner',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (715,715,'Vegetables (dinner)','Good stuff for you for dinner',0.00,'Y','Y',CURRENT_TIMESTAMP);

INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (716,716,'Atlantic salmon on a creamy mushroom risotto (lunch)','Pan fried Atlantic salmon on a creamy mushroom risotto served with a mixed pepper relish and a mix of fine green beans, yellow carrots and red peppers',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (717,717,'Cheese tortellini (lunch)','Cheese tortellini with a chunky family-style Italian tomato sauce, garnished with Mozzarella',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (718,718,'Beef tenderloin (lunch)','Beef tenderloin served with a mushroom tarragon sauce, chunky red- skinned mashed potatoes and broccoli florets',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (719,719,'Chicken breast pieces napped with a green curry sauce (lunch)','Chicken breast pieces napped with a green curry sauce, served with a coriander seasoned pilaf style rice and a mix of carrots and edemame beans',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (720,720,'Parsley Omelet w/Chicken Sausage (breakfast)','Parsley Omelet w/Chicken Sausage, Herbed Yukon Potato, Fruit Chutney',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (721,721,'Pancake with Cran-Apple Compote (breakfast)','Pancake with Cran-Apple Compote, Maple Butter & Chicken Sausage',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (722,722,'Cold Breakfast choice with oatmeal (breakfast)','Cold Breakfast choice with oatmeal',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (723,723,'Atlantic salmon on a creamy mushroom risotto (dinner)','Pan fried Atlantic salmon on a creamy mushroom risotto served with a mixed pepper relish and a mix of fine green beans, yellow carrots and red peppers',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (724,724,'Cheese tortellini (dinner)','Cheese tortellini with a chunky family-style Italian tomato sauce, garnished with Mozzarella',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (725,725,'Beef tenderloin (dinner)','Beef tenderloin served with a mushroom tarragon sauce, chunky red- skinned mashed potatoes and broccoli florets',0.00,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (726,726,'Chicken breast pieces napped with a green curry sauce (dinner)','Chicken breast pieces napped with a green curry sauce, served with a coriander seasoned pilaf style rice and a mix of carrots and edemame beans',0.00,'Y','Y',CURRENT_TIMESTAMP);

--bundle1 Skus
INSERT INTO BLC_SKU (SKU_ID,ACTIVE_END_DATE,ACTIVE_START_DATE,AVAILABLE_FLAG,DESCRIPTION,CONTAINER_SHAPE,DEPTH,DIMENSION_UNIT_OF_MEASURE,GIRTH,HEIGHT,CONTAINER_SIZE,WIDTH,DISCOUNTABLE_FLAG,FULFILLMENT_TYPE,INVENTORY_TYPE,IS_MACHINE_SORTABLE,LONG_DESCRIPTION,NAME,RETAIL_PRICE,SALE_PRICE,TAXABLE_FLAG,WEIGHT,WEIGHT_UNIT_OF_MEASURE,DEFAULT_PRODUCT_ID) VALUES (9992,{ts '2099-04-05 00:00:00'},{ts '2001-02-24 00:00:00'},null,null,null,null,null,null,null,null,null,null,null,null,true,null,'bundle1',13,3,null,null,null,992);
INSERT INTO BLC_SKU_BUNDLE_ITEM (SKU_BUNDLE_ITEM_ID,ITEM_SALE_PRICE,QUANTITY,PRODUCT_BUNDLE_ID,SKU_ID) VALUES (-100,null,1,992,1);
INSERT INTO BLC_SKU_BUNDLE_ITEM (SKU_BUNDLE_ITEM_ID,ITEM_SALE_PRICE,QUANTITY,PRODUCT_BUNDLE_ID,SKU_ID) VALUES (-101,null,1,992,2);

---bundle2 Skus
INSERT INTO BLC_SKU (SKU_ID,ACTIVE_END_DATE,ACTIVE_START_DATE,AVAILABLE_FLAG,DESCRIPTION,CONTAINER_SHAPE,DEPTH,DIMENSION_UNIT_OF_MEASURE,GIRTH,HEIGHT,CONTAINER_SIZE,WIDTH,DISCOUNTABLE_FLAG,FULFILLMENT_TYPE,INVENTORY_TYPE,IS_MACHINE_SORTABLE,LONG_DESCRIPTION,NAME,RETAIL_PRICE,SALE_PRICE,TAXABLE_FLAG,WEIGHT,WEIGHT_UNIT_OF_MEASURE,DEFAULT_PRODUCT_ID) VALUES (9993,{ts '2099-01-06 00:00:00'},{ts '2001-02-24 00:00:00'},null,null,null,null,null,null,null,null,null,null,null,null,true,null,'bundle2',12.00,2.00,null,null,null,993);
INSERT INTO BLC_SKU_BUNDLE_ITEM (SKU_BUNDLE_ITEM_ID,ITEM_SALE_PRICE,QUANTITY,PRODUCT_BUNDLE_ID,SKU_ID) VALUES (-102,null,1,993,1);
INSERT INTO BLC_SKU_BUNDLE_ITEM (SKU_BUNDLE_ITEM_ID,ITEM_SALE_PRICE,QUANTITY,PRODUCT_BUNDLE_ID,SKU_ID) VALUES (-103,null,1,993,2);

------------------------------------------------------------------------------------------------------------------
-- Give some of the SKUs a sale price
------------------------------------------------------------------------------------------------------------------
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,SALE_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (17,17,'Insanity Sauce','This sauce gets its great flavor from aged peppers and cane vinegar. It will enhance the flavor of most any meal.',5.99,4.99,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,SALE_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (18,18,'Hurtin'' Jalepeno Hot Sauce','This sauce gets its great flavor from aged peppers and cane vinegar. It will enhance the flavor of most any meal.',5.99,4.49,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,SALE_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (19,19,'Roasted Red Pepper & Chipotle Hot Sauce','This sauce gets its great flavor from aged peppers and cane vinegar. It will enhance the flavor of most any meal.',5.99,4.09,'Y','Y',CURRENT_TIMESTAMP);

------------------------------------------------------------------------------------------------------------------
-- Some SKUs (such as merchandise) may be product options based on one product. For example, there may be a 
-- "Men's Hand drawn Heat Clinic Shirt" product that has up to 12 SKUs showing the options of 
-- Red/Black/Silver, and Small/Medium/Large/X-Large
------------------------------------------------------------------------------------------------------------------
INSERT INTO BLC_PRODUCT_OPTION (PRODUCT_OPTION_ID, OPTION_TYPE, ATTRIBUTE_NAME, LABEL, REQUIRED) VALUES (1, 'COLOR', 'COLOR', 'Shirt Color', TRUE);
INSERT INTO BLC_PRODUCT_OPTION (PRODUCT_OPTION_ID, OPTION_TYPE, ATTRIBUTE_NAME, LABEL, REQUIRED) VALUES (2, 'SIZE', 'SIZE', 'Shirt Size', TRUE);
INSERT INTO BLC_PRODUCT_OPTION (PRODUCT_OPTION_ID, OPTION_TYPE, ATTRIBUTE_NAME, LABEL, REQUIRED,USE_IN_SKU_GENERATION,VALIDATION_TYPE,VALIDATION_STRING,ERROR_MESSAGE,ERROR_CODE) VALUES (3, 'TEXT', 'NAME', 'Personalized Name', FALSE,FALSE,'REGEX','[a-zA-Z ]{3,30}','Name must be less than 30 characters, with only letters and spaces','INVALID_NAME');

INSERT INTO BLC_PRODUCT_OPTION_VALUE (PRODUCT_OPTION_VALUE_ID, ATTRIBUTE_VALUE, DISPLAY_ORDER, PRODUCT_OPTION_ID) VALUES (1, 'Black', 1, 1);
INSERT INTO BLC_PRODUCT_OPTION_VALUE (PRODUCT_OPTION_VALUE_ID, ATTRIBUTE_VALUE, DISPLAY_ORDER, PRODUCT_OPTION_ID) VALUES (2, 'Red', 2, 1);
INSERT INTO BLC_PRODUCT_OPTION_VALUE (PRODUCT_OPTION_VALUE_ID, ATTRIBUTE_VALUE, DISPLAY_ORDER, PRODUCT_OPTION_ID) VALUES (3, 'Silver', 3, 1);
INSERT INTO BLC_PRODUCT_OPTION_VALUE (PRODUCT_OPTION_VALUE_ID, ATTRIBUTE_VALUE, DISPLAY_ORDER, PRODUCT_OPTION_ID) VALUES (11, 'S', 1, 2);
INSERT INTO BLC_PRODUCT_OPTION_VALUE (PRODUCT_OPTION_VALUE_ID, ATTRIBUTE_VALUE, DISPLAY_ORDER, PRODUCT_OPTION_ID) VALUES (12, 'M', 2, 2);
INSERT INTO BLC_PRODUCT_OPTION_VALUE (PRODUCT_OPTION_VALUE_ID, ATTRIBUTE_VALUE, DISPLAY_ORDER, PRODUCT_OPTION_ID) VALUES (13, 'L', 3, 2);
INSERT INTO BLC_PRODUCT_OPTION_VALUE (PRODUCT_OPTION_VALUE_ID, ATTRIBUTE_VALUE, DISPLAY_ORDER, PRODUCT_OPTION_ID) VALUES (14, 'XL', 4, 2);

INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (100,100,'Hawt Like a Habanero Shirt (Men''s)','Men''s Habanero collection standard short sleeve screen-printed tee shirt in soft 30 singles cotton in regular fit.',14.99,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (200,200,'Hawt Like a Habanero Shirt (Women''s)','Women''s Habanero collection standard short sleeve screen-printed tee shirt in soft 30 singles cotton in regular fit.',14.99,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (300,300,'Heat Clinic Hand-Drawn (Men''s)','This hand-drawn logo shirt for men features a regular fit in three different colors',15.99,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (400,400,'Heat Clinic Hand-Drawn (Women''s)','This hand-drawn logo shirt for women features a regular fit in three different colors',15.99,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (500,500,'Heat Clinic Mascot (Men''s)','Don''t you just love our mascot? Get your very own shirt today!',15.99,'Y','Y',CURRENT_TIMESTAMP);
INSERT INTO BLC_SKU (SKU_ID,DEFAULT_PRODUCT_ID,NAME,LONG_DESCRIPTION,RETAIL_PRICE,TAXABLE_FLAG,DISCOUNTABLE_FLAG,ACTIVE_START_DATE) VALUES (600,600,'Heat Clinic Mascot (Women''s)','Don''t you just love our mascot? Get your very own shirt today!',15.99,'Y','Y',CURRENT_TIMESTAMP);

------------------------------------------------------------------------------------------------------------------
-- Update the DEFAULT_SKU_ID on the products
------------------------------------------------------------------------------------------------------------------
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 1 WHERE PRODUCT_ID = 1;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 2 WHERE PRODUCT_ID = 2;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 3 WHERE PRODUCT_ID = 3;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 4 WHERE PRODUCT_ID = 4;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 5 WHERE PRODUCT_ID = 5;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 6 WHERE PRODUCT_ID = 6;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 7 WHERE PRODUCT_ID = 7;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 8 WHERE PRODUCT_ID = 8;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 9 WHERE PRODUCT_ID = 9;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 10 WHERE PRODUCT_ID = 10;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 11 WHERE PRODUCT_ID = 11;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 12 WHERE PRODUCT_ID = 12;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 13 WHERE PRODUCT_ID = 13;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 14 WHERE PRODUCT_ID = 14;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 15 WHERE PRODUCT_ID = 15;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 16 WHERE PRODUCT_ID = 16;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 17 WHERE PRODUCT_ID = 17;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 18 WHERE PRODUCT_ID = 18;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 19 WHERE PRODUCT_ID = 19;

UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 9992 WHERE PRODUCT_ID = 992;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 9993 WHERE PRODUCT_ID = 993;

UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 100 WHERE PRODUCT_ID = 100;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 200 WHERE PRODUCT_ID = 200;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 300 WHERE PRODUCT_ID = 300;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 400 WHERE PRODUCT_ID = 400;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 500 WHERE PRODUCT_ID = 500;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 600 WHERE PRODUCT_ID = 600;

-- Meals
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 700 WHERE PRODUCT_ID = 700;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 701 WHERE PRODUCT_ID = 701;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 702 WHERE PRODUCT_ID = 702;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 703 WHERE PRODUCT_ID = 703;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 704 WHERE PRODUCT_ID = 704;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 705 WHERE PRODUCT_ID = 705;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 706 WHERE PRODUCT_ID = 706;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 707 WHERE PRODUCT_ID = 707;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 708 WHERE PRODUCT_ID = 708;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 709 WHERE PRODUCT_ID = 709;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 710 WHERE PRODUCT_ID = 710;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 711 WHERE PRODUCT_ID = 711;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 712 WHERE PRODUCT_ID = 712;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 713 WHERE PRODUCT_ID = 713;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 714 WHERE PRODUCT_ID = 714;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 715 WHERE PRODUCT_ID = 715;

UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 716 WHERE PRODUCT_ID = 716;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 717 WHERE PRODUCT_ID = 717;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 718 WHERE PRODUCT_ID = 718;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 719 WHERE PRODUCT_ID = 719;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 720 WHERE PRODUCT_ID = 720;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 721 WHERE PRODUCT_ID = 721;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 722 WHERE PRODUCT_ID = 722;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 723 WHERE PRODUCT_ID = 723;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 724 WHERE PRODUCT_ID = 724;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 725 WHERE PRODUCT_ID = 725;
UPDATE BLC_PRODUCT SET DEFAULT_SKU_ID = 726 WHERE PRODUCT_ID = 726;


------------------------------------------------------------------------------------------------------------------
-- Create non-default SKUs for some merchandise. In this case, we're stating that all XL shirts are $1.00 more
-- All other combinations have no special properties, but we must create them so we can track inventory on a 
-- per-SKU level. Generally, either you have only a default SKU or SKUs for all permutations of product options
------------------------------------------------------------------------------------------------------------------
INSERT INTO BLC_SKU (SKU_ID,RETAIL_PRICE,DISCOUNTABLE_FLAG) VALUES (114,16.99,'Y');
INSERT INTO BLC_SKU (SKU_ID,RETAIL_PRICE,DISCOUNTABLE_FLAG) VALUES (124,16.99,'Y');
INSERT INTO BLC_SKU (SKU_ID,RETAIL_PRICE,DISCOUNTABLE_FLAG) VALUES (134,16.99,'Y');
INSERT INTO BLC_SKU (SKU_ID,RETAIL_PRICE,DISCOUNTABLE_FLAG) VALUES (214,16.99,'Y');
INSERT INTO BLC_SKU (SKU_ID,RETAIL_PRICE,DISCOUNTABLE_FLAG) VALUES (224,16.99,'Y');
INSERT INTO BLC_SKU (SKU_ID,RETAIL_PRICE,DISCOUNTABLE_FLAG) VALUES (234,16.99,'Y');
INSERT INTO BLC_SKU (SKU_ID,RETAIL_PRICE,DISCOUNTABLE_FLAG) VALUES (314,16.99,'Y');
INSERT INTO BLC_SKU (SKU_ID,RETAIL_PRICE,DISCOUNTABLE_FLAG) VALUES (324,16.99,'Y');
INSERT INTO BLC_SKU (SKU_ID,RETAIL_PRICE,DISCOUNTABLE_FLAG) VALUES (334,16.99,'Y');
INSERT INTO BLC_SKU (SKU_ID,RETAIL_PRICE,DISCOUNTABLE_FLAG) VALUES (414,16.99,'Y');
INSERT INTO BLC_SKU (SKU_ID,RETAIL_PRICE,DISCOUNTABLE_FLAG) VALUES (424,16.99,'Y');
INSERT INTO BLC_SKU (SKU_ID,RETAIL_PRICE,DISCOUNTABLE_FLAG) VALUES (434,16.99,'Y');
INSERT INTO BLC_SKU (SKU_ID,RETAIL_PRICE,DISCOUNTABLE_FLAG) VALUES (514,16.99,'Y');
INSERT INTO BLC_SKU (SKU_ID,RETAIL_PRICE,DISCOUNTABLE_FLAG) VALUES (524,16.99,'Y');
INSERT INTO BLC_SKU (SKU_ID,RETAIL_PRICE,DISCOUNTABLE_FLAG) VALUES (534,16.99,'Y');
INSERT INTO BLC_SKU (SKU_ID,RETAIL_PRICE,DISCOUNTABLE_FLAG) VALUES (614,16.99,'Y');
INSERT INTO BLC_SKU (SKU_ID,RETAIL_PRICE,DISCOUNTABLE_FLAG) VALUES (624,16.99,'Y');
INSERT INTO BLC_SKU (SKU_ID,RETAIL_PRICE,DISCOUNTABLE_FLAG) VALUES (634,16.99,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (111,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (112,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (113,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (121,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (122,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (123,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (131,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (132,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (133,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (211,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (212,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (213,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (221,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (222,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (223,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (231,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (232,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (233,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (311,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (312,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (313,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (321,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (322,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (323,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (331,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (332,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (333,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (411,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (412,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (413,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (421,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (422,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (423,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (431,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (432,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (433,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (511,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (512,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (513,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (521,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (522,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (523,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (531,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (532,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (533,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (611,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (612,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (613,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (621,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (622,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (623,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (631,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (632,'Y');
INSERT INTO BLC_SKU (SKU_ID,DISCOUNTABLE_FLAG) VALUES (633,'Y');

------------------------------------------------------------------------------------------------------------------
-- Associate the appropriate option values for the skus
------------------------------------------------------------------------------------------------------------------
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (111, 1), (111, 11);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (112, 1), (112, 12);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (113, 1), (113, 13);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (114, 1), (114, 14);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (121, 2), (121, 11);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (122, 2), (122, 12);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (123, 2), (123, 13);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (124, 2), (124, 14);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (131, 3), (131, 11);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (132, 3), (132, 12);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (133, 3), (133, 13);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (134, 3), (134, 14);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (211, 1), (211, 11);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (212, 1), (212, 12);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (213, 1), (213, 13);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (214, 1), (214, 14);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (221, 2), (221, 11);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (222, 2), (222, 12);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (223, 2), (223, 13);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (224, 2), (224, 14);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (231, 3), (231, 11);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (232, 3), (232, 12);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (233, 3), (233, 13);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (234, 3), (234, 14);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (311, 1), (311, 11);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (312, 1), (312, 12);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (313, 1), (313, 13);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (314, 1), (314, 14);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (321, 2), (321, 11);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (322, 2), (322, 12);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (323, 2), (323, 13);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (324, 2), (324, 14);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (331, 3), (331, 11);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (332, 3), (332, 12);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (333, 3), (333, 13);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (334, 3), (334, 14);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (411, 1), (411, 11);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (412, 1), (412, 12);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (413, 1), (413, 13);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (414, 1), (414, 14);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (421, 2), (421, 11);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (422, 2), (422, 12);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (423, 2), (423, 13);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (424, 2), (424, 14);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (431, 3), (431, 11);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (432, 3), (432, 12);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (433, 3), (433, 13);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (434, 3), (434, 14);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (511, 1), (511, 11);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (512, 1), (512, 12);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (513, 1), (513, 13);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (514, 1), (514, 14);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (521, 2), (521, 11);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (522, 2), (522, 12);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (523, 2), (523, 13);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (524, 2), (524, 14);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (531, 3), (531, 11);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (532, 3), (532, 12);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (533, 3), (533, 13);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (534, 3), (534, 14);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (611, 1), (611, 11);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (612, 1), (612, 12);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (613, 1), (613, 13);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (614, 1), (614, 14);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (621, 2), (621, 11);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (622, 2), (622, 12);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (623, 2), (623, 13);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (624, 2), (624, 14);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (631, 3), (631, 11);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (632, 3), (632, 12);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (633, 3), (633, 13);
INSERT INTO BLC_SKU_OPTION_VALUE_XREF (SKU_ID, PRODUCT_OPTION_VALUE_ID) VALUES (634, 3), (634, 14);


------------------------------------------------------------------------------------------------------------------
-- Add some heat levels to all the products
------------------------------------------------------------------------------------------------------------------
INSERT INTO BLC_PRODUCT_ATTRIBUTE (PRODUCT_ATTRIBUTE_ID, PRODUCT_ID, NAME, VALUE) VALUES (1, 1, 'heatRange', 4);
INSERT INTO BLC_PRODUCT_ATTRIBUTE (PRODUCT_ATTRIBUTE_ID, PRODUCT_ID, NAME, VALUE) VALUES (2, 2, 'heatRange', 1);
INSERT INTO BLC_PRODUCT_ATTRIBUTE (PRODUCT_ATTRIBUTE_ID, PRODUCT_ID, NAME, VALUE) VALUES (3, 3, 'heatRange', 2);
INSERT INTO BLC_PRODUCT_ATTRIBUTE (PRODUCT_ATTRIBUTE_ID, PRODUCT_ID, NAME, VALUE) VALUES (4, 4, 'heatRange', 2);
INSERT INTO BLC_PRODUCT_ATTRIBUTE (PRODUCT_ATTRIBUTE_ID, PRODUCT_ID, NAME, VALUE) VALUES (5, 5, 'heatRange', 4);
INSERT INTO BLC_PRODUCT_ATTRIBUTE (PRODUCT_ATTRIBUTE_ID, PRODUCT_ID, NAME, VALUE) VALUES (6, 6, 'heatRange', 4);
INSERT INTO BLC_PRODUCT_ATTRIBUTE (PRODUCT_ATTRIBUTE_ID, PRODUCT_ID, NAME, VALUE) VALUES (7, 7, 'heatRange', 3);
INSERT INTO BLC_PRODUCT_ATTRIBUTE (PRODUCT_ATTRIBUTE_ID, PRODUCT_ID, NAME, VALUE) VALUES (8, 8, 'heatRange', 4);
INSERT INTO BLC_PRODUCT_ATTRIBUTE (PRODUCT_ATTRIBUTE_ID, PRODUCT_ID, NAME, VALUE) VALUES (9, 9, 'heatRange', 5);
INSERT INTO BLC_PRODUCT_ATTRIBUTE (PRODUCT_ATTRIBUTE_ID, PRODUCT_ID, NAME, VALUE) VALUES (10, 10, 'heatRange', 5);
INSERT INTO BLC_PRODUCT_ATTRIBUTE (PRODUCT_ATTRIBUTE_ID, PRODUCT_ID, NAME, VALUE) VALUES (11, 11, 'heatRange', 2);
INSERT INTO BLC_PRODUCT_ATTRIBUTE (PRODUCT_ATTRIBUTE_ID, PRODUCT_ID, NAME, VALUE) VALUES (12, 12, 'heatRange', 1);
INSERT INTO BLC_PRODUCT_ATTRIBUTE (PRODUCT_ATTRIBUTE_ID, PRODUCT_ID, NAME, VALUE) VALUES (13, 13, 'heatRange', 2);
INSERT INTO BLC_PRODUCT_ATTRIBUTE (PRODUCT_ATTRIBUTE_ID, PRODUCT_ID, NAME, VALUE) VALUES (14, 14, 'heatRange', 2);
INSERT INTO BLC_PRODUCT_ATTRIBUTE (PRODUCT_ATTRIBUTE_ID, PRODUCT_ID, NAME, VALUE) VALUES (15, 15, 'heatRange', 1);
INSERT INTO BLC_PRODUCT_ATTRIBUTE (PRODUCT_ATTRIBUTE_ID, PRODUCT_ID, NAME, VALUE) VALUES (16, 16, 'heatRange', 3);
INSERT INTO BLC_PRODUCT_ATTRIBUTE (PRODUCT_ATTRIBUTE_ID, PRODUCT_ID, NAME, VALUE) VALUES (17, 17, 'heatRange', 5);
INSERT INTO BLC_PRODUCT_ATTRIBUTE (PRODUCT_ATTRIBUTE_ID, PRODUCT_ID, NAME, VALUE) VALUES (18, 18, 'heatRange', 3);
INSERT INTO BLC_PRODUCT_ATTRIBUTE (PRODUCT_ATTRIBUTE_ID, PRODUCT_ID, NAME, VALUE) VALUES (19, 19, 'heatRange', 1);

------------------------------------------------------------------------------------------------------------------
-- Link the non-default SKUs for merchandise
------------------------------------------------------------------------------------------------------------------
INSERT INTO BLC_PRODUCT_SKU_XREF (SKU_ID, PRODUCT_ID) VALUES (111, 100), (112, 100), (113, 100), (114, 100), (121, 100), (122, 100), (123, 100), (124, 100), (131, 100), (132, 100), (133, 100), (134, 100);
INSERT INTO BLC_PRODUCT_SKU_XREF (SKU_ID, PRODUCT_ID) VALUES (211, 200), (212, 200), (213, 200), (214, 200), (221, 200), (222, 200), (223, 200), (224, 200), (231, 200), (232, 200), (233, 200), (234, 200);
INSERT INTO BLC_PRODUCT_SKU_XREF (SKU_ID, PRODUCT_ID) VALUES (311, 300), (312, 300), (313, 300), (314, 300), (321, 300), (322, 300), (323, 300), (324, 300), (331, 300), (332, 300), (333, 300), (334, 300);
INSERT INTO BLC_PRODUCT_SKU_XREF (SKU_ID, PRODUCT_ID) VALUES (411, 400), (412, 400), (413, 400), (414, 400), (421, 400), (422, 400), (423, 400), (424, 400), (431, 400), (432, 400), (433, 400), (434, 400);
INSERT INTO BLC_PRODUCT_SKU_XREF (SKU_ID, PRODUCT_ID) VALUES (511, 500), (512, 500), (513, 500), (514, 500), (521, 500), (522, 500), (523, 500), (524, 500), (531, 500), (532, 500), (533, 500), (534, 500);
INSERT INTO BLC_PRODUCT_SKU_XREF (SKU_ID, PRODUCT_ID) VALUES (611, 600), (612, 600), (613, 600), (614, 600), (621, 600), (622, 600), (623, 600), (624, 600), (631, 600), (632, 600), (633, 600), (634, 600);

------------------------------------------------------------------------------------------------------------------
-- Associate the merchandise products with their appropriate available product options
------------------------------------------------------------------------------------------------------------------
INSERT INTO BLC_PRODUCT_OPTION_XREF (PRODUCT_OPTION_XREF_ID, PRODUCT_OPTION_ID, PRODUCT_ID) VALUES (1, 1, 100);
INSERT INTO BLC_PRODUCT_OPTION_XREF (PRODUCT_OPTION_XREF_ID, PRODUCT_OPTION_ID, PRODUCT_ID) VALUES (2, 1, 200);
INSERT INTO BLC_PRODUCT_OPTION_XREF (PRODUCT_OPTION_XREF_ID, PRODUCT_OPTION_ID, PRODUCT_ID) VALUES (3, 1, 300);
INSERT INTO BLC_PRODUCT_OPTION_XREF (PRODUCT_OPTION_XREF_ID, PRODUCT_OPTION_ID, PRODUCT_ID) VALUES (4, 1, 400);
INSERT INTO BLC_PRODUCT_OPTION_XREF (PRODUCT_OPTION_XREF_ID, PRODUCT_OPTION_ID, PRODUCT_ID) VALUES (5, 1, 500);
INSERT INTO BLC_PRODUCT_OPTION_XREF (PRODUCT_OPTION_XREF_ID, PRODUCT_OPTION_ID, PRODUCT_ID) VALUES (6, 1, 600);
INSERT INTO BLC_PRODUCT_OPTION_XREF (PRODUCT_OPTION_XREF_ID, PRODUCT_OPTION_ID, PRODUCT_ID) VALUES (7, 2, 100);
INSERT INTO BLC_PRODUCT_OPTION_XREF (PRODUCT_OPTION_XREF_ID, PRODUCT_OPTION_ID, PRODUCT_ID) VALUES (8, 2, 200);
INSERT INTO BLC_PRODUCT_OPTION_XREF (PRODUCT_OPTION_XREF_ID, PRODUCT_OPTION_ID, PRODUCT_ID) VALUES (9, 2, 300);
INSERT INTO BLC_PRODUCT_OPTION_XREF (PRODUCT_OPTION_XREF_ID, PRODUCT_OPTION_ID, PRODUCT_ID) VALUES (10, 2, 400);
INSERT INTO BLC_PRODUCT_OPTION_XREF (PRODUCT_OPTION_XREF_ID, PRODUCT_OPTION_ID, PRODUCT_ID) VALUES (11, 2, 500);
INSERT INTO BLC_PRODUCT_OPTION_XREF (PRODUCT_OPTION_XREF_ID, PRODUCT_OPTION_ID, PRODUCT_ID) VALUES (12, 2, 600);
INSERT INTO BLC_PRODUCT_OPTION_XREF (PRODUCT_OPTION_XREF_ID, PRODUCT_OPTION_ID, PRODUCT_ID) VALUES (13, 3, 100);

------------------------------------------------------------------------------------------------------------------
-- Load Catalog - Step 3:  Create Category/Product Mapping
-- ========================================================
-- Add all hot-sauce items to the hot-sauce category
------------------------------------------------------------------------------------------------------------------
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (1,1,2002,1);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (2,2,2002,2);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (3,3,2002,3);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (4,4,2002,4);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (5,5,2002,5);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (6,6,2002,6);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (7,7,2002,7);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (8,8,2002,8);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (9,9,2002,9);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (10,10,2002,10);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (11,11,2002,11);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (12,12,2002,12);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (13,13,2002,13);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (14,14,2002,14);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (15,15,2002,15);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (16,16,2002,16);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (17,17,2002,17);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (18,18,2002,18);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (19,19,2002,19);

-- home page items
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (20,3,2001,1);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (21,6,2001,2);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (22,9,2001,3);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (23,12,2001,4);

-- clearance items
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (24,7,2004,1);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (25,8,2004,2);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (26,10,2004,3);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (27,11,2004,4);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (28,18,2004,5);

-- merchandise items
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (29,100,2003,1);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (30,200,2003,2);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (31,300,2003,3);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (32,400,2003,4);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (33,500,2003,5);
INSERT INTO BLC_CATEGORY_PRODUCT_XREF (CATEGORY_PRODUCT_ID, PRODUCT_ID, CATEGORY_ID, DISPLAY_ORDER) VALUES (34,600,2003,6);

------------------------------------------------------------------------------------------------------------------
-- Load Catalog - Step 4:  Media Items used by products
-- ========================================================
------------------------------------------------------------------------------------------------------------------
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (101,'/cmsstatic/img/sauces/Sudden-Death-Sauce-Bottle.jpg','Sudden Death Sauce Bottle','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (102,'/cmsstatic/img/sauces/Sudden-Death-Sauce-Close.jpg','Sudden Death Sauce Close-up','alt1');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (201,'/cmsstatic/img/sauces/Sweet-Death-Sauce-Bottle.jpg','Sweet Death Sauce Bottle','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (202,'/cmsstatic/img/sauces/Sweet-Death-Sauce-Close.jpg','Sweet Death Sauce Close-up','alt1');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (203,'/cmsstatic/img/sauces/Sweet-Death-Sauce-Skull.jpg','Sweet Death Sauce Close-up','alt2');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (204,'/cmsstatic/img/sauces/Sweet-Death-Sauce-Tile.jpg','Sweet Death Sauce Close-up','alt3');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (205,'/cmsstatic/img/sauces/Sweet-Death-Sauce-Grass.jpg','Sweet Death Sauce Close-up','alt4');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (206,'/cmsstatic/img/sauces/Sweet-Death-Sauce-Logo.jpg','Sweet Death Sauce Close-up','alt5');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (301,'/cmsstatic/img/sauces/Hoppin-Hot-Sauce-Bottle.jpg','Hoppin Hot Sauce Bottle','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (302,'/cmsstatic/img/sauces/Hoppin-Hot-Sauce-Close.jpg','Hoppin Hot Sauce Close-up','alt1');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (401,'/cmsstatic/img/sauces/Day-of-the-Dead-Chipotle-Hot-Sauce-Bottle.jpg','Day of the Dead Chipotle Hot Sauce Bottle','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (402,'/cmsstatic/img/sauces/Day-of-the-Dead-Chipotle-Hot-Sauce-Close.jpg','Day of the Dead Chipotle Hot Sauce Close-up','alt1');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (501,'/cmsstatic/img/sauces/Day-of-the-Dead-Habanero-Hot-Sauce-Bottle.jpg','Day of the Dead Habanero Hot Sauce Bottle','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (502,'/cmsstatic/img/sauces/Day-of-the-Dead-Habanero-Hot-Sauce-Close.jpg','Day of the Dead Habanero Hot Sauce Close-up','alt1');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (601,'/cmsstatic/img/sauces/Day-of-the-Dead-Scotch-Bonnet-Hot-Sauce-Bottle.jpg','Day of the Dead Scotch Bonnet Hot Sauce Bottle','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (602,'/cmsstatic/img/sauces/Day-of-the-Dead-Scotch-Bonnet-Hot-Sauce-Close.jpg','Day of the Dead Scotch Bonnet Hot Sauce Close-up','alt1');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (701,'/cmsstatic/img/sauces/Green-Ghost-Bottle.jpg','Green Ghost Bottle','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (702,'/cmsstatic/img/sauces/Green-Ghost-Close.jpg','Green Ghost Close-up','alt1');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (801,'/cmsstatic/img/sauces/Blazin-Saddle-XXX-Hot-Habanero-Pepper-Sauce-Bottle.jpg','Blazin Saddle XXX Hot Habanero Pepper Sauce Bottle','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (802,'/cmsstatic/img/sauces/Blazin-Saddle-XXX-Hot-Habanero-Pepper-Sauce-Close.jpg','Blazin Saddle XXX Hot Habanero Pepper Sauce Close-up','alt1');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (901,'/cmsstatic/img/sauces/Armageddon-The-Hot-Sauce-To-End-All-Bottle.jpg','Armageddon The Hot Sauce To End All Bottle','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (902,'/cmsstatic/img/sauces/Armageddon-The-Hot-Sauce-To-End-All-Close.jpg','Armageddon The Hot Sauce To End All Close-up','alt1');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (1001,'/cmsstatic/img/sauces/Dr.-Chilemeisters-Insane-Hot-Sauce-Bottle.jpg','Dr. Chilemeisters Insane Hot Sauce Bottle','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (1002,'/cmsstatic/img/sauces/Dr.-Chilemeisters-Insane-Hot-Sauce-Close.jpg','Dr. Chilemeisters Insane Hot Sauce Close-up','alt1');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (1101,'/cmsstatic/img/sauces/Bull-Snort-Cowboy-Cayenne-Pepper-Hot-Sauce-Bottle.jpg','Bull Snort Cowboy Cayenne Pepper Hot Sauce Bottle','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (1102,'/cmsstatic/img/sauces/Bull-Snort-Cowboy-Cayenne-Pepper-Hot-Sauce-Close.jpg','Bull Snort Cowboy Cayenne Pepper Hot Sauce Close-up','alt1');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (1201,'/cmsstatic/img/sauces/Cafe-Louisiane-Sweet-Cajun-Blackening-Sauce-Bottle.jpg','Cafe Louisiane Sweet Cajun Blackening Sauce Bottle','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (1202,'/cmsstatic/img/sauces/Cafe-Louisiane-Sweet-Cajun-Blackening-Sauce-Close.jpg','Cafe Louisiane Sweet Cajun Blackening Sauce Close-up','alt1');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (1301,'/cmsstatic/img/sauces/Bull-Snort-Smokin-Toncils-Hot-Sauce-Bottle.jpg','Bull Snort Smokin Toncils Hot Sauce Bottle','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (1302,'/cmsstatic/img/sauces/Bull-Snort-Smokin-Toncils-Hot-Sauce-Close.jpg','Bull Snort Smokin Toncils Hot Sauce Close-up','alt1');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (1401,'/cmsstatic/img/sauces/Cool-Cayenne-Pepper-Hot-Sauce-Bottle.jpg','Cool Cayenne Pepper Hot Sauce Bottle','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (1402,'/cmsstatic/img/sauces/Cool-Cayenne-Pepper-Hot-Sauce-Close.jpg','Cool Cayenne Pepper Hot Sauce Close-up','alt1');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (1501,'/cmsstatic/img/sauces/Roasted-Garlic-Hot-Sauce-Bottle.jpg','Roasted Garlic Hot Sauce Bottle','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (1502,'/cmsstatic/img/sauces/Roasted-Garlic-Hot-Sauce-Close.jpg','Roasted Garlic Hot Sauce Close-up','alt1');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (1601,'/cmsstatic/img/sauces/Scotch-Bonnet-Hot-Sauce-Bottle.jpg','Scotch Bonnet Hot Sauce Bottle','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (1602,'/cmsstatic/img/sauces/Scotch-Bonnet-Hot-Sauce-Close.jpg','Scotch Bonnet Hot Sauce Close-up','alt1');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (1701,'/cmsstatic/img/sauces/Insanity-Sauce-Bottle.jpg','Insanity Sauce Bottle','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (1702,'/cmsstatic/img/sauces/Insanity-Sauce-Close.jpg','Insanity Sauce Close-up','alt1');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (1801,'/cmsstatic/img/sauces/Hurtin-Jalepeno-Hot-Sauce-Bottle.jpg','Hurtin Jalepeno Hot Sauce Bottle','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (1802,'/cmsstatic/img/sauces/Hurtin-Jalepeno-Hot-Sauce-Close.jpg','Hurtin Jalepeno Hot Sauce Close-up','alt1');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (1901,'/cmsstatic/img/sauces/Roasted-Red-Pepper-and-Chipotle-Hot-Sauce-Bottle.jpg','Roasted Red Pepper and Chipotle Hot Sauce Bottle','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (1902,'/cmsstatic/img/sauces/Roasted-Red-Pepper-and-Chipotle-Hot-Sauce-Close.jpg','Roasted Red Pepper and Chipotle Hot Sauce Close-up','alt1');

-- Meals
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70000,'/cmsstatic/img/meal/macncheese.jpg','Mac and Cheese','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70001,'/cmsstatic/img/meal/wrap.jpg','Falafel Wrap','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70002,'/cmsstatic/img/meal/beefBrisket.jpg','Beef Brisket','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70003,'/cmsstatic/img/meal/dinnerMeal1.jpg','Cranberry Island Salad','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70004,'/cmsstatic/img/meal/dinnerMeal2.jpg','Poached Salmon','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70005,'/cmsstatic/img/meal/dinnerMeal3.jpg','Mac and Cheese','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70006,'/cmsstatic/img/meal/cereal.jpg','Cereal','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70007,'/cmsstatic/img/meal/omelette.jpg','Omelette','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70008,'/cmsstatic/img/meal/beef.jpg','Chicken (lunch)','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70009,'/cmsstatic/img/meal/chicken.jpg','Beef (lunch)','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70010,'/cmsstatic/img/meal/fish.jpg','Fish (lunch)','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70011,'/cmsstatic/img/meal/veggies.jpg','Vegetables (lunch)','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70012,'/cmsstatic/img/meal/beef.jpg','Chicken (dinner)','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70013,'/cmsstatic/img/meal/chicken.jpg','Beef (dinner)','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70014,'/cmsstatic/img/meal/fish.jpg','Fish (dinner)','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70015,'/cmsstatic/img/meal/veggies.jpg','Vegetables (dinner)','primary');

INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70016,'/cmsstatic/img/meal/atlanticsalmon.jpg','Atlantic salmon on a creamy mushroom risotto','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70017,'/cmsstatic/img/meal/cheese-tortellini.jpg','Cheese tortellini','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70018,'/cmsstatic/img/meal/beef-tenderloin.jpg','Beef tenderloin','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70019,'/cmsstatic/img/meal/green-curry-chicken.jpg','Chicken breast pieces napped with a green curry sauce','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70020,'/cmsstatic/img/meal/parsley-omelet.jpg','Parsley Omelet w/Chicken Sausage','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70021,'/cmsstatic/img/meal/pancake-cranapple.jpg','Pancake with Cran-Apple Compote','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70022,'/cmsstatic/img/meal/oatmeal-cold.jpg','Cold Breakfast choice with oatmeal','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70023,'/cmsstatic/img/meal/atlanticsalmon.jpg','Atlantic salmon on a creamy mushroom risotto','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70024,'/cmsstatic/img/meal/cheese-tortellini.jpg','Cheese tortellini','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70025,'/cmsstatic/img/meal/beef-tenderloin.jpg','Beef tenderloin','primary');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT) VALUES (70026,'/cmsstatic/img/meal/green-curry-chicken.jpg','Chicken breast pieces napped with a green curry sauce','primary');


INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT, TAGS) VALUES (10001,'/cmsstatic/img/merch/habanero_mens_black.jpg','Hawt Like a Habanero Men''s Black','primary','Black');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT, TAGS) VALUES (10002,'/cmsstatic/img/merch/habanero_mens_red.jpg','Hawt Like a Habanero Men''s Red','primary','Red');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT, TAGS) VALUES (10003,'/cmsstatic/img/merch/habanero_mens_silver.jpg','Hawt Like a Habanero Men''s Silver','primary','Silver');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT, TAGS) VALUES (20001,'/cmsstatic/img/merch/habanero_womens_black.jpg','Hawt Like a Habanero Women''s Black','primary','Black');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT, TAGS) VALUES (20002,'/cmsstatic/img/merch/habanero_womens_red.jpg','Hawt Like a Habanero Women''s Red','primary','Red');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT, TAGS) VALUES (20003,'/cmsstatic/img/merch/habanero_womens_silver.jpg','Hawt Like a Habanero Women''s Silver','primary','Silver');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT, TAGS) VALUES (30001,'/cmsstatic/img/merch/heat_clinic_handdrawn_mens_black.jpg','Heat Clinic Hand-Drawn Men''s Black','primary', 'Black');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT, TAGS) VALUES (30002,'/cmsstatic/img/merch/heat_clinic_handdrawn_mens_red.jpg','Heat Clinic Hand-Drawn Men''s Red','primary', 'Red');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT, TAGS) VALUES (30003,'/cmsstatic/img/merch/heat_clinic_handdrawn_mens_silver.jpg','Heat Clinic Hand-Drawn Men''s Silver','primary', 'Silver');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT, TAGS) VALUES (40001,'/cmsstatic/img/merch/heat_clinic_handdrawn_womens_black.jpg','Heat Clinic Hand-Drawn Women''s Black','primary', 'Black');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT, TAGS) VALUES (40002,'/cmsstatic/img/merch/heat_clinic_handdrawn_womens_red.jpg','Heat Clinic Hand-Drawn Women''s Red','primary', 'Red');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT, TAGS) VALUES (40003,'/cmsstatic/img/merch/heat_clinic_handdrawn_womens_silver.jpg','Heat Clinic Hand-Drawn Women''s Silver','primary', 'Silver');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT, TAGS) VALUES (50001,'/cmsstatic/img/merch/heat_clinic_mascot_mens_black.jpg','Heat Clinic Mascot Men''s Black','primary', 'Black');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT, TAGS) VALUES (50002,'/cmsstatic/img/merch/heat_clinic_mascot_mens_red.jpg','Heat Clinic Mascot Men''s Red','primary', 'Red');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT, TAGS) VALUES (50003,'/cmsstatic/img/merch/heat_clinic_mascot_mens_silver.jpg','Heat Clinic Mascot Men''s Silver','primary', 'Silver');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT, TAGS) VALUES (60001,'/cmsstatic/img/merch/heat_clinic_mascot_womens_black.jpg','Heat Clinic Mascot Women''s Black','primary', 'Black');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT, TAGS) VALUES (60002,'/cmsstatic/img/merch/heat_clinic_mascot_womens_red.jpg','Heat Clinic Mascot Women''s Red','primary', 'Red');
INSERT INTO BLC_MEDIA (MEDIA_ID, URL, TITLE, ALT_TEXT, TAGS) VALUES (60003,'/cmsstatic/img/merch/heat_clinic_mascot_womens_silver.jpg','Heat Clinic Mascot Women''s Silver','primary', 'Silver');


------------------------------------------------------------------------------------------------------------------
-- Load Catalog - Step 5:  Mapping for product to media
-- ========================================================
------------------------------------------------------------------------------------------------------------------
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (1,101,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (2,201,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (3,301,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (4,401,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (5,501,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (6,601,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (7,701,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (8,801,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (9,901,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (10,1001,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (11,1101,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (12,1201,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (13,1301,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (14,1401,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (15,1501,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (16,1601,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (17,1701,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (18,1801,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (19,1901,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (1,102,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (2,202,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (3,302,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (4,402,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (5,502,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (6,602,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (7,702,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (8,802,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (9,902,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (10,1002,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (11,1102,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (12,1202,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (13,1302,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (14,1402,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (15,1502,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (16,1602,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (17,1702,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (18,1802,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (19,1902,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (2,203,'alt2');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (2,204,'alt3');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (2,205,'alt4');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (2,206,'alt5');

INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (100,10001,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (200,20002,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (300,30003,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (400,40002,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (500,50003,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (600,60001,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (100,10002,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (200,20001,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (300,30001,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (400,40001,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (500,50001,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (600,60002,'alt1');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (100,10003,'alt2');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (200,20003,'alt2');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (300,30002,'alt2');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (400,40003,'alt2');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (500,50002,'alt2');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (600,60003,'alt2');

-- Meals
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (700,70000,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (701,70001,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (702,70002,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (703,70003,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (704,70004,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (705,70005,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (706,70006,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (707,70007,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (708,70008,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (709,70009,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (710,70010,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (711,70011,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (712,70012,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (713,70013,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (714,70014,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (715,70015,'primary');

INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (716,70016,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (717,70017,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (718,70018,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (719,70019,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (720,70020,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (721,70021,'primary'); 
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (722,70022,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (723,70023,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (724,70024,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (725,70025,'primary');
INSERT INTO BLC_SKU_MEDIA_MAP (BLC_SKU_SKU_ID, MEDIA_ID, MAP_KEY) VALUES (726,70026,'primary');

------------------------------------------------------------------------------------------------------------------
-- Load Catalog - Step 5: Asset Items (media)
-- ========================================================
------------------------------------------------------------------------------------------------------------------
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (101,'image/jpg','FILESYSTEM','/img/sauces/Sudden-Death-Sauce-Bottle.jpg','Sudden Death Sauce Bottle');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (102,'image/jpg','FILESYSTEM','/img/sauces/Sudden-Death-Sauce-Close.jpg','Sudden Death Sauce Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (201,'image/jpg','FILESYSTEM','/img/sauces/Sweet-Death-Sauce-Bottle.jpg','Sweet Death Sauce Bottle');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (202,'image/jpg','FILESYSTEM','/img/sauces/Sweet-Death-Sauce-Close.jpg','Sweet Death Sauce Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (203,'image/jpg','FILESYSTEM','/img/sauces/Sweet-Death-Sauce-Skull.jpg','Sweet Death Sauce Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (204,'image/jpg','FILESYSTEM','/img/sauces/Sweet-Death-Sauce-Tile.jpg','Sweet Death Sauce Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (205,'image/jpg','FILESYSTEM','/img/sauces/Sweet-Death-Sauce-Grass.jpg','Sweet Death Sauce Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (206,'image/jpg','FILESYSTEM','/img/sauces/Sweet-Death-Sauce-Logo.jpg','Sweet Death Sauce Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (301,'image/jpg','FILESYSTEM','/img/sauces/Hoppin-Hot-Sauce-Bottle.jpg','Hoppin Hot Sauce Bottle');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (302,'image/jpg','FILESYSTEM','/img/sauces/Hoppin-Hot-Sauce-Close.jpg','Hoppin Hot Sauce Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (401,'image/jpg','FILESYSTEM','/img/sauces/Day-of-the-Dead-Chipotle-Hot-Sauce-Bottle.jpg','Day of the Dead Chipotle Hot Sauce Bottle');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (402,'image/jpg','FILESYSTEM','/img/sauces/Day-of-the-Dead-Chipotle-Hot-Sauce-Close.jpg','Day of the Dead Chipotle Hot Sauce Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (501,'image/jpg','FILESYSTEM','/img/sauces/Day-of-the-Dead-Habanero-Hot-Sauce-Bottle.jpg','Day of the Dead Habanero Hot Sauce Bottle');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (502,'image/jpg','FILESYSTEM','/img/sauces/Day-of-the-Dead-Habanero-Hot-Sauce-Close.jpg','Day of the Dead Habanero Hot Sauce Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (601,'image/jpg','FILESYSTEM','/img/sauces/Day-of-the-Dead-Scotch-Bonnet-Hot-Sauce-Bottle.jpg','Day of the Dead Scotch Bonnet Hot Sauce Bottle');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (602,'image/jpg','FILESYSTEM','/img/sauces/Day-of-the-Dead-Scotch-Bonnet-Hot-Sauce-Close.jpg','Day of the Dead Scotch Bonnet Hot Sauce Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (701,'image/jpg','FILESYSTEM','/img/sauces/Green-Ghost-Bottle.jpg','Green Ghost Bottle');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (702,'image/jpg','FILESYSTEM','/img/sauces/Green-Ghost-Close.jpg','Green Ghost Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (801,'image/jpg','FILESYSTEM','/img/sauces/Blazin-Saddle-XXX-Hot-Habanero-Pepper-Sauce-Bottle.jpg','Blazin Saddle XXX Hot Habanero Pepper Sauce Bottle');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (802,'image/jpg','FILESYSTEM','/img/sauces/Blazin-Saddle-XXX-Hot-Habanero-Pepper-Sauce-Close.jpg','Blazin Saddle XXX Hot Habanero Pepper Sauce Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (901,'image/jpg','FILESYSTEM','/img/sauces/Armageddon-The-Hot-Sauce-To-End-All-Bottle.jpg','Armageddon The Hot Sauce To End All Bottle');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (902,'image/jpg','FILESYSTEM','/img/sauces/Armageddon-The-Hot-Sauce-To-End-All-Close.jpg','Armageddon The Hot Sauce To End All Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (1001,'image/jpg','FILESYSTEM','/img/sauces/Dr.-Chilemeisters-Insane-Hot-Sauce-Bottle.jpg','Dr. Chilemeisters Insane Hot Sauce Bottle');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (1002,'image/jpg','FILESYSTEM','/img/sauces/Dr.-Chilemeisters-Insane-Hot-Sauce-Close.jpg','Dr. Chilemeisters Insane Hot Sauce Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (1101,'image/jpg','FILESYSTEM','/img/sauces/Bull-Snort-Cowboy-Cayenne-Pepper-Hot-Sauce-Bottle.jpg','Bull Snort Cowboy Cayenne Pepper Hot Sauce Bottle');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (1102,'image/jpg','FILESYSTEM','/img/sauces/Bull-Snort-Cowboy-Cayenne-Pepper-Hot-Sauce-Close.jpg','Bull Snort Cowboy Cayenne Pepper Hot Sauce Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (1201,'image/jpg','FILESYSTEM','/img/sauces/Cafe-Louisiane-Sweet-Cajun-Blackening-Sauce-Bottle.jpg','Cafe Louisiane Sweet Cajun Blackening Sauce Bottle');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (1202,'image/jpg','FILESYSTEM','/img/sauces/Cafe-Louisiane-Sweet-Cajun-Blackening-Sauce-Close.jpg','Cafe Louisiane Sweet Cajun Blackening Sauce Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (1301,'image/jpg','FILESYSTEM','/img/sauces/Bull-Snort-Smokin-Toncils-Hot-Sauce-Bottle.jpg','Bull Snort Smokin Toncils Hot Sauce Bottle');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (1302,'image/jpg','FILESYSTEM','/img/sauces/Bull-Snort-Smokin-Toncils-Hot-Sauce-Close.jpg','Bull Snort Smokin Toncils Hot Sauce Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (1401,'image/jpg','FILESYSTEM','/img/sauces/Cool-Cayenne-Pepper-Hot-Sauce-Bottle.jpg','Cool Cayenne Pepper Hot Sauce Bottle');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (1402,'image/jpg','FILESYSTEM','/img/sauces/Cool-Cayenne-Pepper-Hot-Sauce-Close.jpg','Cool Cayenne Pepper Hot Sauce Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (1501,'image/jpg','FILESYSTEM','/img/sauces/Roasted-Garlic-Hot-Sauce-Bottle.jpg','Roasted Garlic Hot Sauce Bottle');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (1502,'image/jpg','FILESYSTEM','/img/sauces/Roasted-Garlic-Hot-Sauce-Close.jpg','Roasted Garlic Hot Sauce Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (1601,'image/jpg','FILESYSTEM','/img/sauces/Scotch-Bonnet-Hot-Sauce-Bottle.jpg','Scotch Bonnet Hot Sauce Bottle');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (1602,'image/jpg','FILESYSTEM','/img/sauces/Scotch-Bonnet-Hot-Sauce-Close.jpg','Scotch Bonnet Hot Sauce Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (1701,'image/jpg','FILESYSTEM','/img/sauces/Insanity-Sauce-Bottle.jpg','Insanity Sauce Bottle');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (1702,'image/jpg','FILESYSTEM','/img/sauces/Insanity-Sauce-Close.jpg','Insanity Sauce Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (1801,'image/jpg','FILESYSTEM','/img/sauces/Hurtin-Jalepeno-Hot-Sauce-Bottle.jpg','Hurtin Jalepeno Hot Sauce Bottle');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (1802,'image/jpg','FILESYSTEM','/img/sauces/Hurtin-Jalepeno-Hot-Sauce-Close.jpg','Hurtin Jalepeno Hot Sauce Close-up');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (1901,'image/jpg','FILESYSTEM','/img/sauces/Roasted-Red-Pepper-and-Chipotle-Hot-Sauce-Bottle.jpg','Roasted Red Pepper and Chipotle Hot Sauce Bottle');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (1902,'image/jpg','FILESYSTEM','/img/sauces/Roasted-Red-Pepper-and-Chipotle-Hot-Sauce-Close.jpg','Roasted Red Pepper and Chipotle Hot Sauce Close-up');

INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (10001,'image/jpg','FILESYSTEM','/img/merch/habanero_mens_black.jpg','Hawt Like a Habanero Men''s Black');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (10002,'image/jpg','FILESYSTEM','/img/merch/habanero_mens_red.jpg','Hawt Like a Habanero Men''s Red');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (10003,'image/jpg','FILESYSTEM','/img/merch/habanero_mens_silver.jpg','Hawt Like a Habanero Men''s Silver');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (20001,'image/jpg','FILESYSTEM','/img/merch/habanero_womens_black.jpg','Hawt Like a Habanero Women''s Black');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (20002,'image/jpg','FILESYSTEM','/img/merch/habanero_womens_red.jpg','Hawt Like a Habanero Women''s Red');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (20003,'image/jpg','FILESYSTEM','/img/merch/habanero_womens_silver.jpg','Hawt Like a Habanero Women''s Silver');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (30001,'image/jpg','FILESYSTEM','/img/merch/heat_clinic_handdrawn_mens_black.jpg','Heat Clinic Hand-Drawn Men''s Black');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (30002,'image/jpg','FILESYSTEM','/img/merch/heat_clinic_handdrawn_mens_red.jpg','Heat Clinic Hand-Drawn Men''s Red');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (30003,'image/jpg','FILESYSTEM','/img/merch/heat_clinic_handdrawn_mens_silver.jpg','Heat Clinic Hand-Drawn Men''s Silver');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (40001,'image/jpg','FILESYSTEM','/img/merch/heat_clinic_handdrawn_womens_black.jpg','Heat Clinic Hand-Drawn Women''s Black');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (40002,'image/jpg','FILESYSTEM','/img/merch/heat_clinic_handdrawn_womens_red.jpg','Heat Clinic Hand-Drawn Women''s Red');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (40003,'image/jpg','FILESYSTEM','/img/merch/heat_clinic_handdrawn_womens_silver.jpg','Heat Clinic Hand-Drawn Women''s Silver');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (50001,'image/jpg','FILESYSTEM','/img/merch/heat_clinic_mascot_mens_black.jpg','Heat Clinic Mascot Men''s Black');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (50002,'image/jpg','FILESYSTEM','/img/merch/heat_clinic_mascot_mens_red.jpg','Heat Clinic Mascot Men''s Red');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (50003,'image/jpg','FILESYSTEM','/img/merch/heat_clinic_mascot_mens_silver.jpg','Heat Clinic Mascot Men''s Silver');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (60001,'image/jpg','FILESYSTEM','/img/merch/heat_clinic_mascot_womens_black.jpg','Heat Clinic Mascot Women''s Black');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (60002,'image/jpg','FILESYSTEM','/img/merch/heat_clinic_mascot_womens_red.jpg','Heat Clinic Mascot Women''s Red');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (60003,'image/jpg','FILESYSTEM','/img/merch/heat_clinic_mascot_womens_silver.jpg','Heat Clinic Mascot Women''s Silver');

-- Meals
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70000,'image/jpg','FILESYSTEM','/img/meal/macncheese.jpg','Macaroni and Cheese');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70001,'image/jpg','FILESYSTEM','/img/meal/wrap.jpg','Falafel Wrap');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70002,'image/jpg','FILESYSTEM','/img/meal/beefBrisket.jpg','Beef Brisket Sandwich ');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70003,'image/jpg','FILESYSTEM','/img/meal/dinnerMeal1.jpg','Cranberry Island Salad');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70004,'image/jpg','FILESYSTEM','/img/meal/dinnerMeal2.jpg','Poached Salmon with Watercress and Peaches');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70005,'image/jpg','FILESYSTEM','/img/meal/dinnerMeal3.jpg','Conchiglie with Shrimp');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70006,'image/jpg','FILESYSTEM','/img/meal/cereal.jpg','Cereal');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70007,'image/jpg','FILESYSTEM','/img/meal/omelette.jpg','Omelette');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70008,'image/jpg','FILESYSTEM','/img/meal/chicken.jpg','Chicken');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70009,'image/jpg','FILESYSTEM','/img/meal/beef.jpg','Beef');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70010,'image/jpg','FILESYSTEM','/img/meal/fish.jpg','Fish');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70011,'image/jpg','FILESYSTEM','/img/meal/veggies.jpg','Vegetables');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70012,'image/jpg','FILESYSTEM','/img/meal/chicken.jpg','Chicken');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70013,'image/jpg','FILESYSTEM','/img/meal/beef.jpg','Beef');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70014,'image/jpg','FILESYSTEM','/img/meal/fish.jpg','Fish');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70015,'image/jpg','FILESYSTEM','/img/meal/veggies.jpg','Vegetables');

INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70016,'image/jpg','FILESYSTEM','/img/meal/atlanticsalmon.jpg','Atlantic Salmon');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70017,'image/jpg','FILESYSTEM','/img/meal/cheese-tortellini.jpg','Cheese Tortellini');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70018,'image/jpg','FILESYSTEM','/img/meal/beef-tenderloin.jpg','Beef Tenderloin');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70019,'image/jpg','FILESYSTEM','/img/meal/green-curry-chicken.jpg','Green Curry Chicken');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70020,'image/jpg','FILESYSTEM','/img/meal/parsley-omelet.jpg','Parsley Omelet');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70021,'image/jpg','FILESYSTEM','/img/meal/pancake-cranapple.jpg','Pancake Cranapple');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70022,'image/jpg','FILESYSTEM','/img/meal/oatmeal-cold.jpg','Oatmeal Cold');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70023,'image/jpg','FILESYSTEM','/img/meal/atlanticsalmon.jpg','Atlantic Salmon');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70024,'image/jpg','FILESYSTEM','/img/meal/cheese-tortellini.jpg','Cheese Tortellini');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70025,'image/jpg','FILESYSTEM','/img/meal/beef-tenderloin.jpg','Beef Tenderloin');
INSERT INTO BLC_STATIC_ASSET (STATIC_ASSET_ID, MIME_TYPE, STORAGE_TYPE, FULL_URL, NAME) VALUES (70026,'image/jpg','FILESYSTEM','/img/meal/green-curry-chicken.jpg','Green Curry Chicken');

------------------------------------------------------------------------------------------------------------------
-- End of Catalog load
-- ========================================================
------------------------------------------------------------------------------------------------------------------

INSERT INTO BLC_URL_HANDLER(URL_HANDLER_ID, INCOMING_URL, NEW_URL, URL_REDIRECT_TYPE) VALUES (1, '/googlePerm', 'http://www.google.com', 'REDIRECT_PERM');
INSERT INTO BLC_URL_HANDLER(URL_HANDLER_ID, INCOMING_URL, NEW_URL, URL_REDIRECT_TYPE) VALUES (2, '/googleTemp', 'http://www.google.com', 'REDIRECT_TEMP');
INSERT INTO BLC_URL_HANDLER(URL_HANDLER_ID, INCOMING_URL, NEW_URL, URL_REDIRECT_TYPE) VALUES (3, '/insanity', '/hot-sauces/insanity_sauce', 'FORWARD');
INSERT INTO BLC_URL_HANDLER(URL_HANDLER_ID, INCOMING_URL, NEW_URL, URL_REDIRECT_TYPE) VALUES (4, '/jalepeno', '/hot-sauces/hurtin_jalepeno_hot_sauce', 'REDIRECT_TEMP');

INSERT INTO BLC_SEARCH_INTERCEPT(SEARCH_REDIRECT_ID, PRIORITY,SEARCH_TERM, URL) VALUES (1,1, 'insanity', '/hot-sauces/insanity_sauce');
INSERT INTO BLC_SEARCH_INTERCEPT(SEARCH_REDIRECT_ID,PRIORITY, SEARCH_TERM, URL,ACTIVE_START_DATE,ACTIVE_END_DATE) VALUES (2,-10, 'new york', '/search?q=pace picante','1992-10-15 14:28:36','1999-10-15 21:28:36');

-----------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
-- RELATED PRODUCT - DATA (featured products for right-hand side display)
-----------------------------------------------------------------------------------------------------------------------------------
-- Adding to root category
INSERT INTO BLC_PRODUCT_FEATURED(FEATURED_PRODUCT_ID, SEQUENCE, CATEGORY_ID, PRODUCT_ID)  VALUES (1, 1, 1, 18);
INSERT INTO BLC_PRODUCT_FEATURED(FEATURED_PRODUCT_ID, SEQUENCE, CATEGORY_ID, PRODUCT_ID)  VALUES (2, 2, 1, 15);
INSERT INTO BLC_PRODUCT_FEATURED(FEATURED_PRODUCT_ID, SEQUENCE, CATEGORY_ID, PRODUCT_ID)  VALUES (3, 3, 1, 200);
INSERT INTO BLC_PRODUCT_FEATURED(FEATURED_PRODUCT_ID, SEQUENCE, CATEGORY_ID, PRODUCT_ID)  VALUES (4, 4, 1, 100);

-- Adding to merchandise category
INSERT INTO BLC_PRODUCT_FEATURED(FEATURED_PRODUCT_ID, SEQUENCE, CATEGORY_ID, PRODUCT_ID)  VALUES (5, 1, 2003, 4);

-- Adding to hot-sauces category
INSERT INTO BLC_PRODUCT_FEATURED(FEATURED_PRODUCT_ID, SEQUENCE, CATEGORY_ID, PRODUCT_ID)  VALUES (8, 1, 2002, 500);
INSERT INTO BLC_PRODUCT_FEATURED(FEATURED_PRODUCT_ID, SEQUENCE, CATEGORY_ID, PRODUCT_ID)  VALUES (9, 2, 2002, 200);
INSERT INTO BLC_PRODUCT_FEATURED(FEATURED_PRODUCT_ID, SEQUENCE, CATEGORY_ID, PRODUCT_ID)  VALUES (10, 3, 2002, 300);

-- Adding a 20% off sale to Merchandise category to fit the Shirts Special Homepage Banner
INSERT INTO BLC_OFFER (OFFER_ID, APPLIES_TO_RULES, OFFER_NAME, START_DATE, END_DATE, OFFER_TYPE, OFFER_DISCOUNT_TYPE, OFFER_VALUE, OFFER_DELIVERY_TYPE, STACKABLE, COMBINABLE_WITH_OTHER_OFFERS, OFFER_PRIORITY, APPLY_OFFER_TO_MARKED_ITEMS, APPLY_TO_SALE_PRICE, USES, MAX_USES) VALUES (1,NULL, 'Shirts Special',CURRENT_DATE,'2020-01-01 00:00:00','ORDER_ITEM','PERCENT_OFF',20,'AUTOMATIC',TRUE,TRUE,10,FALSE,FALSE,0,0);

INSERT INTO BLC_OFFER_ITEM_CRITERIA (OFFER_ITEM_CRITERIA_ID, ORDER_ITEM_MATCH_RULE, QUANTITY) VALUES (1, 'MVEL.eval("toUpperCase()",discreteOrderItem.category.name)==MVEL.eval("toUpperCase()","merchandise")', 1);

INSERT INTO BLC_TAR_CRIT_OFFER_XREF (OFFER_ITEM_CRITERIA_ID, OFFER_ID) VALUES (1, 1);

-- Sample fulfillment option
INSERT INTO BLC_FULFILLMENT_OPTION (FULFILLMENT_OPTION_ID, NAME, LONG_DESCRIPTION, USE_FLAT_RATES, FULFILLMENT_TYPE) VALUES (1, 'Standard', '5 - 7 Days', FALSE, 'PHYSICAL_SHIP');
INSERT INTO BLC_FULFILLMENT_OPTION (FULFILLMENT_OPTION_ID, NAME, LONG_DESCRIPTION, USE_FLAT_RATES, FULFILLMENT_TYPE) VALUES (2, 'Priority', '3 - 5 Days', FALSE, 'PHYSICAL_SHIP');
INSERT INTO BLC_FULFILLMENT_OPTION (FULFILLMENT_OPTION_ID, NAME, LONG_DESCRIPTION, USE_FLAT_RATES, FULFILLMENT_TYPE) VALUES (3, 'Express', '1 - 2 Days', FALSE, 'PHYSICAL_SHIP');
INSERT INTO BLC_FULFILLMENT_OPTION (FULFILLMENT_OPTION_ID, NAME, LONG_DESCRIPTION, USE_FLAT_RATES, FULFILLMENT_TYPE) VALUES (4, 'Free', 'Free', FALSE, 'PHYSICAL_SHIP');

INSERT INTO BLC_FULFILLMENT_OPTION_FIXED (FULFILLMENT_OPTION_ID, PRICE) VALUES (1, 5.00);
INSERT INTO BLC_FULFILLMENT_OPTION_FIXED (FULFILLMENT_OPTION_ID, PRICE) VALUES (2, 10.00);
INSERT INTO BLC_FULFILLMENT_OPTION_FIXED (FULFILLMENT_OPTION_ID, PRICE) VALUES (3, 20.00);
INSERT INTO BLC_FULFILLMENT_OPTION_FIXED (FULFILLMENT_OPTION_ID, PRICE) VALUES (4, 0.00);


