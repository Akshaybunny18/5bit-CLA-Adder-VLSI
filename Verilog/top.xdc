##########################################
# CLOCK (100 MHz onboard clock)
##########################################
set_property PACKAGE_PIN F14 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk [get_ports clk]


##########################################
# RESET (BTN0 -> J2)
##########################################
set_property PACKAGE_PIN J2 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]


##########################################
# SWITCH INPUTS FOR A (MSB→LSB)
# A = {SW15,SW14,SW13,SW12,SW11}
##########################################

# SW15 (MSB of A)
set_property PACKAGE_PIN K1 [get_ports sw15]
set_property IOSTANDARD LVCMOS33 [get_ports sw15]

# SW14
set_property PACKAGE_PIN K2 [get_ports sw14]
set_property IOSTANDARD LVCMOS33 [get_ports sw14]

# SW13
set_property PACKAGE_PIN L1 [get_ports sw13]
set_property IOSTANDARD LVCMOS33 [get_ports sw13]

# SW12
set_property PACKAGE_PIN M1 [get_ports sw12]
set_property IOSTANDARD LVCMOS33 [get_ports sw12]

# SW11 (LSB of A)
set_property PACKAGE_PIN M2 [get_ports sw11]
set_property IOSTANDARD LVCMOS33 [get_ports sw11]


##########################################
# SWITCH INPUTS FOR B (MSB→LSB)
# B = {SW10,SW9,SW8,SW7,SW6}
##########################################

# SW10 (MSB of B)
set_property PACKAGE_PIN N1 [get_ports sw10]
set_property IOSTANDARD LVCMOS33 [get_ports sw10]

# SW9
set_property PACKAGE_PIN N2 [get_ports sw9]
set_property IOSTANDARD LVCMOS33 [get_ports sw9]

# SW8
set_property PACKAGE_PIN P1 [get_ports sw8]
set_property IOSTANDARD LVCMOS33 [get_ports sw8]

# SW7
set_property PACKAGE_PIN P2 [get_ports sw7]
set_property IOSTANDARD LVCMOS33 [get_ports sw7]

# SW6 (LSB of B)
set_property PACKAGE_PIN R1 [get_ports sw6]
set_property IOSTANDARD LVCMOS33 [get_ports sw6]


##########################################
# LED OUTPUTS  (LED0 → LED15)
##########################################

set_property PACKAGE_PIN G1 [get_ports {leds[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[0]}]

set_property PACKAGE_PIN G2 [get_ports {leds[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[1]}]

set_property PACKAGE_PIN F1 [get_ports {leds[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[2]}]

set_property PACKAGE_PIN F2 [get_ports {leds[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[3]}]

set_property PACKAGE_PIN E1 [get_ports {leds[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[4]}]

set_property PACKAGE_PIN E2 [get_ports {leds[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[5]}]

set_property PACKAGE_PIN E3 [get_ports {leds[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[6]}]

set_property PACKAGE_PIN E5 [get_ports {leds[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[7]}]

set_property PACKAGE_PIN E6 [get_ports {leds[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[8]}]

set_property PACKAGE_PIN C3 [get_ports {leds[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[9]}]

set_property PACKAGE_PIN B2 [get_ports {leds[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[10]}]

set_property PACKAGE_PIN A2 [get_ports {leds[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[11]}]

set_property PACKAGE_PIN B3 [get_ports {leds[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[12]}]

set_property PACKAGE_PIN A3 [get_ports {leds[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[13]}]

set_property PACKAGE_PIN B4 [get_ports {leds[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[14]}]

set_property PACKAGE_PIN A4 [get_ports {leds[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[15]}]


# new

# PmodA signals (s0..s6)
set_property PACKAGE_PIN A14 [get_ports {pmoda[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pmoda[0]}]

set_property PACKAGE_PIN B14 [get_ports {pmoda[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pmoda[1]}]

set_property PACKAGE_PIN A13 [get_ports {pmoda[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pmoda[2]}]

set_property PACKAGE_PIN B13 [get_ports {pmoda[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pmoda[3]}]

set_property PACKAGE_PIN C14 [get_ports {pmoda[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pmoda[4]}]

set_property PACKAGE_PIN C13 [get_ports {pmoda[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pmoda[5]}]

