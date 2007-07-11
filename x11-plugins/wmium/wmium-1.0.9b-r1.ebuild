# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmium/wmium-1.0.9b-r1.ebuild,v 1.3 2007/07/11 20:39:22 mr_bones_ Exp $

IUSE="gtk"

DESCRIPTION="WindowMaker DockApp/Grellm2 plugin that fetches the DSL usage information for Australian ISP Internode"
HOMEPAGE="http://www.earthmagic.org/?software"
SRC_URI="http://www.earthmagic.org/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/libc
	dev-libs/openssl
	gtk? (
		>=x11-libs/gtk+-2
		=app-admin/gkrellm-2*
		dev-util/pkgconfig
	)
	( || (
	( >=x11-libs/libX11-1.0.0
	>=x11-libs/libXext-1.0.0
	>=x11-libs/libXpm-3.5.4.2
	>=x11-proto/xextproto-7.0.2 )
	virtual/x11 )
	)"

RDEPEND="virtual/libc
	dev-libs/openssl
	gtk? (
		>=x11-libs/gtk+-2
		=app-admin/gkrellm-2*
	)
	!gtk? ( x11-wm/windowmaker )
	( || (
	( >=x11-libs/libX11-1.0.0
	>=x11-libs/libXext-1.0.0
	>=x11-libs/libXpm-3.5.4.2
	>=x11-proto/xextproto-7.0.2 )
	virtual/x11 )
	)"

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
