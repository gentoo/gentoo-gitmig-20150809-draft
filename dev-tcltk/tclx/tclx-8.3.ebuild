# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclx/tclx-8.3.ebuild,v 1.1 2002/08/15 00:23:58 aliz Exp $

DESCRIPTION="A set of extensions to TCL oriented towards common
UNIX/Linux programming tasks.  TclX enhances Tcl support for files,
network access, debugging, math, lists, and message catalogs, provides
additional interfaces to the native operating system, as well as many
new programming constructs, text manipulation tools, and debugging
capabilities"

HOMEPAGE="http://www.neosoft.com/TclX/"
SRC_URI="ftp://ftp.slackware.com/pub/slackware/slackware-8.1/source/tcl/tclx/${PN}${PV}.tar.gz 
	ftp://ftp.scriptics.com/pub/tcl/tcl8_3/tcl8.3.3.tar.gz 
	ftp://ftp.scriptics.com/pub/tcl/tcl8_3/tk8.3.3.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
DEPEND="=dev-lang/tk-8.3* 
	=dev-lang/tcl-8.3*"
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

	# configure and build tk
	cd ${WORKDIR}/tk8.3.3/unix
	./configure --host=${CHOST} \
                --prefix=/usr \
                --mandir=/usr/share/man \
                || die
	emake CFLAGS="${CFLAGS}" || die
	
	# configure and build tclx
	cd ${S}/unix
	./configure \
		--with-tcl=${WORKDIR}/tcl8.3.3/unix \
		--with-tk=${WORKDIR}/tk8.3.3/unix \
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

