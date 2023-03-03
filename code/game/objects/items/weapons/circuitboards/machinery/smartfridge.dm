/obj/item/electronics/circuitboard/smartfridge
    name = T_BOARD("smartfridge")
    build_path = /obj/machinery/smartfridge
    board_type = "machine"
    origin_tech = list(TECH_DATA = 2)
    req_components = list(
    	/obj/item/stock_parts/matter_bin = 1,
    	/obj/item/stock_parts/manipulator = 1,
    	/obj/item/stock_parts/console_screen = 1
    )

/obj/item/electronics/circuitboard/smartfridge/disk
    name = T_BOARD("disk storage")
    build_path = /obj/machinery/smartfridge/disk