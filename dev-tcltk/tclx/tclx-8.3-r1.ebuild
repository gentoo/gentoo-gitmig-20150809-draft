# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclx/tclx-8.3-r1.ebuild,v 1.13 2004/09/06 00:57:13 ciaranm Exp $

inherit flag-o-matic eutils

IUSE="X"

DESCRIPTION="A set of extensions to TCL"
HOMEPAGE="http://www.neosoft.com/TclX/"
SRC_URI="ftp://ftp.slackware.com/pub/slackware/slackware-8.1/source/tcl/tclx/${PN}${PV}.tar.gz
	ftp://ftp.scriptics.com/pub/tcl/tcl8_4/tcl8.4.2-src.tar.gz
	ftp://ftp.scriptics.com/pub/tcl/tcl8_4/tk8.4.2-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha amd64 ~sparc"

DEPEND=">=dev-lang/tcl-8.4.2
	X? >=dev-lang/tk-8.4.2"

S=${WORKDIR}/${PN}${PV}

# Not necessary ! see BUG #55238
# Danny van Dyk <kugelfang@gentoo.org> 2004/08/30
# [ $ARCH = alpha ] && append-flags -fPIC
# [ "${ARCH}" = "amd64" ] && append-flags -fPIC

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
	epause 5

	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${P}-makecfg.patch
	epatch ${FILESDIR}/${P}-argv.patch
	epatch ${FILESDIR}/${P}-varinit.patch
}

src_compile() {
	# we have to configure and build tcl before we can do tclx
	cd ${WORKDIR}/tcl8.4.2/unix
	econf || die "econf failed"
	emake CFLAGS="${CFLAGS}" || die "emake in tcl/unix failed"

	local myconf="--with-tcl=${WORKDIR}/tcl8.4.2/unix --enable-shared"

	if use X ; then
		# configure and build tk
		cd ${WORKDIR}/tk8.4.2/unix
		econf || die "econf failed"
		emake CFLAGS="${CFLAGS}" || die
		myconf="${myconf} --with-tk=${WORKDIR}/tk8.4.2/unix"
	else
		myconf="${myconf} --enable-tk=no"
	fi

	# configure and build tclx
	cd ${S}/unix
	econf ${myconf} || die "econf failed"
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
