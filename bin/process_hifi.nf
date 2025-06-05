process get_reads {
// given a directory, get all the fastq.gz files in the directory

input: 
path reads_dir

output:
path read_files_cleaned

script:
"""
mkdir read_files_cleaned
ls -1 ${reads_dir}/*.gz | while read line; do ln -s \$line read_files_cleaned/; done
"""

}
