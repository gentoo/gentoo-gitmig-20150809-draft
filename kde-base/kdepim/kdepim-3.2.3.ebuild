# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.2.3.ebuild,v 1.5 2004/07/21 20:55:09 caleb Exp $

inherit kde-dist

DESCRIPTION="KDE PIM (Personal Information Management) apps: korganizer, kmail, knode..."

KEYWORDS="x86 ~ppc ~amd64 ~sparc"
IUSE="pda crypt ldap"

DEPEND="~kde-base/kdenetwork-${PV}
	pda? ( app-pda/pilot-link dev-libs/libmal )
	ldap? ( net-nds/openldap )
	crypt? ( app-crypt/cryptplug app-crypt/gnupg )"

src_unpack() {
	kde_src_unpack
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
