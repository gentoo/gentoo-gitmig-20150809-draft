# Author Matthew Turk <m-turk@nwu.edu>
# An ebuild calling this class can cd to the appropriate
# directory and call latex-package_src_doinstall all, or leave
# the src_install function as-is if the system is single-directory.

inherit base
ECLASS=latex-package
INHERITED="$INHERITED $ECLASS"

newdepend ">=app-text/tetex-1.0.7"

HOMEPAGE="http://www.tug.org/"
SRC_URI="ftp://tug.ctan.org/macros/latex/"
S=${WORKDIR}/${P}
TEXMF="/usr/share/texmf"
SUPPLIER="misc" # This refers to the font supplier; it should be overridden

latex-package_src_doinstall() {
    debug-print function $FUNCNAME $*
    # This actually follows the directions for a "single-user" system
    # at http://www.ctan.org/installationadvice/ modified for gentoo.
    [ -z "$1" ] && latex-package_src_install all
 
    while [ "$1" ]; do
        case $1 in
            "sh")
                for i in `find . -maxdepth 1 -name "*.${1}"`
                do
                    dobin $i
                done
                ;;
            "sty" | "cls" | "fd")
                for i in `find . -maxdepth 1 -name "*.${1}"`
                do
                    insinto ${TEXMF}/tex/latex/${PN}
                    doins $i
                done
                ;;
            "dvi" | "ps" | "pdf" | "tex")
                for i in `find . -maxdepth 1 -name "*.${1}"`
                do
                    insinto ${TEXMF}/doc/latex/${PN}
                    doins $i
                done
                ;;
            "tfm" | "vf" | "afm" | "pfb")
                for i in `find . -maxdepth 1 -name "*.${1}"`
                do
                    insinto ${TEXMF}/fonts/${1}/${SUPPLIER}/${PN}
                    doins $i
                done
                ;;
            "ttf")
                for i in `find . -maxdepth 1 -name "*.ttf"`
                do
                    insinto ${TEXMF}/fonts/truetype/${SUPPLIER}/${PN}
                    doins $i
                done
                ;;
            "styles")
                latex-package_src_doinstall sty cls fd
                ;;
            "doc")
                latex-package_src_doinstall dvi ps pdf tex
                ;;
            "fonts")
                latex-package_src_doinstall tfm vg afm pfb ttf
                ;;
            "bin")
                latex-package_src_doinstall sh
                ;;
            "all")
                latex-package_src_doinstall styles doc fonts bin
                ;;
        esac
    shift
    done
}

latex-package_src_compile() {
    debug-print function $FUNCNAME $*
    cd ${S}
    for i in `find \`pwd\` -maxdepth 1 -name "*.ins"`
    do
        echo "Extracting from $i"
        latex --interaction=batchmode $i > /dev/null
    done
    for i in `find \`pwd\` -maxdepth 1 -name "*.dtx"`
    do
        echo "Extracting from $i"
        latex --interaction=batchmode $i > /dev/null
    done
}

latex-package_src_install() {
    debug-print function $FUNCNAME $*
    cd ${S}
    latex-package_src_doinstall all
}

latex-package_pkg_postinst() {
    debug-print function $FUNCNAME $*
    latex-package_rehash
    if [ ! -e ${TEXMF}/doc/latex/${PN} ] ; then return ; fi
    cd ${TEXMF}/doc/latex/${PN}
    latex-package_make_documentation
}

latex-package_pkg_postrm() {
    debug-print function $FUNCNAME $*
    # This may be a bit harsh, so perhaps it should be overridden.
    latex-package_rehash
    if [ ! -e ${TEXMF}/doc/latex/${PN} ] ; then return ; fi
    echo "Removing stale documentation: ${TEXMF}/doc/latex/${PN}"
    rm -rf ${TEXMF}/doc/latex/${PN}
}

latex-package_rehash() {
    debug-print function $FUNCNAME $*
    texconfig rehash
}

latex-package_make_documentation() {
    debug-print function $FUNCNAME $*
    # This has to come after the installation of all our files.
    # All errors will be discarded.
    for i in `find \`pwd\` -maxdepth 1 -name "*.tex"`
    do
        # Note - we rerun twice to get references properly.
        echo "Making Documentation: $i"
        latex --interaction=batchmode $i > /dev/null
    done
    echo "Completed."
}

EXPORT_FUNCTIONS src_compile src_install pkg_postinst pkg_postrm
