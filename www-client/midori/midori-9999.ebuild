# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/midori/midori-9999.ebuild,v 1.6 2008/08/22 14:17:53 jokey Exp $

inherit git eutils

DESCRIPTION="A lightweight web browser"
HOMEPAGE="http://www.twotoasts.de/index.php?/pages/midori_summary.html"
EGIT_REPO_URI="git://git.xfce.org/kalikiana/midori"
EGIT_PROJECT="midori"
EGIT_BOOTSTRAP="NOCONFIGURE=1 ./autogen.sh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="x11-libs/gtk+
	x11-libs/libsexy
	net-libs/webkit-gtk"

pkg_setup() {
	ewarn "Note: this software is not yet in a too mature status so expect some minor things to break"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."

	dodoc AUTHORS ChangeLog INSTALL TODO
}
