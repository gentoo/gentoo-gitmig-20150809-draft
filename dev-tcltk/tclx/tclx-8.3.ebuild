# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclx/tclx-8.3.ebuild,v 1.2 2002/08/16 21:48:13 george Exp $

DESCRIPTION="A set of extensions to TCL"

HOMEPAGE="http://www.neosoft.com/TclX/"
SRC_URI="ftp://ftp.slackware.com/pub/slackware/slackware-8.1/source/tcl/tclx/${PN}${PV}.tar.gz 
	ftp://ftp.scriptics.com/pub/tcl/tcl8_3/tcl8.3.3.tar.gz 
	ftp://ftp.scriptics.com/pub/tcl/tcl8_3/tk8.3.3.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

DEPEND="=dev-lang/tcl-8.3*
	X? =dev-lang/tk-8.3*"
RDEPEND=${DEPEND}
S=${WORKDIR}/${PN}${PV}

src_unpack() {
	unpack ${A} ; cd ${S}
	patch -p1 < ${FILESDIR}/${P}-makecfg.patch || die
	patch -p1 < ${FILESDIR}/${P}-argv.patch || die
	patch -p1 < ${FILESDIR}/${P}-varinit.patch || die
}

src_compile() {
	# we have to configure and build tcl before we can do tclx
	cd ${WORKDIR}/tcl8.3.3/unix
	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		|| die
	emake CFLAGS="${CFLAGS}" || die

	use X && ( \
		# configure and build tk
		cd ${WORKDIR}/tk8.3.3/unix
		./configure --host=${CHOST} \
			--prefix=/usr \
			--mandir=/usr/share/man \
			|| die
		emake CFLAGS="${CFLAGS}" || die
	)

	use X && myconf="--with-tk=${WORKDIR}/tk8.3.3/unix" || myconf="--enable-tk=no"

	# configure and build tclx
	cd ${S}/unix
	./configure \
		--with-tcl=${WORKDIR}/tcl8.3.3/unix \
		${myconf} \
		--enable-shared \
		--host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		|| die "./configure failed"
	make CFLAGS="${CFLAGS}" || die
}

src_install () {
	echo "installing tclx"
	cd ${S}/unix
	make INSTALL_ROOT=${D} install
	cd ${S}
	dodoc CHANGES README TO-DO doc/CONVERSION-NOTES
	doman doc/*.[n3]
}

