#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00" 


struct MqlBookInfo
  {
   ENUM_BOOK_TYPE   type;       // tipo de ordem a partir da enumeração ENUM_BOOK_TYPE
   double           price;      // ordem de preço
   long             volume;     // ordem de volume
  };

//+------------------------------------------------------------------+
//| Especifica modificadores para propriedades do tipo integer       |
//| do DOM.                                                          |
//+------------------------------------------------------------------+
enum ENUM_MBOOK_INFO_INTEGER
{
   MBOOK_BEST_ASK_INDEX,         // Índice do melhor preço Ask
   MBOOK_BEST_BID_INDEX,         // Índice do melhor preço Bid
   MBOOK_LAST_ASK_INDEX,         // Índice do pior preço Ask
   MBOOK_LAST_BID_INDEX,         // Índice do pior preço Bid
   MBOOK_DEPTH_ASK,              // Número dos niveis de vendas
   MBOOK_DEPTH_BID,              // Número dos niveis de compra
   MBOOK_DEPTH_TOTAL             // Número total dos níveis de DOM
};
//+------------------------------------------------------------------+
//| Especifica modificadores de propriedades do tipo de double       |
//| de DOM.                                                          |
//+------------------------------------------------------------------+
enum ENUM_MBOOK_INFO_DOUBLE
{
   MBOOK_BEST_ASK_PRICE,         // Melhor preço Ask
   MBOOK_BEST_BID_PRICE,         // Melhor preço Bid
   MBOOK_LAST_ASK_PRICE,         // Pior preço Ask
   MBOOK_LAST_BID_PRICE,         // Pior preço Bid
   MBOOK_AVERAGE_SPREAD          // Spread médio entre Ask e Bid
};

int onInit() {
    MarketBookAdd("WDOH20");
    return(INIT_SUCCEEDED);
}

void onDeinit(cont int reason){
    MarketBookRelease("WDOH20")
}
duplo  best_ask = BookOnSi.InfoGetDouble (MBOOK_BEST_ASK_PRICE);
CMarketBook BookOnSi("WDOH20")
void onBookEvent(const string &symbol){
    MqlBookInfo info = BookOnSi.MarketBook[0]
}

//DOM ITERATOR
void CMarketBook::SetBestAskAndBidIndex(void)
{
   if(!FindBestBid())
   {
      //Encontrar o melhor Ask através de uma pesquisa completa
      int bookSize = ArraySize(MarketBook);   
      for(int i = 0; i < bookSize; i++)
      {
         if((MarketBook[i].type == BOOK_TYPE_BUY) || (MarketBook[i].type == BOOK_TYPE_BUY_MARKET))
         {
            m_best_ask_index = i-1;
            FindBestBid();
            break;
         }
      }
   }
}
//Find best bid/ask
bool CMarketBook::FindBestBid(void)
{
   m_best_bid_index = -1;
   bool isBestAsk = m_best_ask_index >= 0 && m_best_ask_index < m_depth_total &&
                    (MarketBook[m_best_ask_index].type == BOOK_TYPE_SELL ||
                    MarketBook[m_best_ask_index].type == BOOK_TYPE_SELL_MARKET);
   if(!isBestAsk)return false;
   int bestBid = m_best_ask_index+1;
   bool isBestBid = bestBid >= 0 && bestBid < m_depth_total &&
                    (MarketBook[bestBid].type == BOOK_TYPE_BUY ||
                    MarketBook[bestBid].type == BOOK_TYPE_BUY_MARKET);
   if(isBestBid)
   {
      m_best_bid_index = bestBid;
      return true;
   }
   return false;
}