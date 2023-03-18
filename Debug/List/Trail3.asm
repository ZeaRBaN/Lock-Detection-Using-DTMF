
;CodeVisionAVR C Compiler V3.14 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega32A
;Program type           : Application
;Clock frequency        : 11.059200 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 512 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega32A
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2048
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x085F
	.EQU __DSTACK_SIZE=0x0200
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _keydetect=R4
	.DEF _keydetect_msb=R5
	.DEF _input=R7
	.DEF _count=R6
	.DEF _i=R9
	.DEF _flag=R10
	.DEF _flag_msb=R11
	.DEF _Falling=R8
	.DEF _mode=R12
	.DEF _mode_msb=R13

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  _ext_int0_isr
	JMP  _ext_int1_isr
	JMP  _ext_int2_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G102:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G102:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0

_0x0:
	.DB  0x31,0x0,0x32,0x0,0x33,0x0,0x34,0x0
	.DB  0x35,0x0,0x36,0x0,0x37,0x0,0x38,0x0
	.DB  0x39,0x0,0x30,0x0,0x2A,0x0,0x23,0x0
	.DB  0x45,0x6E,0x74,0x65,0x72,0x20,0x50,0x61
	.DB  0x73,0x73,0x77,0x6F,0x72,0x64,0x3A,0x0
	.DB  0x55,0x6E,0x6C,0x6F,0x63,0x6B,0x65,0x64
	.DB  0x0,0x57,0x72,0x6F,0x6E,0x67,0x0,0x4E
	.DB  0x65,0x77,0x20,0x50,0x61,0x73,0x73,0x77
	.DB  0x6F,0x72,0x64,0x3A,0x0,0x50,0x61,0x73
	.DB  0x73,0x77,0x6F,0x72,0x64,0x20,0x53,0x61
	.DB  0x76,0x65,0x64,0x0
_0x2060003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x0A
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x02
	.DW  _0x7
	.DW  _0x0*2

	.DW  0x02
	.DW  _0x7+2
	.DW  _0x0*2+2

	.DW  0x02
	.DW  _0x7+4
	.DW  _0x0*2+4

	.DW  0x02
	.DW  _0x7+6
	.DW  _0x0*2+6

	.DW  0x02
	.DW  _0x7+8
	.DW  _0x0*2+8

	.DW  0x02
	.DW  _0x7+10
	.DW  _0x0*2+10

	.DW  0x02
	.DW  _0x7+12
	.DW  _0x0*2+12

	.DW  0x02
	.DW  _0x7+14
	.DW  _0x0*2+14

	.DW  0x02
	.DW  _0x7+16
	.DW  _0x0*2+16

	.DW  0x02
	.DW  _0x7+18
	.DW  _0x0*2+18

	.DW  0x02
	.DW  _0x7+20
	.DW  _0x0*2+20

	.DW  0x02
	.DW  _0x7+22
	.DW  _0x0*2+22

	.DW  0x10
	.DW  _0x1D
	.DW  _0x0*2+24

	.DW  0x02
	.DW  _0x1D+16
	.DW  _0x0*2

	.DW  0x02
	.DW  _0x1D+18
	.DW  _0x0*2+2

	.DW  0x02
	.DW  _0x1D+20
	.DW  _0x0*2+4

	.DW  0x02
	.DW  _0x1D+22
	.DW  _0x0*2+6

	.DW  0x02
	.DW  _0x1D+24
	.DW  _0x0*2+8

	.DW  0x02
	.DW  _0x1D+26
	.DW  _0x0*2+10

	.DW  0x02
	.DW  _0x1D+28
	.DW  _0x0*2+12

	.DW  0x02
	.DW  _0x1D+30
	.DW  _0x0*2+14

	.DW  0x02
	.DW  _0x1D+32
	.DW  _0x0*2+16

	.DW  0x02
	.DW  _0x1D+34
	.DW  _0x0*2+18

	.DW  0x09
	.DW  _0x1D+36
	.DW  _0x0*2+40

	.DW  0x06
	.DW  _0x1D+45
	.DW  _0x0*2+49

	.DW  0x0E
	.DW  _0x1D+51
	.DW  _0x0*2+55

	.DW  0x0F
	.DW  _0x1D+65
	.DW  _0x0*2+69

	.DW  0x02
	.DW  __base_y_G103
	.DW  _0x2060003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x260

	.CSEG
;/*******************************************************
;This program was created by the
;CodeWizardAVR V3.14 Advanced
;Automatic Program Generator
;© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 5/23/2022
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATmega32A
;Program type            : Application
;AVR Core Clock frequency: 11.059200 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 512
;*******************************************************/
;
;#include <mega32a.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;#include <string.h>
;#include <eeprom.h>
;#include <stdio.h>
;#include <stdint.h>
;#include <alcd.h>  // Alphanumeric LCD functions
;
;// Declare your global variables here
;#define New PORTA.0
;#define Correct PORTA.1
;#define Wrong PORTA.2
;#define led4 PORTA.3
;#define input1 PINA.4
;#define input2 PINA.5
;#define input3 PINA.6
;#define input4 PINA.7
;
;
;int keydetect = 0;
;char input;
;eeprom char password[16];
;eeprom char length;
;char count = 0;
;char i = 0;
;int flag = 0;
;char Falling = 0 ;
;int mode =0;
;int save_mode=0;
;int flagoo=0;
;
;void setKey()
; 0000 0038 {

	.CSEG
_setKey:
; .FSTART _setKey
; 0000 0039     switch (PINA & 0xF0)
	IN   R30,0x19
	ANDI R30,LOW(0xF0)
; 0000 003A     {
; 0000 003B     case (0x10):
	CPI  R30,LOW(0x10)
	BRNE _0x6
; 0000 003C         lcd_puts("1");
	__POINTW2MN _0x7,0
	CALL SUBOPT_0x0
; 0000 003D         password[count] = '1';
	LDI  R30,LOW(49)
	CALL __EEPROMWRB
; 0000 003E         break;
	RJMP _0x5
; 0000 003F 
; 0000 0040     case (0x20):
_0x6:
	CPI  R30,LOW(0x20)
	BRNE _0x8
; 0000 0041         lcd_puts("2");
	__POINTW2MN _0x7,2
	CALL SUBOPT_0x0
; 0000 0042         password[count] = '2';
	LDI  R30,LOW(50)
	CALL __EEPROMWRB
; 0000 0043         break;
	RJMP _0x5
; 0000 0044 
; 0000 0045     case (0x30):
_0x8:
	CPI  R30,LOW(0x30)
	BRNE _0x9
; 0000 0046         lcd_puts("3");
	__POINTW2MN _0x7,4
	CALL SUBOPT_0x0
; 0000 0047         password[count] = '3';
	LDI  R30,LOW(51)
	CALL __EEPROMWRB
; 0000 0048         break;
	RJMP _0x5
; 0000 0049 
; 0000 004A     case (0x40):
_0x9:
	CPI  R30,LOW(0x40)
	BRNE _0xA
; 0000 004B         lcd_puts("4");
	__POINTW2MN _0x7,6
	CALL SUBOPT_0x0
; 0000 004C         password[count] = '4';
	LDI  R30,LOW(52)
	CALL __EEPROMWRB
; 0000 004D         break;
	RJMP _0x5
; 0000 004E 
; 0000 004F     case (0x50):
_0xA:
	CPI  R30,LOW(0x50)
	BRNE _0xB
; 0000 0050         lcd_puts("5");
	__POINTW2MN _0x7,8
	CALL SUBOPT_0x0
; 0000 0051         password[count] = '5';
	LDI  R30,LOW(53)
	CALL __EEPROMWRB
; 0000 0052         break;
	RJMP _0x5
; 0000 0053 
; 0000 0054     case (0x60):
_0xB:
	CPI  R30,LOW(0x60)
	BRNE _0xC
; 0000 0055         lcd_puts("6");
	__POINTW2MN _0x7,10
	CALL SUBOPT_0x0
; 0000 0056         password[count] = '6';
	LDI  R30,LOW(54)
	CALL __EEPROMWRB
; 0000 0057         break;
	RJMP _0x5
; 0000 0058 
; 0000 0059     case (0x70):
_0xC:
	CPI  R30,LOW(0x70)
	BRNE _0xD
; 0000 005A         lcd_puts("7");
	__POINTW2MN _0x7,12
	CALL SUBOPT_0x0
; 0000 005B         password[count] = '7';
	LDI  R30,LOW(55)
	CALL __EEPROMWRB
; 0000 005C         break;
	RJMP _0x5
; 0000 005D 
; 0000 005E     case (0x80):
_0xD:
	CPI  R30,LOW(0x80)
	BRNE _0xE
; 0000 005F         lcd_puts("8");
	__POINTW2MN _0x7,14
	CALL SUBOPT_0x0
; 0000 0060         password[count] = '8';
	LDI  R30,LOW(56)
	CALL __EEPROMWRB
; 0000 0061         break;
	RJMP _0x5
; 0000 0062 
; 0000 0063     case (0x90):
_0xE:
	CPI  R30,LOW(0x90)
	BRNE _0xF
; 0000 0064         lcd_puts("9");
	__POINTW2MN _0x7,16
	CALL SUBOPT_0x0
; 0000 0065         password[count] = '9';
	LDI  R30,LOW(57)
	CALL __EEPROMWRB
; 0000 0066         break;
	RJMP _0x5
; 0000 0067 
; 0000 0068     case (0xA0):
_0xF:
	CPI  R30,LOW(0xA0)
	BRNE _0x10
; 0000 0069         lcd_puts("0");
	__POINTW2MN _0x7,18
	CALL SUBOPT_0x0
; 0000 006A         password[count] = '0';
	LDI  R30,LOW(48)
	CALL __EEPROMWRB
; 0000 006B         break;
	RJMP _0x5
; 0000 006C 
; 0000 006D     case (0xB0):
_0x10:
	CPI  R30,LOW(0xB0)
	BRNE _0x11
; 0000 006E         lcd_puts("*");
	__POINTW2MN _0x7,20
	CALL SUBOPT_0x0
; 0000 006F         password[count] = '*';
	LDI  R30,LOW(42)
	CALL __EEPROMWRB
; 0000 0070         flag = 2;
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	MOVW R10,R30
; 0000 0071         break;
	RJMP _0x5
; 0000 0072 
; 0000 0073     case (0xC0):
_0x11:
	CPI  R30,LOW(0xC0)
	BRNE _0x13
; 0000 0074         lcd_puts("#");
	__POINTW2MN _0x7,22
	CALL SUBOPT_0x0
; 0000 0075         password[count] = '#';
	LDI  R30,LOW(35)
	CALL __EEPROMWRB
; 0000 0076         break;
; 0000 0077 
; 0000 0078     default:
_0x13:
; 0000 0079         break;
; 0000 007A     }
_0x5:
; 0000 007B 
; 0000 007C }
	RET
; .FEND

	.DSEG
_0x7:
	.BYTE 0x18
;
;
;
;// External Interrupt 0 service routine
;interrupt [EXT_INT0] void ext_int0_isr(void)
; 0000 0082 {

	.CSEG
_ext_int0_isr:
; .FSTART _ext_int0_isr
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 0083 // Place your code here
; 0000 0084     keydetect = 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R4,R30
; 0000 0085     delay_ms(50);
	LDI  R26,LOW(50)
	LDI  R27,0
	CALL _delay_ms
; 0000 0086 
; 0000 0087 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
;
;// External Interrupt 1 service routine
;interrupt [EXT_INT1] void ext_int1_isr(void)
; 0000 008B {
_ext_int1_isr:
; .FSTART _ext_int1_isr
	ST   -Y,R30
	ST   -Y,R31
; 0000 008C     save_mode=1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _save_mode,R30
	STS  _save_mode+1,R31
; 0000 008D     New=1;
	SBI  0x1B,0
; 0000 008E }
	RJMP _0x48
; .FEND
;// External Interrupt 2 service routine
;interrupt [EXT_INT2] void ext_int2_isr(void)
; 0000 0091 {
_ext_int2_isr:
; .FSTART _ext_int2_isr
	ST   -Y,R30
	ST   -Y,R31
; 0000 0092     save_mode=0;
	LDI  R30,LOW(0)
	STS  _save_mode,R30
	STS  _save_mode+1,R30
; 0000 0093     New=0;
	CBI  0x1B,0
; 0000 0094     flagoo=1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _flagoo,R30
	STS  _flagoo+1,R31
; 0000 0095     flag=1;
	MOVW R10,R30
; 0000 0096 
; 0000 0097 }
_0x48:
	LD   R31,Y+
	LD   R30,Y+
	RETI
; .FEND
;
;void main(void)
; 0000 009A {
_main:
; .FSTART _main
; 0000 009B // Declare your local variables here
; 0000 009C 
; 0000 009D // Input/Output Ports initialization
; 0000 009E // Port A initialization
; 0000 009F // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 00A0     DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (1<<DDA3) | (1<<DDA2) | (1<<DDA1) | (1<<DDA0);
	LDI  R30,LOW(15)
	OUT  0x1A,R30
; 0000 00A1 // State: Bit7=P Bit6=P Bit5=P Bit4=P Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 00A2     PORTA=(1<<PORTA7) | (1<<PORTA6) | (1<<PORTA5) | (1<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	LDI  R30,LOW(240)
	OUT  0x1B,R30
; 0000 00A3 
; 0000 00A4 // Port B initialization
; 0000 00A5 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 00A6     DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	LDI  R30,LOW(0)
	OUT  0x17,R30
; 0000 00A7 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 00A8     PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	OUT  0x18,R30
; 0000 00A9 
; 0000 00AA // Port C initialization
; 0000 00AB // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 00AC     DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
	OUT  0x14,R30
; 0000 00AD // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 00AE     PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	OUT  0x15,R30
; 0000 00AF 
; 0000 00B0 // Port D initialization
; 0000 00B1 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 00B2     DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0x11,R30
; 0000 00B3 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 00B4     PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	OUT  0x12,R30
; 0000 00B5 
; 0000 00B6 // External Interrupt(s) initialization
; 0000 00B7 // INT0: On
; 0000 00B8 // INT0 Mode: Rising Edge
; 0000 00B9 // INT1: On
; 0000 00BA // INT1 Mode: Rising Edge
; 0000 00BB // INT2: On
; 0000 00BC // INT2 Mode: Falling Edge
; 0000 00BD     GICR|=(1<<INT1) | (1<<INT0) | (1<<INT2);
	IN   R30,0x3B
	ORI  R30,LOW(0xE0)
	OUT  0x3B,R30
; 0000 00BE     MCUCR=(1<<ISC11) | (1<<ISC10) | (1<<ISC01) | (1<<ISC00);
	LDI  R30,LOW(15)
	OUT  0x35,R30
; 0000 00BF     MCUCSR=(0<<ISC2);
	LDI  R30,LOW(0)
	OUT  0x34,R30
; 0000 00C0     GIFR=(1<<INTF1) | (1<<INTF0) | (1<<INTF2);
	LDI  R30,LOW(224)
	OUT  0x3A,R30
; 0000 00C1 
; 0000 00C2 // Alphanumeric LCD initialization
; 0000 00C3 // Connections are specified in the
; 0000 00C4 // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
; 0000 00C5 // RS - PORTC Bit 0
; 0000 00C6 // RD - PORTC Bit 1
; 0000 00C7 // EN - PORTC Bit 2
; 0000 00C8 // D4 - PORTC Bit 4
; 0000 00C9 // D5 - PORTC Bit 5
; 0000 00CA // D6 - PORTC Bit 6
; 0000 00CB // D7 - PORTC Bit 7
; 0000 00CC // Characters/line: 16
; 0000 00CD     lcd_init(16);
	LDI  R26,LOW(16)
	CALL _lcd_init
; 0000 00CE 
; 0000 00CF // Global enable interrupts
; 0000 00D0 #asm("sei")
	sei
; 0000 00D1 
; 0000 00D2     while (1)
_0x18:
; 0000 00D3       {if (save_mode==0)
	LDS  R30,_save_mode
	LDS  R31,_save_mode+1
	SBIW R30,0
	BREQ PC+2
	RJMP _0x1B
; 0000 00D4       {
; 0000 00D5         if(i==0){
	TST  R9
	BRNE _0x1C
; 0000 00D6         lcd_clear();
	CALL _lcd_clear
; 0000 00D7         lcd_gotoxy(0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _lcd_gotoxy
; 0000 00D8         lcd_puts("Enter Password:");
	__POINTW2MN _0x1D,0
	CALL SUBOPT_0x1
; 0000 00D9         lcd_gotoxy(0,1);
; 0000 00DA         delay_ms(200);
	LDI  R26,LOW(200)
	LDI  R27,0
	CALL _delay_ms
; 0000 00DB         }
; 0000 00DC         if (keydetect==1)
_0x1C:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R4
	CPC  R31,R5
	BREQ PC+2
	RJMP _0x1E
; 0000 00DD         {
; 0000 00DE          keydetect = 0;
	CLR  R4
	CLR  R5
; 0000 00DF          switch (PINA & 0xF0)
	IN   R30,0x19
	ANDI R30,LOW(0xF0)
; 0000 00E0                 {
; 0000 00E1                     case (0x10):
	CPI  R30,LOW(0x10)
	BRNE _0x22
; 0000 00E2                     lcd_puts("1");
	__POINTW2MN _0x1D,16
	CALL _lcd_puts
; 0000 00E3                     input= '1';
	LDI  R30,LOW(49)
	MOV  R7,R30
; 0000 00E4                     break;
	RJMP _0x21
; 0000 00E5 
; 0000 00E6                     case (0x20):
_0x22:
	CPI  R30,LOW(0x20)
	BRNE _0x23
; 0000 00E7                     lcd_puts("2");
	__POINTW2MN _0x1D,18
	CALL _lcd_puts
; 0000 00E8                     input= '2';
	LDI  R30,LOW(50)
	MOV  R7,R30
; 0000 00E9                     break;
	RJMP _0x21
; 0000 00EA 
; 0000 00EB                     case (0x30):
_0x23:
	CPI  R30,LOW(0x30)
	BRNE _0x24
; 0000 00EC                     lcd_puts("3");
	__POINTW2MN _0x1D,20
	CALL _lcd_puts
; 0000 00ED                     input= '3';
	LDI  R30,LOW(51)
	MOV  R7,R30
; 0000 00EE                     break;
	RJMP _0x21
; 0000 00EF 
; 0000 00F0                     case (0x40):
_0x24:
	CPI  R30,LOW(0x40)
	BRNE _0x25
; 0000 00F1                     lcd_puts("4");
	__POINTW2MN _0x1D,22
	CALL _lcd_puts
; 0000 00F2                     input= '4';
	LDI  R30,LOW(52)
	MOV  R7,R30
; 0000 00F3                     break;
	RJMP _0x21
; 0000 00F4 
; 0000 00F5                     case (0x50):
_0x25:
	CPI  R30,LOW(0x50)
	BRNE _0x26
; 0000 00F6                     lcd_puts("5");
	__POINTW2MN _0x1D,24
	CALL _lcd_puts
; 0000 00F7                     input= '5';
	LDI  R30,LOW(53)
	MOV  R7,R30
; 0000 00F8                     break;
	RJMP _0x21
; 0000 00F9 
; 0000 00FA                     case (0x60):
_0x26:
	CPI  R30,LOW(0x60)
	BRNE _0x27
; 0000 00FB                     lcd_puts("6");
	__POINTW2MN _0x1D,26
	CALL _lcd_puts
; 0000 00FC                     input= '6';
	LDI  R30,LOW(54)
	MOV  R7,R30
; 0000 00FD                     break;
	RJMP _0x21
; 0000 00FE 
; 0000 00FF                     case (0x70):
_0x27:
	CPI  R30,LOW(0x70)
	BRNE _0x28
; 0000 0100                     lcd_puts("7");
	__POINTW2MN _0x1D,28
	CALL _lcd_puts
; 0000 0101                     input= '7';
	LDI  R30,LOW(55)
	MOV  R7,R30
; 0000 0102                     break;
	RJMP _0x21
; 0000 0103 
; 0000 0104                     case (0x80):
_0x28:
	CPI  R30,LOW(0x80)
	BRNE _0x29
; 0000 0105                     lcd_puts("8");
	__POINTW2MN _0x1D,30
	CALL _lcd_puts
; 0000 0106                     input= '8';
	LDI  R30,LOW(56)
	MOV  R7,R30
; 0000 0107                     break;
	RJMP _0x21
; 0000 0108 
; 0000 0109                     case (0x90):
_0x29:
	CPI  R30,LOW(0x90)
	BRNE _0x2A
; 0000 010A                     lcd_puts("9");
	__POINTW2MN _0x1D,32
	CALL _lcd_puts
; 0000 010B                     input= '9';
	LDI  R30,LOW(57)
	MOV  R7,R30
; 0000 010C                     break;
	RJMP _0x21
; 0000 010D 
; 0000 010E                     case (0xA0):
_0x2A:
	CPI  R30,LOW(0xA0)
	BRNE _0x2B
; 0000 010F                     lcd_puts("0");
	__POINTW2MN _0x1D,34
	CALL _lcd_puts
; 0000 0110                     input ='0';
	LDI  R30,LOW(48)
	MOV  R7,R30
; 0000 0111                     break;
	RJMP _0x21
; 0000 0112 
; 0000 0113                     case (0xB0):
_0x2B:
	CPI  R30,LOW(0xB0)
	BRNE _0x2C
; 0000 0114                     input= '*';
	LDI  R30,LOW(42)
	MOV  R7,R30
; 0000 0115                     flag = 2;
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	MOVW R10,R30
; 0000 0116                     break;
	RJMP _0x21
; 0000 0117 
; 0000 0118                     case (0xC0):
_0x2C:
	CPI  R30,LOW(0xC0)
	BRNE _0x2E
; 0000 0119                     input='\0';
	CLR  R7
; 0000 011A                     flag = 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R10,R30
; 0000 011B                     break;
; 0000 011C 
; 0000 011D                     default:
_0x2E:
; 0000 011E                     break;
; 0000 011F                 }
_0x21:
; 0000 0120                 if ( flag == 2){
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CP   R30,R10
	CPC  R31,R11
	BRNE _0x2F
; 0000 0121                     i = 0;
	CLR  R9
; 0000 0122                     break;
	RJMP _0x1A
; 0000 0123                 }
; 0000 0124                 if(password[i] == input)
_0x2F:
	MOV  R26,R9
	LDI  R27,0
	SUBI R26,LOW(-_password)
	SBCI R27,HIGH(-_password)
	CALL __EEPROMRDB
	CP   R7,R30
	BRNE _0x30
; 0000 0125                 {
; 0000 0126                     i = i+1;
	INC  R9
; 0000 0127                    if ( i  == length)
	LDI  R26,LOW(_length)
	LDI  R27,HIGH(_length)
	CALL __EEPROMRDB
	CP   R30,R9
	BRNE _0x31
; 0000 0128                      {
; 0000 0129                      lcd_clear();
	CALL _lcd_clear
; 0000 012A                      lcd_puts("Unlocked");
	__POINTW2MN _0x1D,36
	CALL _lcd_puts
; 0000 012B                      Correct = 1;
	SBI  0x1B,1
; 0000 012C                      delay_ms(2000);
	CALL SUBOPT_0x2
; 0000 012D                      Correct = 0;
	CBI  0x1B,1
; 0000 012E                      i = 0 ;
	CLR  R9
; 0000 012F                      }
; 0000 0130 
; 0000 0131                 }else{
_0x31:
	RJMP _0x36
_0x30:
; 0000 0132                     lcd_clear();
	CALL _lcd_clear
; 0000 0133                     lcd_puts("Wrong");
	__POINTW2MN _0x1D,45
	CALL _lcd_puts
; 0000 0134                     Wrong = 1 ;
	SBI  0x1B,2
; 0000 0135                     delay_ms(2000);
	CALL SUBOPT_0x2
; 0000 0136                     Wrong = 0 ;
	CBI  0x1B,2
; 0000 0137                     i=0;
	CLR  R9
; 0000 0138                 }
_0x36:
; 0000 0139          }
; 0000 013A 
; 0000 013B         } if (save_mode==1){
_0x1E:
_0x1B:
	LDS  R26,_save_mode
	LDS  R27,_save_mode+1
	SBIW R26,1
	BRNE _0x3B
; 0000 013C 
; 0000 013D                 delay_ms(2000);
	CALL SUBOPT_0x2
; 0000 013E                 New = 1;
	SBI  0x1B,0
; 0000 013F                 lcd_clear();
	CALL _lcd_clear
; 0000 0140                 delay_ms(100);
	LDI  R26,LOW(100)
	LDI  R27,0
	CALL _delay_ms
; 0000 0141                 lcd_gotoxy(0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _lcd_gotoxy
; 0000 0142                 lcd_puts("New Password:");
	__POINTW2MN _0x1D,51
	CALL SUBOPT_0x1
; 0000 0143                 lcd_gotoxy(0,1);
; 0000 0144                 while(1){
_0x3E:
; 0000 0145 
; 0000 0146                    if (flag==0){
	MOV  R0,R10
	OR   R0,R11
	BRNE _0x41
; 0000 0147                         if (keydetect==1){
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R4
	CPC  R31,R5
	BRNE _0x42
; 0000 0148                             keydetect=0;
	CLR  R4
	CLR  R5
; 0000 0149                             setKey();
	RCALL _setKey
; 0000 014A                             count++;
	INC  R6
; 0000 014B                         }
; 0000 014C                    }
_0x42:
; 0000 014D                    else{
	RJMP _0x43
_0x41:
; 0000 014E                         if (count!=0)
	TST  R6
	BREQ _0x44
; 0000 014F                         {
; 0000 0150                         lcd_clear();
	CALL _lcd_clear
; 0000 0151                         lcd_puts("Password Saved");
	__POINTW2MN _0x1D,65
	CALL _lcd_puts
; 0000 0152                         }
; 0000 0153                         input = '\0';
_0x44:
	CLR  R7
; 0000 0154                         flag=0;
	CLR  R10
	CLR  R11
; 0000 0155                         length = count;
	MOV  R30,R6
	LDI  R26,LOW(_length)
	LDI  R27,HIGH(_length)
	CALL __EEPROMWRB
; 0000 0156                         count=0;
	CLR  R6
; 0000 0157                         delay_ms(3000);
	LDI  R26,LOW(3000)
	LDI  R27,HIGH(3000)
	CALL _delay_ms
; 0000 0158                         break;
	RJMP _0x40
; 0000 0159                    }
_0x43:
; 0000 015A 
; 0000 015B                 }
	RJMP _0x3E
_0x40:
; 0000 015C 
; 0000 015D             New=0;
	CBI  0x1B,0
; 0000 015E 
; 0000 015F         }
; 0000 0160       }
_0x3B:
	RJMP _0x18
_0x1A:
; 0000 0161 }
_0x47:
	RJMP _0x47
; .FEND

	.DSEG
_0x1D:
	.BYTE 0x50

	.CSEG

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G103:
; .FSTART __lcd_write_nibble_G103
	ST   -Y,R26
	IN   R30,0x15
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x15,R30
	__DELAY_USB 18
	SBI  0x15,2
	__DELAY_USB 18
	CBI  0x15,2
	__DELAY_USB 18
	RJMP _0x20A0001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G103
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G103
	__DELAY_USB 184
	RJMP _0x20A0001
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G103)
	SBCI R31,HIGH(-__base_y_G103)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R30,Y+1
	STS  __lcd_x,R30
	LD   R30,Y
	STS  __lcd_y,R30
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	CALL SUBOPT_0x3
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0x3
	LDI  R30,LOW(0)
	STS  __lcd_y,R30
	STS  __lcd_x,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2060005
	LDS  R30,__lcd_maxx
	LDS  R26,__lcd_x
	CP   R26,R30
	BRLO _0x2060004
_0x2060005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R26,__lcd_y
	SUBI R26,-LOW(1)
	STS  __lcd_y,R26
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2060007
	RJMP _0x20A0001
_0x2060007:
_0x2060004:
	LDS  R30,__lcd_x
	SUBI R30,-LOW(1)
	STS  __lcd_x,R30
	SBI  0x15,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x15,0
	RJMP _0x20A0001
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2060008:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x206000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2060008
_0x206000A:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	IN   R30,0x14
	ORI  R30,LOW(0xF0)
	OUT  0x14,R30
	SBI  0x14,2
	SBI  0x14,0
	SBI  0x14,1
	CBI  0x15,2
	CBI  0x15,0
	CBI  0x15,1
	LD   R30,Y
	STS  __lcd_maxx,R30
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G103,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G103,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0x4
	CALL SUBOPT_0x4
	CALL SUBOPT_0x4
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G103
	__DELAY_USW 276
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x20A0001:
	ADIW R28,1
	RET
; .FEND

	.CSEG

	.ESEG
_password:
	.BYTE 0x10
_length:
	.BYTE 0x1

	.DSEG
_save_mode:
	.BYTE 0x2
_flagoo:
	.BYTE 0x2
__base_y_G103:
	.BYTE 0x4
__lcd_x:
	.BYTE 0x1
__lcd_y:
	.BYTE 0x1
__lcd_maxx:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:41 WORDS
SUBOPT_0x0:
	CALL _lcd_puts
	MOV  R26,R6
	LDI  R27,0
	SUBI R26,LOW(-_password)
	SBCI R27,HIGH(-_password)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1:
	CALL _lcd_puts
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2:
	LDI  R26,LOW(2000)
	LDI  R27,HIGH(2000)
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x4:
	LDI  R26,LOW(48)
	CALL __lcd_write_nibble_G103
	__DELAY_USW 276
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0xACD
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__EEPROMRDB:
	SBIC EECR,EEWE
	RJMP __EEPROMRDB
	PUSH R31
	IN   R31,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R30,EEDR
	OUT  SREG,R31
	POP  R31
	RET

__EEPROMWRB:
	SBIS EECR,EEWE
	RJMP __EEPROMWRB1
	WDR
	RJMP __EEPROMWRB
__EEPROMWRB1:
	IN   R25,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R24,EEDR
	CP   R30,R24
	BREQ __EEPROMWRB0
	OUT  EEDR,R30
	SBI  EECR,EEMWE
	SBI  EECR,EEWE
__EEPROMWRB0:
	OUT  SREG,R25
	RET

;END OF CODE MARKER
__END_OF_CODE:
