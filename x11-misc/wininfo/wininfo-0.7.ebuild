# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wininfo/wininfo-0.7.ebuild,v 1.5 2005/07/26 15:03:35 dholm Exp $

IUSE=""

DESCRIPTION="An X app that follows your pointer providing information about the windows below"
HOMEPAGE="http://freedesktop.org/Software/wininfo"
SRC_URI="http://www.freedesktop.org/software/${PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~ppc x86"
DEPEND="virtual/x11
		>=x11-libs/gtk+-2"

src_install() {

	dobin src/wininfo

	newman wininfo.man wininfo.1
	dodoc ABOUT-NLS AUTHORS COPYING NEWS README INSTALL
}
