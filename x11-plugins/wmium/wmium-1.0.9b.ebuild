# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmium/wmium-1.0.9b.ebuild,v 1.2 2005/07/18 13:51:15 dragonheart Exp $

IUSE="gtk"

DESCRIPTION="WindowMaker DockApp/Grellm2 plugin that fetches the DSL usage information for Australian ISP Internode"
HOMEPAGE="http://www.earthmagic.org/?software"
SRC_URI="http://www.earthmagic.org/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
DEPEND="virtual/libc
	virtual/x11
	media-libs/xpm
	dev-libs/openssl
	gtk? (
		>=x11-libs/gtk+-2
		app-admin/gkrellm
		dev-util/pkgconfig
	)"

RDEPEND="virtual/libc
	virtual/x11
	media-libs/xpm
	dev-libs/openssl
	gtk? (
		>=x11-libs/gtk+-2
		app-admin/gkrellm
	)
	!gtk? ( x11-wm/windowmaker )"

src_compile() {
	emake build || die
	if use gtk; then
		emake build-gk2 || die
	fi
}

src_install() {
	if use gtk; then
		exeinto /usr/lib/gkrellm2/plugins
		doexe src-gk2/wmium-gk2.so
	fi

	dobin src/wmium

	dodoc BUGS INSTALL-GK2  README dot.wmiumrc.sample \
		CHANGES  INSTALL README-GK2

	doman src/wmium.1

	einfo
	einfo "To configure look at the /usr/share/doc/${PF}/dot.wmiumrc.sample"
	einfo "(if using /usr/bin/wmium with WINDOWMAKER ONLY)"
	einfo
	einfo "or use the preferences within gkrellm2"
}

