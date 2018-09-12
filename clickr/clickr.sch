EESchema Schematic File Version 4
LIBS:alpheus-cache
EELAYER 26 0
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
L alphadox:SWITCH_DIODE SW1
U 1 1 5B710E42
P 4300 2250
F 0 "SW1" H 4300 2300 50  0000 C CNN
F 1 "0:0" H 4300 2150 50  0000 C CNN
F 2 "alphadox:MX_SOCKET_FLIP_DIODE" H 4300 2250 50  0001 C CNN
F 3 "" H 4300 2250 50  0001 C CNN
	1    4300 2250
	1    0    0    -1  
$EndComp
$Comp
L alphadox:Feather_M0_Bluefruit A1
U 1 1 5B74E8A4
P 2250 2750
F 0 "A1" H 2250 3675 50  0000 C CNN
F 1 "Feather_M0_Bluefruit" H 2250 3584 50  0000 C CNN
F 2 "alphadox:Feather_M0_Bluefruit" H 2400 2900 50  0001 C CNN
F 3 "" H 2400 2900 50  0001 C CNN
	1    2250 2750
	1    0    0    -1  
$EndComp
$Comp
L alphadox:SWITCH_DIODE SW3
U 1 1 5B7A4243
P 5100 2250
F 0 "SW3" H 5100 2300 50  0000 C CNN
F 1 "0:1" H 5100 2150 50  0000 C CNN
F 2 "alphadox:MX_SOCKET_FLIP_DIODE" H 5100 2250 50  0001 C CNN
F 3 "" H 5100 2250 50  0001 C CNN
	1    5100 2250
	1    0    0    -1  
$EndComp
$Comp
L alphadox:SWITCH_DIODE SW4
U 1 1 5B7A425E
P 5100 2700
F 0 "SW4" H 5100 2750 50  0000 C CNN
F 1 "1:1" H 5100 2600 50  0000 C CNN
F 2 "alphadox:MX_SOCKET_FLIP_DIODE" H 5100 2700 50  0001 C CNN
F 3 "" H 5100 2700 50  0001 C CNN
	1    5100 2700
	1    0    0    -1  
$EndComp
$Comp
L alphadox:SWITCH_DIODE SW5
U 1 1 5B7A4289
P 5100 3150
F 0 "SW5" H 5100 3200 50  0000 C CNN
F 1 "2:1" H 5100 3050 50  0000 C CNN
F 2 "alphadox:MX_SOCKET_FLIP_DIODE" H 5100 3150 50  0001 C CNN
F 3 "" H 5100 3150 50  0001 C CNN
	1    5100 3150
	1    0    0    -1  
$EndComp
$Comp
L alphadox:SWITCH_DIODE SW2
U 1 1 5B7A4308
P 4300 3150
F 0 "SW2" H 4300 3200 50  0000 C CNN
F 1 "2:0" H 4300 3050 50  0000 C CNN
F 2 "alphadox:MX_SOCKET_FLIP_DIODE" H 4300 3150 50  0001 C CNN
F 3 "" H 4300 3150 50  0001 C CNN
	1    4300 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 2050 4000 2050
Wire Wire Line
	4800 2050 4800 2250
Wire Wire Line
	4000 2250 4000 2050
Wire Wire Line
	4000 2050 4800 2050
Wire Wire Line
	4800 2700 4800 2500
Wire Wire Line
	4800 3150 4800 2950
Wire Wire Line
	4800 2950 4000 2950
Wire Wire Line
	4000 2950 4000 3150
Wire Wire Line
	4000 2950 3650 2950
Connection ~ 4000 2950
Wire Wire Line
	4600 2250 4600 2350
Wire Wire Line
	4600 2350 4500 2350
Wire Wire Line
	5400 2250 5400 2350
Wire Wire Line
	5400 2350 5300 2350
Wire Wire Line
	5400 2700 5400 2800
Wire Wire Line
	5400 2800 5300 2800
Wire Wire Line
	5400 3150 5400 3250
Wire Wire Line
	5400 3250 5300 3250
Wire Wire Line
	4900 2350 4700 2350
Wire Wire Line
	4700 2350 4700 2500
Wire Wire Line
	4700 2800 4900 2800
Wire Wire Line
	4900 3250 4700 3250
Wire Wire Line
	4700 3250 4700 2800
Connection ~ 4700 2800
Wire Wire Line
	4700 3250 4700 3500
Connection ~ 4700 3250
Wire Wire Line
	4100 2350 3900 2350
Wire Wire Line
	3900 2350 3900 3250
Wire Wire Line
	3900 3250 4100 3250
Wire Wire Line
	3900 3250 3900 3500
Connection ~ 3900 3250
Text Label 3650 2050 0    50   ~ 0
ROW0
Text Label 3900 3500 1    50   ~ 0
COL0
Text Label 3650 2500 0    50   ~ 0
ROW1
Connection ~ 4000 2050
Wire Wire Line
	4700 2500 4700 2800
Text Label 3650 2950 0    50   ~ 0
ROW2
Text Label 4700 3500 1    50   ~ 0
COL1
Text Label 2750 3350 0    50   ~ 0
ROW0
Text Label 2750 3250 0    50   ~ 0
ROW1
Text Label 2750 3150 0    50   ~ 0
ROW2
Text Label 2750 2950 0    50   ~ 0
COL0
Text Label 2750 3050 0    50   ~ 0
COL1
NoConn ~ 1750 2050
NoConn ~ 1750 2150
NoConn ~ 1750 2250
NoConn ~ 1750 2450
NoConn ~ 1750 2550
NoConn ~ 1750 2650
NoConn ~ 1750 2750
NoConn ~ 1750 2850
NoConn ~ 1750 2950
NoConn ~ 1750 3050
NoConn ~ 1750 3150
NoConn ~ 1750 3250
NoConn ~ 1750 3350
NoConn ~ 1750 3450
NoConn ~ 1750 3550
NoConn ~ 2750 3550
NoConn ~ 2750 3450
NoConn ~ 2750 2450
NoConn ~ 2750 2550
NoConn ~ 2750 2650
NoConn ~ 2750 2750
NoConn ~ 2750 2850
Wire Wire Line
	4600 3150 4600 3250
Wire Wire Line
	4600 3250 4500 3250
Wire Wire Line
	3650 2500 4800 2500
$Comp
L power:GND #PWR0101
U 1 1 5B7F59B8
P 1750 2350
F 0 "#PWR0101" H 1750 2100 50  0001 C CNN
F 1 "GND" V 1755 2222 50  0000 R CNN
F 2 "" H 1750 2350 50  0001 C CNN
F 3 "" H 1750 2350 50  0001 C CNN
	1    1750 2350
	0    1    1    0   
$EndComp
$EndSCHEMATC
