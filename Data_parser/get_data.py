import requests
import csv
import operator
import re

with open('Data_parser/forex_prices_EURUSD_m1.csv', mode='r') as csv_file:
    csv_reader = csv.DictReader(csv_file)
    line_count = 0
    ciclos = []
   
    for row in csv_reader:
        if line_count == 0:
           # print(f'Column names are {", ".join(row)}')
            line_count += 1
        open = (float(row["OPEN_BID"]) + float(row["OPEN_ASK"]))/2
        close = (float(row["CLOSE_BID"]) + float(row["CLOSE_ASK"]))/2
        if open>close : 
            color = 1
            ciclos.append(color)
        elif open<close: 
            color = 2
            ciclos.append(color)
        #print(f" close = {close} , open =  {open} , color = {color} , occured_at = {row['OCCURRED_AT']}")
        #print(f" color = {color} , occured_at = {row['OCCURRED_AT']}")
        line_count += 1
    
    print(ciclos)
    pattern1 = [2,2,2]
    pattern2 = [2,1,1]
    def catalogador(seq):
        catalogacao = []
        i= 0
        while i in range(len(seq)):
            print(i)
            if seq[i] == seq[i+1]:
                if seq[i] == seq[i+2] : 
                    catalogacao.append("azul")
                    print([seq[i], seq[i+1], seq[i+2]])
                    i+=2
                    pass
                elif seq[i] != seq[i+2] : 
                    catalogacao.append("rosa")
                    print([seq[i], seq[i+1], seq[i+2]])
                    i+=2 
                    pass
            i+=1
        return catalogacao
    
    #TODO check triplicaçao e nao triplicaçao
    def get_triplicacao():
         
        pass
    catalog_lv1 = ["azul", "azul", "rosa", "rosa","rosa", "rosa"]
    print(catalogador(catalog_lv1))
    if (pattern1 in ciclos) : 
        print(f"ciclo existe{pattern1}")
    print(f'Processed {line_count} lines.')