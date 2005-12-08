# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.5.0-r3.ebuild,v 1.1 2005/12/08 00:03:59 greg_g Exp $

inherit kde-dist

DESCRIPTION="KDE PIM (Personal Information Management) apps: korganizer, kmail, knode..."

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="crypt gnokii pda"

DEPEND="~kde-base/kdebase-${PV}
	>=dev-libs/cyrus-sasl-2
	pda? ( app-pda/pilot-link dev-libs/libmal )
	gnokii? ( app-mobilephone/gnokii )
	crypt? ( >=app-crypt/gpgme-0.9.0-r1 )"

src_unpack() {
	kde_src_unpack

	# Fix crash when applying filters (kde bug 113730). applied for 3.5.1.
	epatch "${FILESDIR}/${P}-kmail-branch.patch"
}

src_compile() {
	local myconf="--with-sasl $(use_with gnokii)"

	kde_src_compile
}
