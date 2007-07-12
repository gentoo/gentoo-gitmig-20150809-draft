# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kmess/kmess-1.3.ebuild,v 1.11 2007/07/12 05:34:47 mr_bones_ Exp $

inherit kde eutils

DESCRIPTION="MSN Messenger clone for KDE"
HOMEPAGE="http://www.kmess.org"
SRC_URI="mirror://sourceforge/kmess/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~ppc"
IUSE=""

DEPEND="|| ( kde-base/kdenetwork-meta kde-base/kdenetwork )"
need-kde 3

src_unpack() {
	kde_src_unpack

	epatch ${FILESDIR}/${P}-compilation-fix.patch
}
