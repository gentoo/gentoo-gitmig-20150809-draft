# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.4.1-r2.ebuild,v 1.1 2005/07/01 00:56:23 carlo Exp $

inherit kde-dist eutils

DESCRIPTION="KDE PIM (Personal Information Management) apps: korganizer, kmail, knode..."

KEYWORDS="~x86 ~amd64 ~sparc ~ppc ~ia64"
IUSE="crypt gnokii pda"

DEPEND="~kde-base/kdebase-${PV}
	>=dev-libs/cyrus-sasl-2
	pda? ( app-pda/pilot-link dev-libs/libmal )
	gnokii? ( app-mobilephone/gnokii )
	crypt? ( >=app-crypt/gpgme-0.9.0-r1 )
	!net-www/akregator"

src_unpack() {
	kde_src_unpack

	# Last minute fix. Applied for 3.4.2.
	epatch "${FILESDIR}/${P}-kpilot-fix.patch"

	# Fix regression in akregator (kde bug 106345). Applied for 3.4.2.
	epatch "${FILESDIR}/${P}-akregator-unread.patch"

	# see bug 97549
	epatch "${FILESDIR}/kmail-3.4.1-shift+click-crash.diff"
}

src_compile() {
	# needed to detect pi-notepad.h, used by the kpilot notepad conduit.
	use pda && myconf="${myconf} --with-extra-includes=/usr/include/libpisock"

	kde_src_compile
}
