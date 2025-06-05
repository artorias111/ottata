// import your modules

// purge_dups processes

include { get_reads } from './bin/process_hifi.nf'

include { purge_dups_mmp2;
        purge_dups_split_self_align;
        purge_dups_purge_haplotigs_overlaps;
        process_purged_seqs } from './bin/PurgeDups.nf'

workflow purge_dups {  // --mode purge_dups
    log.info "Running OTTATA in purge_dups mode"
    
    get_reads(params.hifi_reads)

    purge_dups_mmp2(get_reads.out, params.primary_asm)
    purge_dups_split_self_align(params.primary_asm)

    purge_dups_purge_haplotigs_overlaps(purge_dups_split_self_align.out, purge_dups_mmp2.out.pb_base_cov)
    process_purged_seqs(purge_dups_purge_haplotigs_overlaps.out, params.primary_asm)

 }

 workflow {
    if (params.mode == 'purge_dups') {
        purge_dups()
    }
 }
