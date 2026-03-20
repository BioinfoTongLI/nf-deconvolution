process CONVERTTOTIF {

    tag "${meta.image_id}"

    label 'deconvolution_preprocess'

    container 'registry.git.embl.org/felix.schneider1/podmanimages/deconwolf:0.4.6_py'

    input:
    tuple val(meta), path(image)

    output:
    tuple val(meta), path('ConvertedTif.tif'), emit: converted_tif

    script:
    """
    convert_to_tif.py --file ${image} --channel_index ${meta.channel_index}
    """
}

