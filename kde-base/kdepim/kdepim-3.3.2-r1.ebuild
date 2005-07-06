# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.3.2-r1.ebuild,v 1.3 2005/07/06 12:59:40 greg_g Exp $

inherit kde-dist eutils

DESCRIPTION="KDE PIM (Personal Information Management) apps: korganizer, kmail, knode..."

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc x86"
IUSE="crypt gnokii pda cjk"

DEPEND=">=kde-base/kdebase-3.3.0
	pda? ( app-pda/pilot-link dev-libs/libmal )
	gnokii? ( app-mobilephone/gnokii )
	crypt? ( >=app-crypt/gpgme-0.9.0-r1 )"

src_unpack() {
	kde_src_unpack
	cd ${S}
	epatch ${FILESDIR}/kdepim-3.3.2-kmail-imap-preview.diff
	use cjk && epatch ${FILESDIR}/kdepim-3.2.3-cjk.diff
}
