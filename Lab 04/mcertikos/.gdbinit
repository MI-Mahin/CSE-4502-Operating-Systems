set $lastcs = -1

define hook-stop
  # There doesn't seem to be a good way to detect if we're in 16- or
  # 32-bit mode, but we always run with CS == 8 in 32-bit mode.
  if $cs == 8 || $cs == 27
    if $lastcs != 8 && $lastcs != 27
      set architecture i386
    end
    x/i $pc
  else
    if $lastcs == -1 || $lastcs == 8 || $lastcs == 27
      set architecture i8086
    end
    # Translate the segment:offset into a physical address
    printf "[%4x:%4x] ", $cs, $eip
    x/i $cs*16+$eip
  end
  set $lastcs = $cs
end

echo + symbol-file obj/kern/kernel\n
file obj/kern/kernel

add-symbol-file obj/boot/boot0.elf 0x7c00
add-symbol-file obj/boot/boot1.elf 0x7e00
add-symbol-file obj/kern/kernel 0x100000

echo + target remote localhost:26000\n
target remote localhost:26000

layout asm
winheight asm 50

layout reg
winheight reg 8

focus cmd
