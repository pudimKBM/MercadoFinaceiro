#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00" 


struct MqlBookInfo
  {
   ENUM_BOOK_TYPE   type;       // tipo de ordem a partir da enumeração ENUM_BOOK_TYPE
   double           price;      // ordem de preço
   long             volume;     // ordem de volume
  };



int onInit() {
    MarketBookAdd("WDOH20");
    return(INIT_SUCCEEDED);
}

void onDeinit(cont int reason){
    MarketBookRelease("WDOH20")
}
void onBookEvent(const string &symbol){

    // printf("Depth of the Market" + symbol +"was changed")
    MqlBookInfo book[];
    marketBookGet(symbol, book);
    if(ArraySize(book)  == 0){
        printf("Failed load market book price. Reason: " + (string)GetLastError());
        return;
    }
    string line = "Price: " + DoubleToString(book[0].price, Digits()+ "; ");
    line += "vloume" + (string)book[0].vloume +"; ";
    line += "Type: "+ EnumToString(book[0].Type);
    printf(line)

}
