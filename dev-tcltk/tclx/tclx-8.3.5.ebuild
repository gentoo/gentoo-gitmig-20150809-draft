# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclx/tclx-8.3.5.ebuild,v 1.6 2004/10/19 10:01:00 absinthe Exp $

inherit flag-o-matic eutils

IUSE="X"

DESCRIPTION="A set of extensions to TCL"
HOMEPAGE="http://tclx.sourceforge.net"
SRC_URI="mirror://sourceforge/tclx/${PN}${PV}-src.tar.gz
	ftp://ftp.scriptics.com/pub/tcl/tcl8_4/tcl8.4.6-src.tar.gz
	ftp://ftp.scriptics.com/pub/tcl/tcl8_4/tk8.4.6-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc ~alpha ~amd64"

DEPEND=">=sys-apps/sed-4
	>=dev-lang/tcl-8.4.6
	X? >=dev-lang/tk-8.4.6"

S=${WORKDIR}/${PN}${PV}

# Not necessary ! see BUG #55238
# Danny van Dyk <kugelfang@gentoo.org> 2004/08/30
# [ $ARCH = alpha ] && append-flags -fPIC
# [ "${ARCH}" = "amd64" ] && append-flags -fPIC

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${PN}-8.3-varinit.patch

	sed -i \
		-e "/^TCLX_INST_MAN/ s:=.*:= \$\{TCLX_PREFIX\}/share/man:" \
		-e "" "${S}/unix/Common.mk.in" \
			|| die "sed Makefile failed"
}

src_compile() {
	# we have to configure and build tcl before we can do tclx
	cd ${WORKDIR}/tcl8.4.6/unix
	econf || die "econf failed"
	emake CFLAGS="${CFLAGS}" || die "emake in tcl/unix failed"

	local myconf="--with-tcl=${WORKDIR}/tcl8.4.6/unix --enable-shared"

	if use X ; then
		# configure and build tk
		cd ${WORKDIR}/tk8.4.6/unix
		econf || die "econf failed"
		emake CFLAGS="${CFLAGS}" || die
		myconf="${myconf} --with-tk=${WORKDIR}/tk8.4.6/unix"
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

