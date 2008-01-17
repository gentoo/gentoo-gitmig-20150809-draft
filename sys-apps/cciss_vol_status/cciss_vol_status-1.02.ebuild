# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cciss_vol_status/cciss_vol_status-1.02.ebuild,v 1.3 2008/01/17 11:07:59 chainsaw Exp $

IUSE=""
DESCRIPTION="Shows status of logical drives attached to HP SmartArray controllers."
HOMEPAGE="http://cciss.sourceforge.net/#cciss_utils"
LICENSE="GPL-2"
SRC_URI="mirror://sourceforge/cciss/${P}.tar.gz"
KEYWORDS="~amd64 x86"
SLOT="0"
DEPEND=">=sys-devel/autoconf-2.59"

src_install() {
	emake DESTDIR="${D}" install || die "Install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
