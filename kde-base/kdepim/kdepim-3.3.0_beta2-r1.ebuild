# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.3.0_beta2-r1.ebuild,v 1.1 2004/07/29 03:01:42 caleb Exp $

inherit kde-dist

DESCRIPTION="KDE PIM (Personal Information Management) apps: korganizer, kmail, knode..."

KEYWORDS="~x86 ~amd64"
IUSE="pda crypt"

DEPEND="pda? ( app-pda/pilot-link dev-libs/libmal )
	crypt? ( || ( >=app-crypt/gpgme-0.4.0 app-crypt/gnupg ) )"

