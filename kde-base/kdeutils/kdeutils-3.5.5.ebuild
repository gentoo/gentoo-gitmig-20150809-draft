# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.5.5.ebuild,v 1.13 2007/07/11 01:08:48 mr_bones_ Exp $

inherit kde-dist eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdeutils-3.5-patchset-01.tar.bz2"

DESCRIPTION="KDE utilities."

KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE="crypt kdehiddenvisibility pbbuttonsd snmp"

BOTH_DEPEND="~kde-base/kdebase-${PV}
	snmp? ( net-analyzer/net-snmp )
	pbbuttonsd? ( app-laptop/pbbuttonsd )
	dev-lang/python
	dev-libs/gmp
	|| ( x11-libs/libXtst <virtual/x11-7 )"

RDEPEND="${BOTH_DEPEND}
	crypt? ( app-crypt/gnupg )
	!x11-misc/superkaramba"

DEPEND="${BOTH_DEPEND}
	|| ( (
			x11-libs/libX11
			x11-proto/xproto
		) <virtual/x11-7 )
	virtual/os-headers"

src_unpack() {
	kde_src_unpack
	sed -i -e "s:Hidden=true:Hidden=false:" ksim/ksim.desktop || die "sed failed"
}

src_compile() {
	local myconf="$(use_with snmp) $(use_with pbbuttonsd powerbook)
				  --without-xmms"

	use crypt || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kgpg"

	kde_src_compile
}

src_install() {
	kde_src_install
	# see bug 144731
	rm ${D}${KDEDIR}/share/applications/kde/ksim.desktop
}
