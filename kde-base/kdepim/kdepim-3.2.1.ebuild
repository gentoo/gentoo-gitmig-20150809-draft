# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.2.1.ebuild,v 1.3 2004/03/10 03:23:53 caleb Exp $

inherit kde-dist

DESCRIPTION="KDE PIM (Personal Information Management) apps: korganizer, kmail, knode..."

KEYWORDS="~x86 ~ppc ~sparc ~hppa ~amd64 ~alpha ~ia64"
IUSE="pda crypt ldap"

DEPEND="~kde-base/kdenetwork-${PV}
	pda? ( app-pda/pilot-link dev-libs/libmal )
	ldap? ( net-nds/openldap )
	crypt? ( app-crypt/cryptplug app-crypt/gnupg )"

src_unpack() {
	kde_src_unpack
	cd ${S} && epatch ${FILESDIR}/kpilot-parallel-make-fix.patch
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
