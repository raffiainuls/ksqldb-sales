for this table there is 3 steps 
1.  create tbl_promotions_raw, where 
    this step will take payload data from the message in the topic. 
    so as an ilustration will be formed a stream whose column only has payload
2.  create tbl_promotions_clean, in this steps will be formed a stream, the data in 
    the payload in tbl_branch_raw will be taken, and it will be split into columns 
    and the results of this stream will also be stored in the kafka topic 'tbl_promotions_clean'
4   create tbl_promotions_convert, because in kafka the value column related to the timestamp changes to nano seconds, 
    it is necessary to make changes to this table because this will be used for join table, 
    so in this step we will make changes to the time column 
3.  create tbl_promotions_table, in this step we make table from topic tbl_promotions_convert, 
    because for the purposes of the join query we need to create a table