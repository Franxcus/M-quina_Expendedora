
?
Command: %s
53*	vivadotcl2
place_designZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
Implementation2

xc7a12tiZ17-347h px� 
p
0Got license for feature '%s' and/or device '%s'
310*common2
Implementation2

xc7a12tiZ17-349h px� 
H
Releasing license: %s
83*common2
ImplementationZ17-83h px� 
>
Running DRC with %s threads
24*drc2
2Z23-27h px� 
D
DRC finished with %s
79*	vivadotcl2

0 ErrorsZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
^
,Running DRC as a precondition to command %s
22*	vivadotcl2
place_designZ4-22h px� 
>
Running DRC with %s threads
24*drc2
2Z23-27h px� 
D
DRC finished with %s
79*	vivadotcl2

0 ErrorsZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
k
BMultithreading enabled for place_design using a maximum of %s CPUs12*	placeflow2
2Z30-611h px� 
C

Starting %s Task
103*constraints2
PlacerZ18-103h px� 
R

Phase %s%s
101*constraints2
1 2
Placer InitializationZ18-101h px� 
d

Phase %s%s
101*constraints2
1.1 2'
%Placer Initialization Netlist SortingZ18-101h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

1937.9532
0.000Z17-268h px� 
`
%s*common2G
EPhase 1.1 Placer Initialization Netlist Sorting | Checksum: ec8302a5
h px� 
�

%s
*constraints2a
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.002 . Memory (MB): peak = 1937.953 ; gain = 0.000h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0012

1937.9532
0.000Z17-268h px� 
q

Phase %s%s
101*constraints2
1.2 24
2IO Placement/ Clock Placement/ Build Placer DeviceZ18-101h px� 
�
�IO placement is infeasible. Number of unplaced IO Ports (%s) is greater than number of available pins (%s).
The following are banks with available pins: %s
58*place2
122
02�
�
 IO Group: 0 with : SioStd: LVCMOS18   VCCO = 1.8 Termination: 0  TermDir:  Out  RangeId: 1 Drv: 12  has only 0 sites available on device, but needs 9 sites.
	Term: <MSGMETA::BEGIN::BLOCK>DIGCTRL[0]<MSGMETA::END>
	Term: <MSGMETA::BEGIN::BLOCK>DIGCTRL[1]<MSGMETA::END>
	Term: <MSGMETA::BEGIN::BLOCK>DIGCTRL[3]<MSGMETA::END>
	Term: <MSGMETA::BEGIN::BLOCK>DIGCTRL[8]<MSGMETA::END>
	Term: <MSGMETA::BEGIN::BLOCK>SEGMENTOS[1]<MSGMETA::END>
	Term: <MSGMETA::BEGIN::BLOCK>SEGMENTOS[3]<MSGMETA::END>
	Term: <MSGMETA::BEGIN::BLOCK>SEGMENTOS[5]<MSGMETA::END>
	Term: <MSGMETA::BEGIN::BLOCK>SEGMENTOS[6]<MSGMETA::END>
	Term: <MSGMETA::BEGIN::BLOCK>ESTADOS[0]<MSGMETA::END>


 IO Group: 1 with : SioStd: LVCMOS18   VCCO = 1.8 Termination: 0  TermDir:  In   RangeId: 1  has only 0 sites available on device, but needs 3 sites.
	Term: <MSGMETA::BEGIN::BLOCK>MONEDAS[1]<MSGMETA::END>
	Term: <MSGMETA::BEGIN::BLOCK>MONEDAS[2]<MSGMETA::END>
	Term: <MSGMETA::BEGIN::BLOCK>PAGAR<MSGMETA::END>

"�

DIGCTRL[0]2�
 IO Group: 0 with : SioStd: LVCMOS18   VCCO = 1.8 Termination: 0  TermDir:  Out  RangeId: 1 Drv: 12  has only 0 sites available on device, but needs 9 sites.
	Term: :
	Term: "

DIGCTRL[1]2 :
	Term: "

DIGCTRL[3]2 :
	Term: "

DIGCTRL[8]2 :
	Term: "
SEGMENTOS[1]2 :
	Term: "
SEGMENTOS[3]2 :
	Term: "
SEGMENTOS[5]2 :
	Term: "
SEGMENTOS[6]2 :
	Term: "�

ESTADOS[0]2 :�


 IO Group: 1 with : SioStd: LVCMOS18   VCCO = 1.8 Termination: 0  TermDir:  In   RangeId: 1  has only 0 sites available on device, but needs 3 sites.
	Term: "

MONEDAS[1]2 :
	Term: "

MONEDAS[2]2 :
	Term: "
PAGAR2 :

8Z30-58h px� 
�(
'IO placer failed to find a solution
%s
374*place2�(
�(Below is the partial placement that can be analyzed to see if any constraint modifications will make the IO placement problem easier to solve.

+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|                                                                     IO Placement : Bank Stats                                                                           |
+----+-------+-------+------------------------------------------------------------------------+------------------------------------------+--------+--------+--------+-----+
| Id | Pins  | Terms |                               Standards                                |                IDelayCtrls               |  VREF  |  VCCO  |   VR   | DCI |
+----+-------+-------+------------------------------------------------------------------------+------------------------------------------+--------+--------+--------+-----+
|  0 |     0 |     0 |                                                                        |                                          |        |        |        |     |
| 14 |    50 |    15 | LVCMOS33(15)                                                           |                                          |        |  +3.30 |    YES |     |
| 15 |    50 |     2 | LVCMOS33(2)                                                            |                                          |        |  +3.30 |    YES |     |
| 34 |    50 |     1 | LVCMOS33(1)                                                            |                                          |        |  +3.30 |    YES |     |
+----+-------+-------+------------------------------------------------------------------------+------------------------------------------+--------+--------+--------+-----+
|    |   150 |    18 |                                                                        |                                          |        |        |        |     |
+----+-------+-------+------------------------------------------------------------------------+------------------------------------------+--------+--------+--------+-----+

IO Placement:
+--------+----------------------+-----------------+----------------------+----------------------+----------------------+
| BankId |             Terminal | Standard        | Site                 | Pin                  | Attributes           |
+--------+----------------------+-----------------+----------------------+----------------------+----------------------+
| 14     | DIGCTRL[2]           | LVCMOS33        | IOB_X0Y44            | J18                  |                      |
|        | DIGCTRL[4]           | LVCMOS33        | IOB_X0Y40            | J14                  |                      |
|        | DIGCTRL[5]           | LVCMOS33        | IOB_X0Y26            | P14                  |                      |
|        | DIGCTRL[6]           | LVCMOS33        | IOB_X0Y24            | T14                  |                      |
|        | ERROR                | LVCMOS33        | IOB_X0Y39            | K15                  |                      |
|        | ESTADOS[1]           | LVCMOS33        | IOB_X0Y9             | V14                  |                      |
|        | ESTADOS[2]           | LVCMOS33        | IOB_X0Y8             | V12                  |                      |
|        | ESTADOS[3]           | LVCMOS33        | IOB_X0Y3             | V11                  |                      |
|        | MONEDAS[0]           | LVCMOS33        | IOB_X0Y46            | J15                  |                      |
|        | MONEDAS[3]           | LVCMOS33        | IOB_X0Y25            | R15                  |                      |
|        | SEGMENTOS[0]         | LVCMOS33        | IOB_X0Y41            | L18                  |                      |
|        | SEGMENTOS[2]         | LVCMOS33        | IOB_X0Y28            | P15                  |                      |
|        | SEGMENTOS[4]         | LVCMOS33        | IOB_X0Y48            | K16                  |                      |
|        | TIPO_REFRESCO[0]     | LVCMOS33        | IOB_X0Y5             | U12                  |                      |
|        | TIPO_REFRESCO[1]     | LVCMOS33        | IOB_X0Y4             | U11                  |                      |
+--------+----------------------+-----------------+----------------------+----------------------+----------------------+
| 15     | REFRESCO_OUT         | LVCMOS33        | IOB_X0Y54            | H17                  |                      |
|        | RESET                | LVCMOS33        | IOB_X0Y87            | C12                  | *                    |
+--------+----------------------+-----------------+----------------------+----------------------+----------------------+
| 34     | DIGCTRL[7]           | LVCMOS33        | IOB_X1Y44            | K2                   |                      |
+--------+----------------------+-----------------+----------------------+----------------------+----------------------+
Z30-374h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
�
[Partially locked IO Bus is found. Following components of the IO Bus %s are not locked: %s
87*place2	
DIGCTRL2�
� '<MSGMETA::BEGIN::BLOCK>DIGCTRL[8]<MSGMETA::END>'  '<MSGMETA::BEGIN::BLOCK>DIGCTRL[3]<MSGMETA::END>'  '<MSGMETA::BEGIN::BLOCK>DIGCTRL[1]<MSGMETA::END>'  '<MSGMETA::BEGIN::BLOCK>DIGCTRL[0]<MSGMETA::END>' "

DIGCTRL[8]2 ':'  '"

DIGCTRL[3]2 :'  '"

DIGCTRL[1]2 :'  '"

DIGCTRL[0]2 :' 8Z30-87h px� 
�
[Partially locked IO Bus is found. Following components of the IO Bus %s are not locked: %s
87*place2	
ESTADOS2M
3 '<MSGMETA::BEGIN::BLOCK>ESTADOS[0]<MSGMETA::END>' "

ESTADOS[0]2 ':' 8Z30-87h px� 
�
[Partially locked IO Bus is found. Following components of the IO Bus %s are not locked: %s
87*place2	
MONEDAS2�
f '<MSGMETA::BEGIN::BLOCK>MONEDAS[2]<MSGMETA::END>'  '<MSGMETA::BEGIN::BLOCK>MONEDAS[1]<MSGMETA::END>' "

MONEDAS[2]2 ':'  '"

MONEDAS[1]2 :' 8Z30-87h px� 
�
[Partially locked IO Bus is found. Following components of the IO Bus %s are not locked: %s
87*place2
	SEGMENTOS2�
� '<MSGMETA::BEGIN::BLOCK>SEGMENTOS[6]<MSGMETA::END>'  '<MSGMETA::BEGIN::BLOCK>SEGMENTOS[5]<MSGMETA::END>'  '<MSGMETA::BEGIN::BLOCK>SEGMENTOS[3]<MSGMETA::END>'  '<MSGMETA::BEGIN::BLOCK>SEGMENTOS[1]<MSGMETA::END>' "
SEGMENTOS[6]2 ':'  '"
SEGMENTOS[5]2 :'  '"
SEGMENTOS[3]2 :'  '"
SEGMENTOS[1]2 :' 8Z30-87h px� 
n
%s*common2U
SPhase 1.2 IO Placement/ Clock Placement/ Build Placer Device | Checksum: 1968b91b2
h px� 
�

%s
*constraints2a
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.298 . Memory (MB): peak = 1937.953 ; gain = 0.000h px� 
O
%s*common26
4Phase 1 Placer Initialization | Checksum: 1968b91b2
h px� 
�

%s
*constraints2a
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.299 . Memory (MB): peak = 1937.953 ; gain = 0.000h px� 
�
�Placer failed with error: '%s'
Please review all ERROR and WARNING messages during placement to understand the cause for failure.
1*	placeflow2
IO Clock Placer failedZ30-99h px� 
D
%s*common2+
)Ending Placer Task | Checksum: 1968b91b2
h px� 
�

%s
*constraints2a
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.300 . Memory (MB): peak = 1937.953 ; gain = 0.000h px� 

G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
452
62
152
4Z4-41h px� 
<

%s failed
30*	vivadotcl2
place_designZ4-43h px� 
[
Command failed: %s
69*common2&
$Placer could not place all instancesZ17-69h px� 
\
Exiting %s at %s...
206*common2
Vivado2
Thu Jan 16 17:42:14 2025Z17-206h px� 


End Record