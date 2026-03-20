process DW_GPU {

    tag "${meta.image_id}"

    label 'deconvolution_gpu'

    container 'registry.git.embl.org/felix.schneider1/podmanimages/deconwolf:0.4.6_py'

    input:
    tuple val(meta), path(converted_tif), path(psf)

    output:
    tuple val(meta), path(converted_tif), path('dw_ConvertedTif.tif'), emit: deconvolved_tif, optional: true

    script:
    def args2 = task.ext.args2 ?: ''
    """
    export XDG_CONFIG_HOME=\$PWD/.config
    mkdir -p \$XDG_CONFIG_HOME/deconwolf

    dw --gpu ${args2} --float --overwrite --tempdir \$PWD --out \$PWD ${converted_tif} ${psf}
    """
}

process DW_CPU {

    tag "${meta.image_id}"

    label 'deconvolution_cpu'

    container 'registry.git.embl.org/felix.schneider1/podmanimages/deconwolf:0.4.6_py'

    input:
    tuple val(meta), path(converted_tif), path(psf)

    output:
    tuple val(meta), path(converted_tif), path('dw_ConvertedTif.tif'), emit: deconvolved_tif

    script:
    def args2 = task.ext.args2 ?: ''
    """
    export XDG_CONFIG_HOME=\$PWD/.config
    mkdir -p \$XDG_CONFIG_HOME/deconwolf

    dw ${args2} --float --overwrite --tempdir \$PWD --out \$PWD ${converted_tif} ${psf}
    """
}

