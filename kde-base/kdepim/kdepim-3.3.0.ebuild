# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.3.0.ebuild,v 1.7 2004/09/15 02:33:12 weeve Exp $

inherit kde-dist eutils

DESCRIPTION="KDE PIM (Personal Information Management) apps: korganizer, kmail, knode..."

KEYWORDS="x86 ~amd64 ppc64 sparc ppc"
IUSE="pda crypt"

DEPEND="pda? ( app-pda/pilot-link dev-libs/libmal )
	crypt? ( >=app-crypt/gpgme-0.4.0 )"
#	crypt? ( >=app-crypt/gpgme-0.4.5 )"

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/kdepim-3.3.0-korganizer.patch
}

src_compile() {
	use crypt && export GPGME_CONFIG="/usr/bin/gpgme4-config"
	kde_src_compile
}
