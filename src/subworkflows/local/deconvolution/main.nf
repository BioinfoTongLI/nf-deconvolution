include { CONVERTTOTIF } from '../../../modules/local/converttotif/main'
include { DWBW } from '../../../modules/local/dwbw/main'
include { DW_GPU; DW_CPU } from '../../../modules/local/dw/main'
include { CONVERTTOOMEZARR } from '../../../modules/local/converttoomezarr/main'

workflow DECONWOLF_DECONVOLUTION {
    take:
    input_files

    main:
    converted_tif = CONVERTTOTIF(input_files)
    psf = DWBW(converted_tif.converted_tif)

    gpu = DW_GPU(psf.psf)

    psf.psf
        .join(gpu.deconvolved_tif, remainder: true)
        .filter { item -> item[3] == null }
        .map { tuple(it[0], it[1], it[2]) }
        .set { failed_gpu }

    cpu = DW_CPU(failed_gpu)

    gpu.deconvolved_tif
        .mix(cpu.deconvolved_tif)
        .set { deconvolved_tif }

    deconvolved_tif
        .join(input_files)
        .map { it -> tuple(it[0], it[3], it[1], it[2]) }
        .set { convert_input }

    converted = CONVERTTOOMEZARR(convert_input)

    emit:
    deconvolved_images = converted.deconvolved
}
