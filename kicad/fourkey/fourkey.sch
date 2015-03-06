EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:component
LIBS:fourkey-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L TEENSY2.0 U1
U 1 1 54F8FFED
P 1500 2250
F 0 "U1" V 1550 2250 60  0000 C CNN
F 1 "TEENSY2.0" V 1450 2250 60  0000 C CNN
F 2 "footprint:TEENSY_2.0" H 1500 2250 60  0001 C CNN
F 3 "" H 1500 2250 60  0000 C CNN
	1    1500 2250
	1    0    0    -1  
$EndComp
$Comp
L SWITCH_DIODE 0;0
U 1 1 54F9005C
P 3200 1500
F 0 "0;0" H 3350 1610 50  0000 C CNN
F 1 "SWITCH_DIODE" H 3200 1420 50  0000 C CNN
F 2 "footprint:MX_FLIP_DIODE" H 3200 1500 60  0001 C CNN
F 3 "" H 3200 1500 60  0000 C CNN
	1    3200 1500
	1    0    0    -1  
$EndComp
$Comp
L SWITCH_DIODE 1;0
U 1 1 54F900D9
P 4200 1500
F 0 "1;0" H 4350 1610 50  0000 C CNN
F 1 "SWITCH_DIODE" H 4200 1420 50  0000 C CNN
F 2 "footprint:MX_FLIP_DIODE" H 4200 1500 60  0001 C CNN
F 3 "" H 4200 1500 60  0000 C CNN
	1    4200 1500
	1    0    0    -1  
$EndComp
$Comp
L SWITCH_DIODE 0;1
U 1 1 54F9010F
P 3200 2200
F 0 "0;1" H 3350 2310 50  0000 C CNN
F 1 "SWITCH_DIODE" H 3200 2120 50  0000 C CNN
F 2 "footprint:MX_FLIP_DIODE" H 3200 2200 60  0001 C CNN
F 3 "" H 3200 2200 60  0000 C CNN
	1    3200 2200
	1    0    0    -1  
$EndComp
$Comp
L SWITCH_DIODE 1;1
U 1 1 54F90141
P 4200 2200
F 0 "1;1" H 4350 2310 50  0000 C CNN
F 1 "SWITCH_DIODE" H 4200 2120 50  0000 C CNN
F 2 "footprint:MX_FLIP_DIODE" H 4200 2200 60  0001 C CNN
F 3 "" H 4200 2200 60  0000 C CNN
	1    4200 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	2700 1300 2700 2200
Wire Wire Line
	2700 2200 2900 2200
Wire Wire Line
	2900 1500 2700 1500
Connection ~ 2700 1500
Wire Wire Line
	3700 1300 3700 2200
Wire Wire Line
	3700 2200 3900 2200
Wire Wire Line
	3900 1500 3700 1500
Connection ~ 3700 1500
Wire Wire Line
	3500 1500 3500 1600
Wire Wire Line
	3500 1600 3400 1600
Wire Wire Line
	4500 1500 4500 1600
Wire Wire Line
	4500 1600 4400 1600
Wire Wire Line
	4500 2200 4500 2300
Wire Wire Line
	4500 2300 4400 2300
Wire Wire Line
	3500 2200 3500 2300
Wire Wire Line
	3500 2300 3400 2300
Wire Wire Line
	4000 1800 4000 1600
Wire Wire Line
	2500 1800 4000 1800
Wire Wire Line
	3000 1800 3000 1600
Connection ~ 3000 1800
Wire Wire Line
	4000 2500 4000 2300
Wire Wire Line
	2500 2500 4000 2500
Wire Wire Line
	3000 2500 3000 2300
Connection ~ 3000 2500
Text Label 2700 1300 0    60   ~ 0
COL0
Text Label 3700 1300 0    60   ~ 0
COL1
Text Label 2500 1800 0    60   ~ 0
ROW0
Text Label 2500 2500 0    60   ~ 0
ROW1
Wire Wire Line
	2100 950  2200 950 
Wire Wire Line
	2100 1050 2200 1050
Wire Wire Line
	2100 1150 2200 1150
Wire Wire Line
	2100 1250 2200 1250
Text Label 2200 950  0    60   ~ 0
COL0
Text Label 2200 1050 0    60   ~ 0
COL1
Text Label 2200 1150 0    60   ~ 0
ROW0
Text Label 2200 1250 0    60   ~ 0
ROW1
$EndSCHEMATC
