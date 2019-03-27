# -*- coding: utf-8 -*-
"""
Created on Fri Jul 13 10:22:39 2018

@author: mfrr
"""

import re
#import os

opcode = {
    'LUI': '0110111', # int('0110111',base=2).to_bytes(1, byteorder='little', signed=True),
    'AUIPC': '0010111', # int('0010111',base=2).to_bytes(1, byteorder='little', signed=True),
    'JAL': '1101111', # int('1101111',base=2).to_bytes(1, byteorder='little', signed=True),
    'JALR': '1100111', # int('1100111',base=2).to_bytes(1, byteorder='little', signed=True),
    'BEQ': '1100011', # int('1100011',base=2).to_bytes(1, byteorder='little', signed=True),
    'BNE': '1100011', # int('1100011',base=2).to_bytes(1, byteorder='little', signed=True),
    'BLT': '1100011', # int('1100011',base=2).to_bytes(1, byteorder='little', signed=True),
    'BGE': '1100011', # int('1100011',base=2).to_bytes(1, byteorder='little', signed=True),
    'BLTU': '1100011', # int('1100011',base=2).to_bytes(1, byteorder='little', signed=True),
    'BGEU': '1100011', # int('1100011',base=2).to_bytes(1, byteorder='little', signed=True),
    'LB': '0000011', # int('0000011',base=2).to_bytes(1, byteorder='little', signed=True),
    'LH': '0000011', # int('0000011',base=2).to_bytes(1, byteorder='little', signed=True),
    'LW': '0000011', # int('0000011',base=2).to_bytes(1, byteorder='little', signed=True),
    'LBU': '0000011', # int('0000011',base=2).to_bytes(1, byteorder='little', signed=True),
    'LHU': '0000011', # int('0000011',base=2).to_bytes(1, byteorder='little', signed=True),
    'SB': '0100011', # int('0100011',base=2).to_bytes(1, byteorder='little', signed=True),
    'SH': '0100011', # int('0100011',base=2).to_bytes(1, byteorder='little', signed=True),
    'SW': '0100011', # int('0100011',base=2).to_bytes(1, byteorder='little', signed=True),
    'ADDI': '0010011', # int('0010011',base=2).to_bytes(1, byteorder='little', signed=True),
    'SLTI': '0010011', # int('0010011',base=2).to_bytes(1, byteorder='little', signed=True),
    'SLTIU': '0010011', # int('0010011',base=2).to_bytes(1, byteorder='little', signed=True),
    'XORI': '0010011', # int('0010011',base=2).to_bytes(1, byteorder='little', signed=True),
    'ORI': '0010011', # int('0010011',base=2).to_bytes(1, byteorder='little', signed=True),
    'ANDI': '0010011', # int('0010011',base=2).to_bytes(1, byteorder='little', signed=True),
    'SLLI': '0010011', # int('0010011',base=2).to_bytes(1, byteorder='little', signed=True),
    'SRLI': '0010011', # int('0010011',base=2).to_bytes(1, byteorder='little', signed=True),
    'SRAI': '0010011', # int('0010011',base=2).to_bytes(1, byteorder='little', signed=True),
    'ADD': '0110011', # int('0110011',base=2).to_bytes(1, byteorder='little', signed=True),
    'SUB': '0110011', # int('0110011',base=2).to_bytes(1, byteorder='little', signed=True),
    'SLL': '0110011', # int('0110011',base=2).to_bytes(1, byteorder='little', signed=True),
    'SLT': '0110011', # int('0110011',base=2).to_bytes(1, byteorder='little', signed=True),
    'SLTU': '0110011', # int('0110011',base=2).to_bytes(1, byteorder='little', signed=True),
    'XOR': '0110011', # int('0110011',base=2).to_bytes(1, byteorder='little', signed=True),
    'SRL': '0110011', # int('0110011',base=2).to_bytes(1, byteorder='little', signed=True),
    'SRA': '0110011', # int('0110011',base=2).to_bytes(1, byteorder='little', signed=True),
    'OR': '0110011', # int('0110011',base=2).to_bytes(1, byteorder='little', signed=True),
    'AND': '0110011', # int('0110011',base=2).to_bytes(1, byteorder='little', signed=True),
} 

funct3 = {
    'JALR': '000', # int('000',base=2).to_bytes(1, byteorder='little', signed=True),
    'BEQ': '000', # int('000',base=2).to_bytes(1, byteorder='little', signed=True),
    'BNE': '001', # int('001',base=2).to_bytes(1, byteorder='little', signed=True),
    'BLT': '100', # int('100',base=2).to_bytes(1, byteorder='little', signed=True),
    'BGE': '101', # int('101',base=2).to_bytes(1, byteorder='little', signed=True),
    'BLTU': '110', # int('110',base=2).to_bytes(1, byteorder='little', signed=True),
    'BGEU': '111', # int('111',base=2).to_bytes(1, byteorder='little', signed=True),
    'LB': '000', # int('000',base=2).to_bytes(1, byteorder='little', signed=True),
    'LH': '001', # int('001',base=2).to_bytes(1, byteorder='little', signed=True),
    'LW': '010', # int('010',base=2).to_bytes(1, byteorder='little', signed=True),
    'LBU': '100', # int('100',base=2).to_bytes(1, byteorder='little', signed=True),
    'LHU': '101', # int('101',base=2).to_bytes(1, byteorder='little', signed=True),
    'SB': '000', # int('000',base=2).to_bytes(1, byteorder='little', signed=True),
    'SH': '001', # int('001',base=2).to_bytes(1, byteorder='little', signed=True),
    'SW': '010', # int('010',base=2).to_bytes(1, byteorder='little', signed=True),
    'ADDI': '000', # int('000',base=2).to_bytes(1, byteorder='little', signed=True),
    'SLTI': '010', # int('010',base=2).to_bytes(1, byteorder='little', signed=True),
    'SLTIU': '011', # int('011',base=2).to_bytes(1, byteorder='little', signed=True),
    'XORI': '100', # int('100',base=2).to_bytes(1, byteorder='little', signed=True),
    'ORI': '110', # int('110',base=2).to_bytes(1, byteorder='little', signed=True),
    'ANDI': '111', # int('111',base=2).to_bytes(1, byteorder='little', signed=True),
    'SLLI': '001', # int('001',base=2).to_bytes(1, byteorder='little', signed=True),
    'SRLI': '101', # int('101',base=2).to_bytes(1, byteorder='little', signed=True),
    'SRAI': '101', # int('101',base=2).to_bytes(1, byteorder='little', signed=True),
    'ADD': '000', # int('000',base=2).to_bytes(1, byteorder='little', signed=True),
    'SUB': '000', # int('000',base=2).to_bytes(1, byteorder='little', signed=True),
    'SLL': '001', # int('001',base=2).to_bytes(1, byteorder='little', signed=True),
    'SLT': '010', # int('010',base=2).to_bytes(1, byteorder='little', signed=True),
    'SLTU': '011', # int('011',base=2).to_bytes(1, byteorder='little', signed=True),
    'XOR': '100', # int('100',base=2).to_bytes(1, byteorder='little', signed=True),
    'SRL': '101', # int('101',base=2).to_bytes(1, byteorder='little', signed=True),
    'SRA': '101', # int('101',base=2).to_bytes(1, byteorder='little', signed=True),
    'OR': '110', # int('110',base=2).to_bytes(1, byteorder='little', signed=True),
    'AND': '111', # int('111',base=2).to_bytes(1, byteorder='little', signed=True),
}

funct7 = {
    'SLLI' :'0000000', # int('0000000',base=2).to_bytes(1, byteorder='little', signed=True),
    'SRLI' :'0000000', # int('0000000',base=2).to_bytes(1, byteorder='little', signed=True),
    'SRAI' :'0100000', # int('0100000',base=2).to_bytes(1, byteorder='little', signed=True),
    'ADD' :'0000000', # int('0000000',base=2).to_bytes(1, byteorder='little', signed=True),
    'SUB' :'0100000', # int('0100000',base=2).to_bytes(1, byteorder='little', signed=True),
    'SLL' :'0000000', # int('0000000',base=2).to_bytes(1, byteorder='little', signed=True),
    'SLT' :'0000000', # int('0000000',base=2).to_bytes(1, byteorder='little', signed=True),
    'SLTU' :'0000000', # int('0000000',base=2).to_bytes(1, byteorder='little', signed=True),
    'XOR' :'0000000', # int('0000000',base=2).to_bytes(1, byteorder='little', signed=True),
    'SRL' :'0000000', # int('0000000',base=2).to_bytes(1, byteorder='little', signed=True),
    'SRA' :'0100000', # int('0100000',base=2).to_bytes(1, byteorder='little', signed=True),
    'OR' :'0000000', # int('0000000',base=2).to_bytes(1, byteorder='little', signed=True),
    'AND' :'0000000', # int('0000000',base=2).to_bytes(1, byteorder='little', signed=True),
}

def getTokenALURR(instr,corpo):
    matching = getTokenALURR.regex.match(corpo)
    if matching:
        rd  = int(matching.group('RD')[1:])
        rs1 = int(matching.group('RS1')[1:])
        rs2 = int(matching.group('RS2')[1:])
        
        #print (instr,corpo)
        #print (instr,rd,rs1,rs2)

        return handlerRType(instr,rd,rs1,rs2)
    else:
        raise Exception('{} {} está mal formado'.format(instr,corpo))

getTokenALURR.regex = re.compile(r'(?P<RD>[xX][0-9]+)[ ]*,[ ]*(?P<RS1>[xX][0-9]+)[ ]*,[ ]*(?P<RS2>[xX][0-9]+)[ ]*$')

def getTokenALURI(instr,corpo):
    matching = getTokenALURI.regex.match(corpo)
    if matching:
        rd  = int(matching.group('RD')[1:])
        rs1 = int(matching.group('RS1')[1:])
        if matching.group('IMM')[0:2].upper() == '0X' or matching.group('IMM')[0:3].upper() == '-0X':
            imm = int(matching.group('IMM'),base = 16)
        else:
            imm = int(matching.group('IMM'))

        #print (instr,corpo)
        #print (instr,rd,rs1,'{:012b}'.format(imm))

        if instr in getTokenALURI.shifts:
            return handlerITypeShift(instr,rd,rs1,imm)
        else:
            return handlerIType(instr,rd,rs1,imm)
    else:
        raise Exception('{} {} está mal formado'.format(instr,corpo))

getTokenALURI.regex = re.compile(r'(?P<RD>[xX][0-9]+)[ ]*,[ ]*(?P<RS1>[xX][0-9]+)[ ]*,[ ]*(?P<IMM>[-]?0[xX][0-9abcdefABCDEF]+|[-]?[0-9]+)[ ]*$')
getTokenALURI.shifts = set(['SLLI','SRLI','SRAI',])

def getTokenStore(instr,corpo):
    matching = getTokenStore.regex.match(corpo)
    if matching:
        rs1 = int(matching.group('RS1')[1:])
        rs2 = int(matching.group('RS2')[1:])
        if matching.group('IMM')[0:2].upper() == '0X' or matching.group('IMM')[0:3].upper() == '-0X':
            imm = int(matching.group('IMM'),base = 16)
        else:
            imm = int(matching.group('IMM'))

        #print (instr,corpo)
        #print ('{} {},{:012b}({})'.format(instr,rs2,imm,rs1))

        return handlerSType(instr,rs1,rs2,imm)
    else:
        raise Exception('{} {} está mal formado'.format(instr,corpo))

getTokenStore.regex = re.compile(r'(?P<RS2>[xX][0-9]+)[ ]*,[ ]*(?P<IMM>[-]?0[xX][0-9abcdefABCDEF]+|[-]?[0-9]+)[ ]*\([ ]*(?P<RS1>[xX][0-9]+)[ ]*\)[ ]*$')

def getTokenLoad(instr,corpo):
    matching = getTokenLoad.regex.match(corpo)
    if matching:
        rs1 = int(matching.group('RS1')[1:])
        rd = int(matching.group('RD')[1:])
        if matching.group('IMM')[0:2].upper() == '0X' or matching.group('IMM')[0:3].upper() == '-0X':
            imm = int(matching.group('IMM'),base = 16)
        else:
            imm = int(matching.group('IMM'))

        #print (instr,corpo)
        #print ('{} {},{:012b}({})'.format(instr,rd,imm,rs1))

        return handlerIType(instr,rd,rs1,imm)
    else:
        raise Exception('{} {} está mal formado'.format(instr,corpo))

getTokenLoad.regex = re.compile(r'(?P<RD>[xX][0-9]+)[ ]*,[ ]*(?P<IMM>[-]?0[xX][0-9abcdefABCDEF]+|[-]?[0-9]+)[ ]*\([ ]*(?P<RS1>[xX][0-9]+)[ ]*\)[ ]*$')

def getTokenBranch(instr,corpo):
    matching = getTokenBranch.regex.match(corpo)
    if matching:
        rs1 = int(matching.group('RS1')[1:])
        rs2 = int(matching.group('RS2')[1:])
        if matching.group('IMM')[0:2].upper() == '0X' or matching.group('IMM')[0:3].upper() == '-0X':
            imm = int(matching.group('IMM'),base = 16)
        else:
            imm = int(matching.group('IMM'))

        if imm & 1 == 1: # impar
            raise Exception('getTokenBranch: imm não é multiplo de 2')
        
        #print (instr,corpo)
        #print (instr,rs1,rs2,'{:013b}'.format(imm))
        
        return handlerBType(instr,rs1,rs2,imm)
    else:
        raise Exception('{} {} está mal formado'.format(instr,corpo))

getTokenBranch.regex = re.compile(r'(?P<RS1>[xX][0-9]+)[ ]*,[ ]*(?P<RS2>[xX][0-9]+)[ ]*,[ ]*(?P<IMM>[-]?0[xX][0-9abcdefABCDEF]+|[-]?[0-9]+)[ ]*$')

# def getTokenJALR(instr,corpo):
#     matching = getTokenJALR.regex.match(corpo)
#     if matching:
#         rs1 = int(matching.group('RS1')[1:])
#         rd = int(matching.group('RD')[1:])
#         if matching.group('IMM')[0:2].upper() == '0X' or matching.group('IMM')[0:3].upper() == '-0X':
#             imm = int(matching.group('IMM'),base = 16)
#         else:
#             imm = int(matching.group('IMM'))

#         print (instr,corpo)
#         print ('{} {},{}({})'.format(instr,rd,imm,rs1))

#         return handlerIType(instr,rd,rs1,imm)

# getTokenJALR.regex = re.compile(r'(?P<RD>[xX][0-9]+)[ ]*,[ ]*(?P<IMM>[-]?0[xX][0-9abcdefABCDEF]+|[-]?[0-9]+)[ ]*\([ ]*(?P<RS1>[xX][0-9]+)[ ]*\)[ ]*$')

def getTokenJAL(instr,corpo):
    matching = getTokenJAL.regex.match(corpo)
    if matching:
        rd = int(matching.group('RD')[1:])
        if matching.group('IMM')[0:2].upper() == '0X' or matching.group('IMM')[0:3].upper() == '-0X':
            imm = int(matching.group('IMM'),base = 16)
        else:
            imm = int(matching.group('IMM'))

        if imm & 1 == 1: # impar
            raise Exception('getTokenJAL: imm não é multiplo de 2')

        #print (instr,corpo)
        #print ('{} {},{:021b}'.format(instr,rd,imm))

        return handlerJType(instr,rd,imm)
    else:
        raise Exception('{} {} está mal formado'.format(instr,corpo))

getTokenJAL.regex = re.compile(r'(?P<RD>[xX][0-9]+)[ ]*,[ ]*(?P<IMM>[-]?0[xX][0-9abcdefABCDEF]+|[-]?[0-9]+)[ ]*$')

# def getTokenAUIPC(instr,corpo):
#     matching = getTokenAUIPC.regex.match(corpo)
#     if matching:
#         rd = int(matching.group('RD')[1:])
#         if matching.group('IMM')[0:2].upper() == '0X' or matching.group('IMM')[0:3].upper() == '-0X':
#             imm = int(matching.group('IMM'),base = 16)
#         else:
#             imm = int(matching.group('IMM'))

#         print (instr,corpo)
#         print ('{} {},{}({})'.format(instr,rd,imm))

#         return handlerUType(instr,rd,imm)

# getTokenAUIPC.regex = re.compile(r'(?P<RD>[xX][0-9]+)[ ]*,[ ]*(?P<IMM>[-]?0[xX][0-9abcdefABCDEF]+|[-]?[0-9]+)[ ]*$')

def getTokenLUI(instr,corpo):
    matching = getTokenLUI.regex.match(corpo)
    if matching:
        rd = int(matching.group('RD')[1:])
        if matching.group('IMM')[0:2].upper() == '0X' or matching.group('IMM')[0:3].upper() == '-0X':
            imm = int(matching.group('IMM'),base = 16)
        else:
            imm = int(matching.group('IMM'))

        #print (instr,corpo)
        #print ('{} {},{:020b}'.format(instr,rd,imm))

        return handlerUType(instr,rd,imm)
    else:
        raise Exception('{} {} está mal formado'.format(instr,corpo))

getTokenLUI.regex = re.compile(r'(?P<RD>[xX][0-9]+)[ ]*,[ ]*(?P<IMM>[-]?0[xX][0-9abcdefABCDEF]+|[-]?[0-9]+)[ ]*$')

def handlerRType(instr,rd,rs1,rs2,formato = 'hex'):
    instrBinario = '{funct7}{rs2:05b}{rs1:05b}{funct3}{rd:05b}{opcode}'.format(
            opcode = opcode[instr],
            funct3 = funct3[instr],
            funct7 = funct7[instr],
            rd = rd,
            rs1 = rs1,
            rs2 = rs2,
    )
    
    if formato.lower() == 'hex':
        return '{:08x}'.format(int(instrBinario,base=2))
    else:
        return instrBinario

def handlerITypeShift(instr,rd,rs1,imm,formato = 'hex'):
    if imm < 0:
        raise Exception ('handlerIType: {} {imm} requer um imediato positivo'.format(instr,imm))
    
    imm = imm.to_bytes(2, byteorder='big', signed=True) # 16bits

    instrBinario = '{funct7}{shamt:}{rs1:05b}{funct3}{rd:05b}{opcode}'.format(
           opcode = opcode[instr],
           funct3 = funct3[instr],
           funct7 = funct7[instr],
           rd = rd,
           rs1 = rs1,
           shamt = ('{:08b}'.format(imm[0])+'{:08b}'.format(imm[1]))[11:],
    )

    if formato.lower() == 'hex':
       return '{:08x}'.format(int(instrBinario,base=2))
    else:
       return instrBinario

def handlerIType(instr,rd,rs1,imm,formato = 'hex'):

    imm = imm.to_bytes(2, byteorder='big', signed=True) # 16bits

    instrBinario = '{imm:}{rs1:05b}{funct3}{rd:05b}{opcode}'.format(
               opcode = opcode[instr],
               funct3 = funct3[instr],
               rd = rd,
               rs1 = rs1,
               imm = ('{:08b}'.format(imm[0])+'{:08b}'.format(imm[1]))[4:],
        )
    
    if formato.lower() == 'hex':
       return '{:08x}'.format(int(instrBinario,base=2))
    else:
       return instrBinario

def handlerSType(instr,rs1,rs2,imm,formato = 'hex'):
    imm = imm.to_bytes(2, byteorder='big', signed=True)
    imm = ('{:08b}'.format(imm[0])+'{:08b}'.format(imm[1]))[4:] # 12bits

    instrBinario = '{imm2:}{rs2:05b}{rs1:05b}{funct3}{imm1:}{opcode}'.format(
               opcode = opcode[instr],
               funct3 = funct3[instr],
               rs1 = rs1,
               rs2 = rs2,
               imm1 = imm[7:],
               imm2 = imm[0:7],
        )

    # idx  0  1  2  3  4  5  6  7  8  9  10  11  
    # --> 11 10  9  8  7  6  5  4  3  2   1   0

    if formato.lower() == 'hex':
       return '{:08x}'.format(int(instrBinario,base=2))
    else:
       return instrBinario
   
def handlerBType(instr,rs1,rs2,imm,formato = 'hex'):    
    imm = imm.to_bytes(2, byteorder='big', signed=True)
    imm = ('{:08b}'.format(imm[0])+'{:08b}'.format(imm[1]))[3:] # 13bits
    #                imm[12|10:5] rs2 rs1 000 imm[4:1|11] 1100011 BEQ
    instrBinario = '{imm2:}{rs2:05b}{rs1:05b}{funct3}{imm1:}{opcode}'.format(
               opcode = opcode[instr],
               funct3 = funct3[instr],
               rs1 = rs1,
               rs2 = rs2,
               imm1 = imm[8:12]+imm[1],
               imm2 = imm[0]+imm[2:8],
        )

    # idx  0  1  2  3  4  5  6  7  8  9  10  11  12
    # --> 12 11 10  9  8  7  6  5  4  3   2   1   0

    if formato.lower() == 'hex':
       return '{:08x}'.format(int(instrBinario,base=2))
    else:
       return instrBinario

def handlerUType(instr,rd,imm,formato = 'hex'):
    imm = imm.to_bytes(3, byteorder='big', signed=True)
    imm = ('{:08b}'.format(imm[0])+'{:08b}'.format(imm[1])+'{:08b}'.format(imm[2]))# 24bits

    instrBinario = '{imm:}{rd:05b}{opcode}'.format(
               opcode = opcode[instr],
               rd = rd,
               imm = imm[4:],
        )

    # idx  0  1  2  3  4  5  ...
    # --> 23 22 21 20 19 18  ... 

    if formato.lower() == 'hex':
       return '{:08x}'.format(int(instrBinario,base=2))
    else:
       return instrBinario

def handlerJType(instr,rd,imm,formato = 'hex'):
    imm = imm.to_bytes(3, byteorder='big', signed=True)
    imm = ('{:08b}'.format(imm[0])+'{:08b}'.format(imm[1])+'{:08b}'.format(imm[2]))# 24bits

    instrBinario = '{imm:}{rd:05b}{opcode}'.format(
               opcode = opcode[instr],
               rd = rd,
               #     imm[20|    10:01     |11|    19:12]              
               imm = imm[3]+imm[13:23]+imm[12]+imm[4:12],
        )

    # idx  0   1   2   3   4   5   6   7   8   9  10   11   12   13   14   15   16   17   18   19   20   21   22   23
    # --> 23  22  21  20  19  18  17  16  15  14  13   12   11   10    9    8    7    6    5    4    3    2    1    0

    if formato.lower() == 'hex':
       return '{:08x}'.format(int(instrBinario,base=2))
    else:
       return instrBinario

getTokens = {
    'LUI': getTokenLUI,
    'AUIPC': getTokenLUI,
    'JAL': getTokenJAL,
    'JALR': getTokenLoad,
    'BEQ': getTokenBranch,
    'BNE': getTokenBranch,
    'BLT': getTokenBranch,
    'BGE': getTokenBranch,
    'BLTU': getTokenBranch,
    'BGEU': getTokenBranch,
    'LB': getTokenLoad,
    'LH': getTokenLoad,
    'LW': getTokenLoad,
    'LBU': getTokenLoad,
    'LHU': getTokenLoad,
    'SB': getTokenStore,
    'SH': getTokenStore,
    'SW': getTokenStore,
    'ADDI': getTokenALURI,
    'SLTI': getTokenALURI,
    'SLTIU': getTokenALURI,
    'XORI': getTokenALURI,
    'ORI': getTokenALURI,
    'ANDI': getTokenALURI,
    'SLLI': getTokenALURI,
    'SRLI': getTokenALURI,
    'SRAI': getTokenALURI,
    'ADD': getTokenALURR,
    'SUB': getTokenALURR,
    'SLL': getTokenALURR,
    'SLT': getTokenALURR,
    'SLTU': getTokenALURR,
    'XOR': getTokenALURR,
    'SRL': getTokenALURR,
    'SRA': getTokenALURR,
    'OR': getTokenALURR,
    'AND': getTokenALURR,
}

def parserArquivo(caminho):
    dados = None
    with open(caminho,'r') as f:
        dados = f.read()

    regex_data = {
        'ESPACO': r'[ ]+',
        'FIM': r'[\n\r]+',
        'INSTR': r'(?P<INSTR>[a-zA-Z0-9]+)',
        'CORPO': r'(?P<CORPO>[-+a-zA-Z0-9_\.\,\(\)]+)',
        'COMENTARIO': r'(?P<COMENTARIO>[ ]*;[-+a-zA-Z0-9_\.\,\(\) ]*|[ ]*)',
        #(?P<IMM>[-]?0[xX][0-9abcdefABCDEF]+|[-]?[0-9]+)
    }
    
    regex = re.compile(regex_data['INSTR']+regex_data['ESPACO']+regex_data['CORPO']+regex_data['COMENTARIO']+regex_data['FIM'])

    for i,matching in enumerate(regex.finditer(dados),start=0):
        if matching:
            instr = matching.group('INSTR').upper()
            corpo = matching.group('CORPO')
            comentario = matching.group('COMENTARIO')
            #print('{:03}: Instr {} Corpo {}'.format(i,instr,corpo))
            #print (i,end=': ')
            
            handler = getTokens.get(instr,None)
            
            if handler is not None:
                print ('instrs[{i}] = 32\'h{hex}; instrs_strings[{i}] = "{instr} {corpo}{comentario}";'.format(
                        i =i,
                        instr = instr,
                        corpo = corpo,
                        comentario = comentario,
                        hex = handler(instr,corpo)
                    )
                )
            else:
                raise Exception('{} não possui handler'.format(instr))
            
def main():
    parserArquivo('instr2.txt')

if __name__ == "__main__":
        main()