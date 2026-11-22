# SPDX-License-Identifier: Apache-2.0
#
# 探针是 DAP-Link（CMSIS-DAP），openocd 的 interface/target 由
# packs/.../stm32f103c8t6_bluepill.yaml 指向本板 support/openocd.cfg。
# jlink 仅作备用；默认烧录走 openocd。

board_runner_args(jlink "--device=STM32F103C8" "--speed=4000")

include(${ZEPHYR_BASE}/boards/common/openocd.board.cmake)
include(${ZEPHYR_BASE}/boards/common/jlink.board.cmake)
