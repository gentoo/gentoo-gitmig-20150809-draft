# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/tbass/tbass-20030204.ebuild,v 1.1 2003/04/24 07:45:35 george Exp $

IUSE=""

Name="balsa"

DESCRIPTION="Balsa is both a framework for synthesising asynchronous hardware systems and the language for describing such systems"
HOMEPAGE="http://www.cs.man.ac.uk/amulet/projects/balsa/"
SRC_URI="ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/snapshots/${Name}-${PV}.tar.gz
	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/docs/balsa-manual-20030120.pdf
	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/examples/dma-example.tar.gz
	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/examples/examples.tar.gz
	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/snapshots/${Name}-tech-verilog-${PV}.tar.gz
	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/snapshots/${Name}-tech-xilinx-20021029.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc "

DEPEND="sys-devel/binutils
	>=app-sci/lard-20030204
	dev-libs/gmp
	dev-lang/perl
	x11-libs/gtk+"

RDEPEND="${DEPEND}
	dev-util/guile
	media-gfx/graphviz
	app-sci/gtkwave
	app-sci/espresso-ab"

S=${WORKDIR}/${Name}-${PV}

if [ -f ${DISTDIR}/balsa-tech-ams-20030314.tar.gz ]; then
TECH_AMS=1
fi

src_unpack() {
	unpack ${Name}-${PV}.tar.gz dma-example.tar.gz examples.tar.gz ${Name}-tech-verilog-${PV}.tar.gz ${Name}-tech-xilinx-20021029.tar.gz
	if [ $TECH_AMS ]; then unpack balsa-tech-ams-20030314.tar.gz; fi
	cd ${WORKDIR}/balsa-tech-verilog-${PV}
	patch -p1 < ${FILESDIR}/${P}-tech-verilog-configure.patch || die
	cd ${WORKDIR}/balsa-tech-xilinx-20021029
	patch -p1 < ${FILESDIR}/${P}-tech-xilinx-configure.patch || die
}

src_compile() {
	# compile balsa
	econf

	cd bin
	sed -e "s: \$(bindir): \$(DESTDIR)\$(bindir):g" Makefile > Makefile.1
	cp Makefile.1 Makefile
	emake || die

	# configure tech paths
	if [ $TECH_AMS ]; then
	cd ${WORKDIR}/balsa-tech-ams-20030314
	econf
	fi

	cd ${WORKDIR}/balsa-tech-verilog-${PV}
	econf

	cd ${WORKDIR}/balsa-tech-xilinx-20021029
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
	dodoc ${DISTDIR}/balsa-manual-20030120.pdf

	# install tech
	if [ $TECH_AMS ]; then
	cd ${WORKDIR}/balsa-tech-ams-20030314
	make DESTDIR=${D} install || die "make install failed"
	fi

	cd ${WORKDIR}/balsa-tech-verilog-${PV}
	make DESTDIR=${D} install || die "make install failed"

	cd ${WORKDIR}/balsa-tech-xilinx-20021029
	make DESTDIR=${D} install || die "make install failed"

}

pkg_postinst() {
	if [ ! $TECH_AMS ]; then
	einfo "The AMS035 tech library is no longer distributed publically."
	einfo "To obtain it you must have the appropriate license from AMS."
	einfo "If you do, request the ${Name}-tech-ams-20030314.tar.gz file"
	einfo "directly from the Balsa developers and add it to "
	einfo "/usr/portage/distfiles before emerging."
	echo
	fi
}
