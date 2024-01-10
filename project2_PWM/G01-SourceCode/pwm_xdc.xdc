set_property -dict {PACKAGE_PIN Y9 IOSTANDARD LVCMOS33} [get_ports clk]
set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS33} [get_ports rst]
#LED
#set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports {led_out[7]}]
#set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS33} [get_ports {led_out[6]}]
#set_property -dict {PACKAGE_PIN W22 IOSTANDARD LVCMOS33} [get_ports {led_out[5]}]
#set_property -dict {PACKAGE_PIN V22 IOSTANDARD LVCMOS33} [get_ports {led_out[4]}]
#set_property -dict {PACKAGE_PIN U21 IOSTANDARD LVCMOS33} [get_ports {led_out[3]}]
#set_property -dict {PACKAGE_PIN U22 IOSTANDARD LVCMOS33} [get_ports {led_out[2]}]
#set_property -dict {PACKAGE_PIN T21 IOSTANDARD LVCMOS33} [get_ports {led_out[1]}]
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports pwm]


set_property SLEW FAST [get_ports pwm]
set_property OFFCHIP_TERM NONE [get_ports pwm]
set_property DRIVE 16 [get_ports pwm]
