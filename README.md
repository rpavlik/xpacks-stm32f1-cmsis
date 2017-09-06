# STM32F1 CMSIS

This project, available from [GitHub](https://github.com/rpavlik/xpacks-stm32f1-hal),
includes the STM32F1 CMSIS files from the STM32Cube HAL distribution.

It also bundles the SVD and PDSC files from Keil.

## Version

* From STM32CubeMX HAL firmware bundle v1.6.0:
  * CMSIS Device Peripheral Access Layer v4.2.0
* From Keil device family pack v2.2.0 (see [Keil pack index](http://www.keil.com/dd2/pack/))
  * PDSC and SVD files
  * CMSIS drivers excluded because this DFP depends on the old STM stdperiph library, rather than the newer HAL.

## Documentation

The latest STM documentation is available from
[STM32CubeF1](http://www.st.com/en/embedded-software/stm32cubef1.html).

## Original files

The original files are available in the `originals` branch.

These files were extracted from `stm32cube_fw_f1_v160.zip`.

To save space, the following folders/files were removed:

* all non-portable *.exe files
* \_htmresc
* CMSIS/Flash
* CMSIS/Debug
* Documentation
* Drivers/BSP/
* Drivers/CMSIS/CMSIS?END*.*
* Drivers/CMSIS/index.html
* Drivers/CMSIS/README.txt
* Drivers/CMSIS/Documentation
* Drivers/CMSIS/DSP_Lib
* Drivers/CMSIS/Include
* Drivers/CMSIS/Lib
* Drivers/CMSIS/RTOS
* Drivers/CMSIS/SVD
* Drivers/STM32F?xx_HAL_Driver/
* MDK
* Middlewares
* Projects
* Utilities
* package.xml

The files in `CMSIS/SVD` and the `.pdsc` file were extracted from `Keil.STM32F1xx_DFP.2.2.0.pack`

## Changes

* none.

