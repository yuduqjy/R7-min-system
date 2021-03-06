# create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0

start_gui
create_project R7MS . -part xc7z030ffg676-1 -force
add_files -fileset constrs_1 -norecurse xdc/q7ms.xdc
set_property target_language VHDL [current_project]
create_bd_design "miniarm"
startgroup

create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]
startgroup

startgroup
set_property -dict [list CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {50} CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {40} CONFIG.PCW_UIPARAM_DDR_ENABLE {1} CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K256M16 RE-125} CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} CONFIG.PCW_SD0_GRP_CD_ENABLE {1} CONFIG.PCW_SD0_GRP_CD_IO {MIO 46} CONFIG.PCW_SD0_GRP_WP_ENABLE {1} CONFIG.PCW_SD0_GRP_WP_IO {MIO 47} CONFIG.PCW_SD0_GRP_POW_ENABLE {1} CONFIG.PCW_SD0_GRP_POW_IO {MIO 48} CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1}] [get_bd_cells processing_system7_0]
endgroup

startgroup
set_property -dict [list CONFIG.PCW_UART0_PERIPHERAL_ENABLE {0} CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} CONFIG.PCW_UART1_UART1_IO {MIO 52 .. 53}] [get_bd_cells processing_system7_0]
endgroup

startgroup
set_property -dict [list CONFIG.PCW_NAND_PERIPHERAL_ENABLE {1} CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {0} CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} CONFIG.PCW_ENET0_ENET0_IO {EMIO} CONFIG.PCW_SD0_SD0_IO {MIO 40 .. 45} CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {1} CONFIG.PCW_SPI0_SPI0_IO {MIO 16 .. 21} CONFIG.PCW_SPI0_GRP_SS1_ENABLE {1} CONFIG.PCW_SPI0_GRP_SS2_ENABLE {1} CONFIG.PCW_CAN0_PERIPHERAL_ENABLE {1} CONFIG.PCW_CAN0_CAN0_IO {MIO 26 .. 27} CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {1} CONFIG.PCW_I2C0_I2C0_IO {MIO 22 .. 23} CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {1} CONFIG.PCW_I2C1_I2C1_IO {MIO 24 .. 25}] [get_bd_cells processing_system7_0]
endgroup

startgroup
set_property -dict [list CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} CONFIG.PCW_USB0_RESET_ENABLE {1} CONFIG.PCW_USB0_RESET_IO {MIO 49} CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1}] [get_bd_cells processing_system7_0]
endgroup

startgroup
set_property -dict [list CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1}] [get_bd_cells processing_system7_0]
endgroup

create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_0
endgroup
set_property -dict [list CONFIG.SINGLE_PORT_BRAM {1}] [get_bd_cells axi_bram_ctrl_0]
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins axi_gpio_0/S_AXI]
apply_bd_automation -rule xilinx.com:bd_rule:board  [get_bd_intf_pins axi_gpio_0/GPIO]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins axi_bram_ctrl_0/S_AXI]
endgroup
set_property range 256K [get_bd_addr_segs {processing_system7_0/Data/SEG_axi_bram_ctrl_0_Mem0}]
set_property -dict [list CONFIG.C_GPIO_WIDTH {4} CONFIG.C_ALL_OUTPUTS {1}] [get_bd_cells axi_gpio_0]

set_property name TEST_LED [get_bd_intf_ports gpio_rtl]

startgroup
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:bram_rtl:1.0 BRAM_PORTA
set_property CONFIG.MASTER_TYPE [get_property CONFIG.MASTER_TYPE [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA]] [get_bd_intf_ports BRAM_PORTA]
connect_bd_intf_net [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_ports BRAM_PORTA]
endgroup

startgroup
create_bd_port -dir O -from 0 -to 0 ENET0_GMII_TX_EN
connect_bd_net [get_bd_pins /processing_system7_0/ENET0_GMII_TX_EN] [get_bd_ports ENET0_GMII_TX_EN]
endgroup

startgroup
create_bd_port -dir O -from 0 -to 0 ENET0_GMII_TX_ER
connect_bd_net [get_bd_pins /processing_system7_0/ENET0_GMII_TX_ER] [get_bd_ports ENET0_GMII_TX_ER]
endgroup

startgroup
create_bd_port -dir O -from 7 -to 0 ENET0_GMII_TXD
connect_bd_net [get_bd_pins /processing_system7_0/ENET0_GMII_TXD] [get_bd_ports ENET0_GMII_TXD]
endgroup

startgroup
create_bd_port -dir I ENET0_GMII_RX_CLK
connect_bd_net [get_bd_pins /processing_system7_0/ENET0_GMII_RX_CLK] [get_bd_ports ENET0_GMII_RX_CLK]
endgroup

startgroup
create_bd_port -dir I ENET0_GMII_RX_DV
connect_bd_net [get_bd_pins /processing_system7_0/ENET0_GMII_RX_DV] [get_bd_ports ENET0_GMII_RX_DV]
endgroup
startgroup
create_bd_port -dir I ENET0_GMII_RX_ER
connect_bd_net [get_bd_pins /processing_system7_0/ENET0_GMII_RX_ER] [get_bd_ports ENET0_GMII_RX_ER]
endgroup
startgroup
create_bd_port -dir I ENET0_GMII_TX_CLK
connect_bd_net [get_bd_pins /processing_system7_0/ENET0_GMII_TX_CLK] [get_bd_ports ENET0_GMII_TX_CLK]
endgroup
startgroup
create_bd_port -dir I -from 7 -to 0 ENET0_GMII_RXD
connect_bd_net [get_bd_pins /processing_system7_0/ENET0_GMII_RXD] [get_bd_ports ENET0_GMII_RXD]
endgroup
startgroup
create_bd_port -dir O ENET0_MDIO_MDC
connect_bd_net [get_bd_pins /processing_system7_0/ENET0_MDIO_MDC] [get_bd_ports ENET0_MDIO_MDC]
endgroup
startgroup
create_bd_port -dir O ENET0_MDIO_O
connect_bd_net [get_bd_pins /processing_system7_0/ENET0_MDIO_O] [get_bd_ports ENET0_MDIO_O]
endgroup
startgroup
create_bd_port -dir O ENET0_MDIO_T
connect_bd_net [get_bd_pins /processing_system7_0/ENET0_MDIO_T] [get_bd_ports ENET0_MDIO_T]
endgroup
startgroup
create_bd_port -dir I ENET0_MDIO_I
connect_bd_net [get_bd_pins /processing_system7_0/ENET0_MDIO_I] [get_bd_ports ENET0_MDIO_I]
endgroup

regenerate_bd_layout
save_bd_design
generate_target all [get_files  R7MS.srcs/sources_1/bd/miniarm/miniarm.bd]
make_wrapper -files [get_files R7MS.srcs/sources_1/bd/miniarm/miniarm.bd] -top
add_files -norecurse R7MS.srcs/sources_1/bd/miniarm/hdl/miniarm_wrapper.vhd

create_ip -name clk_wiz -vendor xilinx.com -library ip -version 5.1 -module_name clk_wiz_0
set_property -dict [list CONFIG.PRIM_IN_FREQ {25} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {125.000} CONFIG.CLKIN1_JITTER_PS {400.0} CONFIG.MMCM_CLKFBOUT_MULT_F {40.000} CONFIG.MMCM_CLKIN1_PERIOD {40.0} CONFIG.MMCM_CLKOUT0_DIVIDE_F {8.000} CONFIG.CLKOUT1_JITTER {220.126} CONFIG.CLKOUT1_PHASE_ERROR {237.727}] [get_ips clk_wiz_0]
generate_target {instantiation_template} [get_files R7MS.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci]
update_compile_order -fileset sources_1
generate_target all [get_files R7MS.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci]
create_ip_run [get_files -of_objects [get_fileset sources_1] R7MS.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci]
launch_run  clk_wiz_0_synth_1

import_files -norecurse src/R7MS_top.vhd
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
