inherit latex-package

S="${WORKDIR}/cweb-sty-${PV}"
DESCRIPTION="LaTeX package for using LaTeX with CWEB"
SRC_URI="ftp://ftp.th-darmstadt.de//programming/literate-programming/c.c++/cweb-sty-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 mips"
PATCHES="${FILESDIR}/cweb.cls.patch"

# this package has a .tex file which needs to go with the cweb.sty
src_install() {
    cd ${S}
	latex-package_src_install
	insinto ${TEXMF}/tex/latex/${PN}
	doins cwebbase.tex
}
