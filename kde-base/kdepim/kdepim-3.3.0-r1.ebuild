# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.3.0-r1.ebuild,v 1.7 2004/11/07 15:02:52 usata Exp $

inherit kde-dist eutils

DESCRIPTION="KDE PIM (Personal Information Management) apps: korganizer, kmail, knode..."

KEYWORDS="~x86 ~amd64 ~ppc64 sparc ppc hppa"
IUSE="crypt gnokii pda cjk"

DEPEND="pda? ( app-pda/pilot-link dev-libs/libmal )
	gnokii? ( x86? ( net-dialup/gnokii ) )
	crypt? ( >=app-crypt/gpgme-0.9.0-r1 )"

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/kdepim-3.3.0-korganizer.patch
	epatch ${FILESDIR}/kdepim-3.3.0-spam-assistant.patch
	use cjk && epatch ${FILESDIR}/kdepim-3.2.3-cjk.diff
	make -f admin/Makefile.common
}
