import requests
import csv
import operator
import re

with open('Data_parser/forex_prices_EURUSD_m1.csv', mode='r') as csv_file:
    csv_reader = csv.DictReader(csv_file)
    line_count = 0
    ciclos = []
    catalogados = []
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
    def sequence_in(seq, target):
        i= 0
        while i in range(len(target) - len(seq) + 1):
            print(i)
            if seq == target[i:i+len(seq)]:
                catalogados.append("azul")
                print(seq)
                i+=2
                continue
            i+=1
        return seq
    
    #TODO check triplicaçao e nao triplicaçao
    def get_triplicacao():
         
        pass
    print(sequence_in(pattern2 , ciclos))
    print(catalogados)
    if (pattern1 in ciclos) : 
        print(f"ciclo existe{pattern1}")
    print(f'Processed {line_count} lines.')