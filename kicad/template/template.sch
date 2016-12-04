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
LIBS:template-cache
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
L SWITCH_DIODE SW1:1
U 1 1 55134F03
P 4900 2750
F 0 "SW1:1" H 5050 2860 50  0000 C CNN
F 1 "SW1:1" H 4900 2670 50  0000 C CNN
F 2 "footprints:MX_FLIP_DIODE" H 4900 2750 60  0001 C CNN
F 3 "" H 4900 2750 60  0000 C CNN
	1    4900 2750
	1    0    0    -1  
$EndComp
$Comp
L SWITCH_DIODE SW1:2
U 1 1 55134F46
P 5700 2750
F 0 "SW1:2" H 5850 2860 50  0000 C CNN
F 1 "SW1;0" H 5700 2670 50  0000 C CNN
F 2 "footprints:MX_FLIP_DIODE" H 5700 2750 60  0001 C CNN
F 3 "" H 5700 2750 60  0000 C CNN
	1    5700 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 2750 5200 2850
Wire Wire Line
	5200 2850 5100 2850
Wire Wire Line
	6000 2750 6000 2850
Wire Wire Line
	6000 2850 5900 2850
Wire Wire Line
	4600 2750 4600 2550
Wire Wire Line
	4400 2550 5400 2550
Wire Wire Line
	5400 2550 5400 2750
Connection ~ 4600 2550
$Comp
L SWITCH_DIODE SW0:1
U 1 1 551350A1
P 4900 3150
F 0 "SW0:1" H 5050 3260 50  0000 C CNN
F 1 "SW0:1" H 4900 3070 50  0000 C CNN
F 2 "footprints:MX_FLIP_DIODE" H 4900 3150 60  0001 C CNN
F 3 "" H 4900 3150 60  0000 C CNN
	1    4900 3150
	1    0    0    -1  
$EndComp
$Comp
L SWITCH_DIODE SW0:2
U 1 1 551350A7
P 5700 3150
F 0 "SW0:2" H 5850 3260 50  0000 C CNN
F 1 "SW0:0" H 5700 3070 50  0000 C CNN
F 2 "footprints:MX_FLIP_DIODE" H 5700 3150 60  0001 C CNN
F 3 "" H 5700 3150 60  0000 C CNN
	1    5700 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 3150 5200 3250
Wire Wire Line
	5200 3250 5100 3250
Wire Wire Line
	6000 3150 6000 3250
Wire Wire Line
	6000 3250 5900 3250
Wire Wire Line
	4600 3150 4600 2950
Wire Wire Line
	4300 2950 5400 2950
Wire Wire Line
	5400 2950 5400 3150
Connection ~ 4600 2950
Wire Wire Line
	4700 2850 4700 3550
Connection ~ 4700 3250
Wire Wire Line
	5500 3650 5500 2850
Connection ~ 5500 3250
Text Label 4400 2550 2    60   ~ 0
ROW1
Text Label 4400 2950 2    60   ~ 0
ROW0
Text Label 4700 3550 1    60   ~ 0
COL2
Text Label 5500 3550 1    60   ~ 0
COL3
Text Label 4700 3550 3    60   ~ 0
COL1
Text Label 5500 3550 3    60   ~ 0
COL0
Wire Wire Line
	4400 1900 4400 2550
Wire Wire Line
	4300 2000 4300 2950
Wire Wire Line
	4700 3550 4200 3550
Wire Wire Line
	4200 3550 4200 2100
Wire Wire Line
	4100 3650 5500 3650
Wire Wire Line
	4100 2200 4100 3650
Wire Wire Line
	3350 2200 4100 2200
Wire Wire Line
	4200 2100 3350 2100
Wire Wire Line
	3350 2000 4300 2000
Wire Wire Line
	3350 1900 4400 1900
$Comp
L TEENSY2.0 U1
U 1 1 556E74BF
P 2750 3200
F 0 "U1" V 2800 3200 60  0000 C CNN
F 1 "TEENSY2.0" V 2700 3200 60  0000 C CNN
F 2 "" H 2750 3200 60  0000 C CNN
F 3 "" H 2750 3200 60  0000 C CNN
	1    2750 3200
	1    0    0    -1  
$EndComp
$EndSCHEMATC
