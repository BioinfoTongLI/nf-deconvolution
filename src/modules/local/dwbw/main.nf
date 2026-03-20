process DWBW {

    tag "${meta.image_id}"

    label 'deconvolution_preprocess'

    container 'registry.git.embl.org/felix.schneider1/podmanimages/deconwolf:0.4.6_py'

    input:
    tuple val(meta), path(converted_tif)

    output:
    tuple val(meta), path(converted_tif), path('PSF.tif'), emit: psf

    script:
    def args1 = task.ext.args1 ?: ''
    def args3 = task.ext.args3 ?: ''
    """
    export XDG_CONFIG_HOME=\$PWD/.config
    mkdir -p \$XDG_CONFIG_HOME/deconwolf

    dw_bw ${args1} ${args3} --lambda ${meta.emission} --overwrite PSF.tif
    """
}

