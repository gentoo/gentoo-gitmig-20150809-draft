# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.4.0_beta1.ebuild,v 1.1 2005/01/14 00:19:31 greg_g Exp $

inherit kde-dist

DESCRIPTION="KDE utilities"

KEYWORDS="~x86"
IUSE=""

DEPEND="~kde-base/kdebase-${PV}"

RDEPEND="${DEPEND}
	crypt? ( app-crypt/gnupg )"

src_compile() {
	use crypt || export DO_NOT_COMPILE="${DO_NOT_COMPILE} kgpg"

	kde_src_compile
}