# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@intphsys.com>

S=${WORKDIR}/dcd-0.90
SRC_URI="http://www.technopagan.org/dcd/dcd-0.90.tar.bz2"

HOMEPAGE="http://www.technopagan.org/dcd"

DESCRIPTION="A simple command-line based CD Player"

DEPEND=">=sys-libs/glibc-2.1.3"

src_unpack() {

    unpack ${A}
    cd ${S}
    cat Makefile | sed "s:PREFIX = .*$:PREFIX = \"${D}/usr\":" |\
    sed "s:# CDROM = /dev/cdroms/cdrom0:CDROM = \"/dev/cdroms/cdrom0\":"\
    > Makefile
   
}
 
src_compile() {

    try make

}

src_install() {

    try make PREFIX=${D}/usr install
    dodoc README BUGS

}
