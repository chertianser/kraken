#!/bin/bash
#SBATCH --nodes=1
#SBATCH --partition=cpunodes
#SBATCH --ntasks=48
#SBATCH --mem=370000M
##SBATCH --time=24:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=serchertian@gmail.com
##SBATCH -o kraken_$1.log
#SBATCH --job-name $idx

cd $SLURM_SUBMIT_DIR

idx=$1
shift 1

source /opt/intel/oneapi/setvars.sh
source /opt/python/3.8a/bin/activate
conda activate morfeus

module load openmpi/4.1.1
module load gaussian/16C01
source ~/xtb_6.2.2/share/xtb/config_env.bash
export OMP_STACKSIZE=350G

export OMP_NUM_THREADS=48
export MKL_NUM_THREADS=2

ulimit -s unlimited

#python3 run_kraken.py -idx $idx input_3D_conversion.csv Ni
python3 run_kraken.py -idx $idx input_3D_conversion.csv noNi
