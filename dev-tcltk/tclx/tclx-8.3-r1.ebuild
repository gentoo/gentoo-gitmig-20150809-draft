# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclx/tclx-8.3-r1.ebuild,v 1.2 2003/05/05 16:42:03 utx Exp $

inherit flag-o-matic

IUSE="X"

DESCRIPTION="A set of extensions to TCL"
HOMEPAGE="http://www.neosoft.com/TclX/"
SRC_URI="ftp://ftp.slackware.com/pub/slackware/slackware-8.1/source/tcl/tclx/${PN}${PV}.tar.gz 
	ftp://ftp.scriptics.com/pub/tcl/tcl8_4/tcl8.4.2-src.tar.gz 
	ftp://ftp.scriptics.com/pub/tcl/tcl8_4/tk8.4.2-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"

DEPEND=">=dev-lang/tcl-8.4.2
	X? >=dev-lang/tk-8.4.2"

S=${WORKDIR}/${PN}${PV}

[ $ARCH = alpha ] && append-flags -fPIC

src_unpack() {
	ewarn ""
	ewarn "Your compile WILL fail if you are upgrading from"
	ewarn "a previous version of tclx."
	ewarn ""
	ewarn "emerge unmerge tclx"
	ewarn "BEFORE upgrading to a newer version"
	ewarn ""
	ewarn "You have been warned :)"
	ewarn ""
	sleep 5

	unpack ${A} ; cd ${S}
	patch -p1 < ${FILESDIR}/${P}-makecfg.patch || die
	patch -p1 < ${FILESDIR}/${P}-argv.patch || die
	patch -p1 < ${FILESDIR}/${P}-varinit.patch || die
}

src_compile() {
	# we have to configure and build tcl before we can do tclx
	cd ${WORKDIR}/tcl8.4.2/unix
	econf
	emake CFLAGS="${CFLAGS}" || die "emake in tcl/unix failed"

	local myconf="--with-tcl=${WORKDIR}/tcl8.4.2/unix --enable-shared"

	if [ `use X` ] ; then
		# configure and build tk
		cd ${WORKDIR}/tk8.4.2/unix
		econf
		emake CFLAGS="${CFLAGS}" || die
		myconf="${myconf} --with-tk=${WORKDIR}/tk8.4.2/unix"
	else
		myconf="${myconf} --enable-tk=no"
	fi

	# configure and build tclx
	cd ${S}/unix
	econf ${myconf}
	make CFLAGS="${CFLAGS}" || die
}

src_install() {
	echo "installing tclx"
	cd ${S}/unix
	make INSTALL_ROOT=${D} install
	cd ${S}
	dodoc CHANGES README TO-DO doc/CONVERSION-NOTES
	doman doc/*.[n3]
}
