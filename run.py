regression_folders = [
    "Linear_Regression/LinReg_no_quantization", 
    "Linear_Regression/LinReg_quantization",
    "Logistic_Regression/LogReg_no_quantization",
    "Logistic_Regression/LogReg_quantization"
]

from glob import glob
import os
import sys
from tqdm import tqdm

lists = []
for idx, folder in enumerate(regression_folders):
    suffix = "LRGD" if (idx < 2) else "LogReg"
    for file in glob(os.path.join("/root/dev/pim-ml", folder) + "/*/*.py"):
        lists.append(f"cd {os.path.dirname(file)} && python3 {os.path.basename(file)} {suffix} 2> /dev/nullß")

for cmd in tqdm(lists):
    os.system(cmd)

