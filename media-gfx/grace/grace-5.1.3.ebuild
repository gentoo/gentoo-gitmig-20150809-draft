# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Grant Goodyear <g2boojum@hotmail.com>
# /home/cvsroot/gentoo-x86/skel.build,v 1.2 2001/02/15 18:17:31 achim Exp

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Grace is a WYSIWYG 2D plotting tool for the X Window System"
SRC_URI="ftp://plasma-gate.weizmann.ac.il/pub/grace/src/${A}"
HOMEPAGE="http://plasma-gate.weizmann.ac.il/Grace/"

DEPEND="virtual/glibc virtual/x11
	>=x11-libs/openmotif-2.1
	>=media-libs/libpng-0.96
	>=media-libs/tiff-3.5
	pdflib? ( >=media-libs/pdflib-3.0.2 )"
RDEPEND="virtual/glibc virtual/x11
	>=x11-libs/openmotif-2.1
	>=media-libs/libpng-0.96
	>=media-libs/jpeg-6
	pdflib? ( >=media-libs/pdflib-3.0.2 )"
src_compile() {

    if [ -z "`use pdflib`" ] ; then
	myconf="--disable-pdfdrv"
    fi
    try ./configure --with-grace-home=/opt/grace --host=${CHOST} ${myconf}
    try make

}

src_install () {

    try make GRACE_HOME=${D}/opt/grace install
    dodoc CHANGES COPYRIGHT ChangeLog DEVELOPERS LICENSE README
    cd doc
    doman *.1
    docinto html
    dodoc *.{html,jpg,png}
    docinto print
    dodoc *.dvi
    docinto sgml
    dodoc *.sgml
    docinto examples
    dodoc *.{dat,agr,sh}
    rm -rf ${D}/opt/grace/doc
    insinto /etc/env.d
    doins ${FILESDIR}/10grace


}


