# kharon-boards/zephyr/CMakeLists.txt
#
# 这个文件的存在唯一目的：把 `<module>/include/` 挂到全局 include 路径。
#
# 为什么非要有它（2026-11-21 方案 ③ 第 2 关实测）：
#   `dts_root` 只让 **DTS 预处理** 看到 `<root>/include`（见 pre_dt.cmake），
#   **C 编译** 不吃这套。而上游 pr-s31 把 S31 的 bindings 头加在
#   `zephyr/include/zephyr/dt-bindings/...`，HAL 源码里是这么用的：
#       #include <zephyr/dt-bindings/clock/esp32s31_clock.h>
#   主树（main）没有这些头，我们把它们放在 `<module>/include/zephyr/dt-bindings/`，
#   于是必须由 module 的 CMake 把 `<module>/include` 加进 include 路径，
#   编译 `modules/hal/espressif/.../periph_ctrl.c` 时才找得到。
#
# 副作用评估：只多一个 `-I <module>/include`，里面只有 5 个 Espressif 专用的
#   dt-bindings 头（esp32s31_clock / esp-esp32s31-intmux / esp32s31-pinctrl /
#   esp32s31-gpio-sigmap / esp-pinctrl-common 副本），对 STM32 / S3 构建无影响。
zephyr_include_directories(${CMAKE_CURRENT_LIST_DIR}/../include)
