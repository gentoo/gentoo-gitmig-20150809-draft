# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.3.0-r1.ebuild,v 1.1 2004/09/03 20:29:26 carlo Exp $

inherit kde-dist

DESCRIPTION="KDE PIM (Personal Information Management) apps: korganizer, kmail, knode..."

KEYWORDS="~x86 ~amd64 ~ppc64 ~sparc ~ppc"
IUSE="pda crypt"

DEPEND="pda? ( app-pda/pilot-link dev-libs/libmal )
	crypt? ( >=app-crypt/gpgme-0.9.0-r1 )"

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/${P}-spam-assistant.patch
}