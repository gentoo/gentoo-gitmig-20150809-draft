# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellsun/gkrellsun-0.12.1.ebuild,v 1.4 2005/04/01 19:18:47 agriffis Exp $

IUSE=""
DESCRIPTION="A GKrellM plugin that shows sunrise and sunset times."
HOMEPAGE="http://gkrellsun.sourceforge.net/"
SRC_URI="mirror://sourceforge/gkrellsun/${P}.tar.gz"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="~x86 ppc ~sparc ~alpha ~hppa ~amd64 ia64"

DEPEND="=app-admin/gkrellm-2*
	>=media-libs/imlib-1.9.10-r1"

src_compile() {
	cd ${S}/src20
	emake || die
}

src_install () {
	dodoc README AUTHORS COPYING

	cd ${S}/src20
	insinto /usr/lib/gkrellm2/plugins
	doins gkrellsun.so
}
