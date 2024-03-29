#!/usr/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=8 --mem 16G
#SBATCH --output=logs/annot.funannot_03.%A.log
#SBATCH --time=6-0:00:00
#SBATCH -p batch -J annotfunc
module load funannotate
module load phobius
CPUS=$SLURM_CPUS_ON_NODE

if [ ! $CPUS ]; then
 CPUS=1
fi

if [ ! -f config.txt ]; then
 echo "need a config file for parameters"
 exit
fi

source config.txt
if [ ! $BUSCO ]; then
 BUSCO=fungi_odb9
fi
if [ ! $ODIR ]; then
 ODIR=$(basename `pwd`).'funannot'
fi
MOREFEATURE=""
if [ $TEMPLATE ]; then
 MOREFEATURE="--sbt $TEMPLATE"
fi
funannotate annotate --busco_db $BUSCO -i $ODIR --species "$SPECIES" --strain "$ISOLATE" --cpus $CPUS $EXTRAANNOT $MOREFEATURE
#~/src/funannotate/funannotate annotate --busco_db $BUSCO -i $ODIR --species "$SPECIES" --strain "$ISOLATE" --cpus $CPUS $EXTRAANNOT $MOREFEATURE
