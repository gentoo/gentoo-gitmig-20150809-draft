# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellkam/gkrellkam-2.0.0.ebuild,v 1.11 2005/03/25 16:43:09 kugelfang Exp $

MY_P=${P/-/_}
IUSE=""
DESCRIPTION="an Image-Watcher-Plugin for GKrellM2."
SRC_URI="mirror://sourceforge/gkrellkam/${MY_P}.tar.gz"
HOMEPAGE="http://gkrellkam.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64"

DEPEND="=app-admin/gkrellm-2*"

src_install () {
	exeinto /usr/lib/gkrellm2/plugins
	doexe gkrellkam2.so

	doman gkrellkam-list.5
	dodoc README Changelog COPYING example.list Release Todo INSTALL
}
