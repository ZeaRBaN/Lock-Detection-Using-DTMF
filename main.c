/*******************************************************
This program was created by the
CodeWizardAVR V3.14 Advanced
Automatic Program Generator
� Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project :
Version :
Date    : 5/23/2022
Author  :
Company :
Comments:


Chip type               : ATmega32A
Program type            : Application
AVR Core Clock frequency: 11.059200 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 512
*******************************************************/

#include <mega32a.h>
#include <delay.h>
#include <string.h>
#include <eeprom.h>
#include <stdio.h>
#include <stdint.h>
#include <alcd.h>  // Alphanumeric LCD functions

// Declare your global variables here
#define New PORTA.0
#define Correct PORTA.1
#define Wrong PORTA.2
#define led4 PORTA.3
#define input1 PINA.4
#define input2 PINA.5
#define input3 PINA.6
#define input4 PINA.7


int keydetect = 0;
char input;
eeprom char password[16];
eeprom char length;
char count = 0;
char i = 0;
int flag = 0;
char Falling = 0 ;
int mode =0;
int save_mode=0;
int flagoo=0;

void setKey()
{
    switch (PINA & 0xF0)
    {
    case (0x10):
        lcd_puts("1");
        password[count] = '1';
        break;

    case (0x20):
        lcd_puts("2");
        password[count] = '2';
        break;

    case (0x30):
        lcd_puts("3");
        password[count] = '3';
        break;

    case (0x40):
        lcd_puts("4");
        password[count] = '4';
        break;

    case (0x50):
        lcd_puts("5");
        password[count] = '5';
        break;

    case (0x60):
        lcd_puts("6");
        password[count] = '6';
        break;

    case (0x70):
        lcd_puts("7");
        password[count] = '7';
        break;

    case (0x80):
        lcd_puts("8");
        password[count] = '8';
        break;

    case (0x90):
        lcd_puts("9");
        password[count] = '9';
        break;

    case (0xA0):
        lcd_puts("0");
        password[count] = '0';
        break;

    case (0xB0):
        lcd_puts("*");
        password[count] = '*';
        flag = 2;
        break;

    case (0xC0):
        lcd_puts("#");
        password[count] = '#';
        break;

    default:
        break;
    }

}



// External Interrupt 0 service routine
interrupt [EXT_INT0] void ext_int0_isr(void)
{
// Place your code here
    keydetect = 1;
    delay_ms(50);

}

// External Interrupt 1 service routine
interrupt [EXT_INT1] void ext_int1_isr(void)
{   
    save_mode=1;
    New=1;
}
// External Interrupt 2 service routine
interrupt [EXT_INT2] void ext_int2_isr(void)
{   
    save_mode=0;
    New=0;
    flagoo=1;
    flag=1;

}

void main(void)
{
// Declare your local variables here

// Input/Output Ports initialization
// Port A initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=Out Bit2=Out Bit1=Out Bit0=Out
    DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (1<<DDA3) | (1<<DDA2) | (1<<DDA1) | (1<<DDA0);
// State: Bit7=P Bit6=P Bit5=P Bit4=P Bit3=0 Bit2=0 Bit1=0 Bit0=0
    PORTA=(1<<PORTA7) | (1<<PORTA6) | (1<<PORTA5) | (1<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

// Port B initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
    DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
    PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

// Port C initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
    DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
    PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

// Port D initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
    DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
    PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);

// External Interrupt(s) initialization
// INT0: On
// INT0 Mode: Rising Edge
// INT1: On
// INT1 Mode: Rising Edge
// INT2: On
// INT2 Mode: Falling Edge
    GICR|=(1<<INT1) | (1<<INT0) | (1<<INT2);
    MCUCR=(1<<ISC11) | (1<<ISC10) | (1<<ISC01) | (1<<ISC00);
    MCUCSR=(0<<ISC2);
    GIFR=(1<<INTF1) | (1<<INTF0) | (1<<INTF2);

// Alphanumeric LCD initialization
// Connections are specified in the
// Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
// RS - PORTC Bit 0
// RD - PORTC Bit 1
// EN - PORTC Bit 2
// D4 - PORTC Bit 4
// D5 - PORTC Bit 5
// D6 - PORTC Bit 6
// D7 - PORTC Bit 7
// Characters/line: 16
    lcd_init(16);

// Global enable interrupts
#asm("sei")

    while (1)
      {if (save_mode==0)
      {
        if(i==0){
        lcd_clear();
        lcd_gotoxy(0,0);
        lcd_puts("Enter Password:");
        lcd_gotoxy(0,1);
        delay_ms(200);  
        }
        if (keydetect==1)
        {
         keydetect = 0;
         switch (PINA & 0xF0)
                {   
                    case (0x10):
                    lcd_puts("1");
                    input= '1';
                    break;
                    
                    case (0x20):
                    lcd_puts("2");  
                    input= '2';
                    break;
                    
                    case (0x30):
                    lcd_puts("3");
                    input= '3';
                    break;
                    
                    case (0x40):
                    lcd_puts("4");
                    input= '4';
                    break;
                    
                    case (0x50):
                    lcd_puts("5");
                    input= '5';
                    break;
                    
                    case (0x60):
                    lcd_puts("6");
                    input= '6';
                    break;
                    
                    case (0x70):
                    lcd_puts("7");
                    input= '7';
                    break;
                    
                    case (0x80):
                    lcd_puts("8");
                    input= '8';
                    break;

                    case (0x90):
                    lcd_puts("9");
                    input= '9';
                    break;
                    
                    case (0xA0):
                    lcd_puts("0");
                    input ='0';
                    break;
                    
                    case (0xB0):
                    input= '*';
                    flag = 2;
                    break;
                    
                    case (0xC0):
                    input='\0';
                    flag = 1;
                    break;

                    default:
                    break;
                }
                if ( flag == 2){
                    i = 0;
                    break;
                } 
                if(password[i] == input)
                { 
                    i = i+1;               
                   if ( i  == length)
                     {
                     lcd_clear();
                     lcd_puts("Unlocked");
                     Correct = 1; 
                     delay_ms(2000);
                     Correct = 0;   
                     i = 0 ; 
                     }
                     
                }else{
                    lcd_clear();
                    lcd_puts("Wrong");
                    Wrong = 1 ;   
                    delay_ms(2000);
                    Wrong = 0 ;
                    i=0; 
                }
         } 
            
        } if (save_mode==1){
           
                delay_ms(2000); 
                New = 1;
                lcd_clear();
                delay_ms(100); 
                lcd_gotoxy(0,0);
                lcd_puts("New Password:");
                lcd_gotoxy(0,1); 
                while(1){   
                    
                   if (flag==0){
                        if (keydetect==1){
                            keydetect=0;
                            setKey();
                            count++;
                        } 
                   }
                   else{ 
                        if (count!=0)
                        { 
                        lcd_clear();
                        lcd_puts("Password Saved");
                        }
                        input = '\0';
                        flag=0;
                        length = count;
                        count=0;  
                        delay_ms(3000);
                        break;
                   } 

                }
            
            New=0;
            
        }
      }
}
