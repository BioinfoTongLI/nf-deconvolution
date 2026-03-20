#!/usr/bin/env nextflow
nextflow.enable.dsl=2

// Load subworkflows
include { DECONWOLF_DECONVOLUTION } from './subworkflows/local/deconvolution/main'



workflow {

        channel.fromPath(params.input, checkIfExists:true)
                .splitCsv(header:true)
                .map { row -> tuple(['image_id': row.image_id,'emission':row.emission,
                                'channel_index':row.channel_index], 
                                file(row.path,checkIfExists:true)) }
                .set { input_files }

        deconvolution = DECONWOLF_DECONVOLUTION(input_files)

        deconvolved_images = deconvolution.deconvolved_images
                        
}
