# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.3.2.ebuild,v 1.1 2004/12/09 01:56:03 caleb Exp $

inherit kde-dist eutils

DESCRIPTION="KDE PIM (Personal Information Management) apps: korganizer, kmail, knode..."

KEYWORDS="~amd64 ~hppa ~sparc ~x86 ~ppc ~alpha ~ppc64"
IUSE="crypt gnokii pda cjk"

DEPEND=">=kde-base/kdebase-3.3.0
	pda? ( app-pda/pilot-link dev-libs/libmal )
	gnokii? ( net-dialup/gnokii )
	crypt? ( >=app-crypt/gpgme-0.9.0-r1 )"

src_unpack() {
	kde_src_unpack
	cd ${S}
	use cjk && epatch ${FILESDIR}/kdepim-3.2.3-cjk.diff
}
