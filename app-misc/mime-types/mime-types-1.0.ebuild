# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mime-types/mime-types-1.0.ebuild,v 1.10 2004/07/31 01:58:14 tgall Exp $

DESCRIPTION="Provides mime.types file"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc alpha ppc amd64 ia64 hppa ppc64"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	insinto /etc
	doins mime.types
}
