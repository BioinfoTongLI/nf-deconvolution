process CONVERTTOOMEZARR {

    tag "${meta.image_id}"

    label 'deconvolution_postprocess'

    container 'registry.git.embl.org/felix.schneider1/podmanimages/deconwolf:0.4.6_py'

    input:
    tuple val(meta), path(image), path(converted_tif), path(deconvolved_tif)

    output:
    tuple val(meta), path('*_deconvolved.ome.zarr'), emit: deconvolved

    script:
    def args3 = task.ext.args3 ?: ''
    """
    convert_to_omezarr.py --file ${image} --file_deconvolved ${deconvolved_tif} ${args3}
    """
}
