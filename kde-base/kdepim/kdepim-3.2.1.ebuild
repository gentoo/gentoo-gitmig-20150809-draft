# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.2.1.ebuild,v 1.11 2004/08/30 15:45:01 pvdabeel Exp $

inherit kde-dist eutils

DESCRIPTION="KDE PIM (Personal Information Management) apps: korganizer, kmail, knode..."

KEYWORDS="x86 ppc sparc ~alpha hppa amd64 ~ia64"
IUSE="pda crypt ldap"

DEPEND="~kde-base/kdenetwork-${PV}
	pda? ( app-pda/pilot-link dev-libs/libmal )
	ldap? ( net-nds/openldap )
	crypt? ( app-crypt/cryptplug app-crypt/gnupg )"

src_unpack() {
	kde_src_unpack
	cd ${S}
	epatch ${FILESDIR}/kpilot-parallel-make-fix.patch
	aclocal
}

src_compile() {
	use pda && myconf="$myconf --with-extra-includes=/usr/include/libpisock"
	kde_src_compile
}

src_install() {
	kde_src_install
	docinto html
	dodoc *.html
}
