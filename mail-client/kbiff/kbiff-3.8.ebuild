# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/kbiff/kbiff-3.8.ebuild,v 1.6 2008/02/19 01:33:46 ingmar Exp $

inherit kde eutils

DESCRIPTION="KDE new mail notification utility (biff)"
HOMEPAGE="http://www.granroth.org/kbiff/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="|| ( =kde-base/kdelibs-3.5* =kde-base/kdebase-3.5* )"
need-kde 3

src_unpack() {
	kde_src_unpack

	use arts || epatch "${FILESDIR}"/${PN}-3.7.1-configure-arts.patch
}
