# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.2.0_beta2.ebuild,v 1.3 2003/12/28 03:45:05 caleb Exp $
inherit kde-dist

IUSE="pda crypt ldap"
DESCRIPTION="KDE PIM (Personal Information Management) apps: korganizer, kmail, knode..."
KEYWORDS="~x86"

DEPEND="~kde-base/kdenetwork-${PV}
	pda? ( app-pda/pilot-link dev-libs/libmal )
	ldap? ( net-nds/openldap )
	crypt? ( app-crypt/cryptplug app-crypt/gnupg )"
RDEPEND="$DEPEND"

use pda && myconf="$myconf --with-extra-includes=/usr/include/libpisock"

src_install() {
	kde_src_install
	docinto html
	dodoc *.html
}
