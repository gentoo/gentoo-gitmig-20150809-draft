# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/tbass/tbass-20030725.3.3.ebuild,v 1.3 2003/09/11 01:02:54 msterret Exp $

IUSE=""

Name="balsa"
My_PV="3.3"
#quite custom anyway, this one has version number at the end
#to indicate it is a release

DESCRIPTION="Balsa is both a framework for synthesising asynchronous hardware systems and the language for describing such systems"
HOMEPAGE="http://www.cs.man.ac.uk/amulet/projects/balsa/"
SRC_URI="ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/${My_PV}/${Name}-${My_PV}.tar.gz
	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/${My_PV}/balsa-manual-${My_PV}.pdf
	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/${My_PV}/${Name}-tech-example-${My_PV}.tar.gz
	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/examples/dma-example.tar.gz
	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/examples/examples.tar.gz
	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/snapshots/${Name}-tech-verilog-20030204.tar.gz
	ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/snapshots/${Name}-tech-xilinx-20021029.tar.gz"
	#ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/${My_PV}/${Name}-lard-${My_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc "

DEPEND="virtual/glibc
	sys-devel/binutils
	dev-libs/gmp
	dev-lang/perl
	x11-libs/gtk+"
	#>=app-sci/lard-2.0.15"

RDEPEND="${DEPEND}
	dev-util/guile
	media-gfx/graphviz
	app-sci/gtkwave
	app-sci/espresso-ab"

S=${WORKDIR}/${Name}-${My_PV}

if [ -f ${DISTDIR}/balsa-tech-ams-20030506.tar.gz ]; then
TECH_AMS=1
fi

src_unpack() {
	unpack ${A}
	if [ $TECH_AMS ]; then unpack balsa-tech-ams-20030506.tar.gz; fi
	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/${P}-tech-verilog-configure.patch || die
	patch -p0 < ${FILESDIR}/${P}-tech-xilinx-configure.patch || die
	patch -p0 < ${FILESDIR}/${P}-tech-example-configure.patch || die
	#patch -p0 < ${FILESDIR}/${P}-balsa-lard-configure.patch || die
	#echo "patching file balsa-lard-${PV}/bin/Makefile.in"
	#sed -i -e "s: \$(bindir): \$(DESTDIR)\$(bindir):g" ${WORKDIR}/balsa-lard-${PV}/bin/Makefile.in
}

src_compile() {
	# compile balsa
	econf
	sed -i -e "s: \$(bindir): \$(DESTDIR)\$(bindir):g" bin/Makefile
	emake BALSAHOME=${S} || die

	# configure tech paths
	if [ $TECH_AMS ]; then
	cd ${WORKDIR}/balsa-tech-ams-20030506
	econf
	fi

	# config generic verilog backend
	cd ${WORKDIR}/balsa-tech-verilog-20030204
	econf

	# config Xilinx FPGA backend
	cd ${WORKDIR}/balsa-tech-xilinx-20021029
	econf

	# config example tech
	cd ${WORKDIR}/balsa-tech-example-${My_PV}
	econf

	# config balsa-lard (deprecated, but may find some use for it)
	#cd ${WORKDIR}/balsa-lard-${PV}
	#econf
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
	dodoc ${DISTDIR}/balsa-manual-${My_PV}.pdf

	# install tech
	if [ $TECH_AMS ]; then
	cd ${WORKDIR}/balsa-tech-ams-20030506
	make DESTDIR=${D} install || die "make install failed"
	fi

	cd ${WORKDIR}/balsa-tech-verilog-20030204
	make DESTDIR=${D} install || die "make install failed"

	cd ${WORKDIR}/balsa-tech-xilinx-20021029
	make DESTDIR=${D} install || die "make install failed"

	cd ${WORKDIR}/balsa-tech-example-${My_PV}
	make DESTDIR=${D} install || die "make install failed"

	cd ${S}
	dodoc AUTHORS COPYING NEWS README TODO

	# balsa-lard has been split from balsa .. requires working balsa
	# install for compile. Paths need fixing to compile in sandbox.
	# Even with paths fixed I get errors like:
	# find-filename: cannot open block with dotted path `[balsa.types.synthesis]'
	#
	# Lets just ignore the problem and hope it goes away.
	#
	#cd ${WORKDIR}/balsa-lard-${PV}
	# hack - imports come from hard coded path, we set this
	# for install,
	#echo "patching ${WORKDIR}/balsa-lard-${PV}/share/scheme/base-local.scm"
	#sed -i -e "s:/usr/share/scheme/:${D}/usr/share/scheme/:g" share/scheme/base-local.scm
	#make DESTDIR=${D} install || die "make install failed"
}

pkg_postinst() {
	if [ ! $TECH_AMS ]; then
	einfo "The AMS035 tech library was *not* installed."
	einfo "It is no longer publically distributed."
	einfo "If you have the appropriate license from AMS request"
	einfo "the ${Name}-tech-ams-20030506.tar.gz file"
	einfo "directly from the Balsa developers and add it to "
	einfo "/usr/portage/distfiles before emerging."
	else
	einfo "The AMS035 tech library was found and installed."
	fi
	einfo ""
	einfo "The Balsa-Lard interface has been deprecated and is no longer installed."
	einfo "If you need it you must manually download and install it."
	einfo ""
}
