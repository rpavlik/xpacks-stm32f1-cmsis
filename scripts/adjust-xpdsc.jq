# Apply f to composite entities recursively, and to atoms
def walk(f):
  . as $in
  | if type == "object" then
      reduce keys_unsorted[] as $key
        ( {}; . + { ($key):  ($in[$key] | walk(f)) } ) | f
  elif type == "array" then map( walk(f) ) | f
  else f
  end;

# Given an object with a "name" like e.g. STM32F103RB, return something like STM32F103xB
def computeDefine($child): $child | .name | sub("F1(?<num>..).(?<letter>.)$"; "F1\(.num)x\(.letter)");

# Swap out the stdperiph includes and defines with hal ones that match this layout.
def updateCompileInfo($child):
    $child |= . + {"compile":
        {
            "header" : "Drivers/CMSIS/Device/ST/STM32F1xx/Include/stm32f1xx.h",
            "define" : computeDefine($child)
        }};

walk(
    if type == "object" and (. | has("compile")) then
        # replace the stdperiph-based defines (and includes) with new ones
        . |= updateCompileInfo(.)
    else . end
) |
walk(
    if type == "object" and (. | has("svd")) then
        # Fix SVD paths to match current layout
        . |= (. + {"svd": "CMSIS/\(.svd)"})
    else . end
)