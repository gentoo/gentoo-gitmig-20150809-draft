# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/tbass/tbass-20030108.ebuild,v 1.4 2003/07/02 12:33:39 aliz Exp $

IUSE=""

Name="balsa"

DESCRIPTION="Balsa is both a framework for synthesising asynchronous hardware systems and the language for describing such systems"
HOMEPAGE="http://www.cs.man.ac.uk/amulet/projects/balsa/"
SRC_URI="ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/snapshots/${Name}-${PV}.tar.gz
	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/docs/balsa-manual.pdf
	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/examples/dma-example.tar.gz
	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/examples/examples.tar.gz
	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/snapshots/${Name}-tech-ams-20020402.tar.gz
	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/snapshots/${Name}-tech-verilog-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc "

DEPEND="virtual/glibc
	sys-devel/binutils
	>=app-sci/lard-20030109
	dev-libs/gmp
	dev-lang/perl
	x11-libs/gtk+"

RDEPEND="${DEPEND}
	dev-util/guile
	media-gfx/graphviz"

S=${WORKDIR}/${Name}-${PV}

src_unpack() {
	unpack ${Name}-${PV}.tar.gz dma-example.tar.gz examples.tar.gz ${Name}-tech-ams-20020402.tar.gz ${Name}-tech-verilog-${PV}.tar.gz
}

src_compile() {
	# compile balsa
	econf

	cd bin
	sed -e "s: \$(bindir): \$(DESTDIR)\$(bindir):g" Makefile > Makefile.1
	cp Makefile.1 Makefile
	emake || die

	# configure tech paths
	cd ${WORKDIR}/balsa-tech-ams-1.0
	econf

	cd ${WORKDIR}/balsa-tech-verilog-1.0
	econf
}

src_install() {
	# install balsa
	einstall || die "make install failed"

	# move the docs to the right directory
	dodoc ${D}/usr/doc/*
	rm -rf ${D}/usr/doc

	# install manual and examples
	dodir /usr/share/doc/${P}/examples/dma-example
	cp -R ${WORKDIR}/dma-example ${D}/usr/share/doc/${P}/examples
	cp -R ${WORKDIR}/examples/* ${D}/usr/share/doc/${P}/examples
	dodoc ${DISTDIR}/balsa-manual.pdf

	# install tech
	cd ${WORKDIR}/balsa-tech-ams-1.0
	make DESTDIR=${D} install || die "make install failed"

	cd ${WORKDIR}/balsa-tech-verilog-1.0
	make DESTDIR=${D} install || die "make install failed"
}
