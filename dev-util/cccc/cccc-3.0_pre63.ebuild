
IUSE=""
DESCRIPTION="A code counter for C and C++."
MY_PV="${PV/0_}"
S="${WORKDIR}/${PN}-${MY_PV}"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://cccc.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
DEPEND=""

src_compile() {
    cd ${S}
    make pccts cccc test
}

src_install () {
    cd install
    mkdir ${D}/usr
    make -f install.mak INSTDIR="${D}/usr/bin"	
    cd ${S}
    dodoc readme.txt changes.txt
}
