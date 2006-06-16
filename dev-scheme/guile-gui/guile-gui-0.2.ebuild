# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/guile-gui/guile-gui-0.2.ebuild,v 1.1 2006/06/16 22:07:18 spyderous Exp $

DESCRIPTION="Guile Scheme code that aims to implement a graphical user interface"
HOMEPAGE="http://www.ossau.uklinux.net/guile/"
SRC_URI="http://www.ossau.uklinux.net/guile/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND="dev-util/guile"
DEPEND="${RDEPEND}"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc ${S}/README
}
