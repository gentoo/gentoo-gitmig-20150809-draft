# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmium/wmium-1.0.7.ebuild,v 1.1 2004/02/07 04:27:40 port001 Exp $

DESCRIPTION="WindowMaker DockApp/Grellm2 pluggin that fetches the DSL usage information for Australian ISP Internode"

HOMEPAGE="http://www.earthmagic.org/?software"

SRC_URI="http://www.earthmagic.org/files/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE="gtk"

DEPEND="virtual/glibc
	x11-base/xfree
	media-libs/xpm
	dev-libs/openssl
	gtk? ( >=x11-libs/gtk+-2* )
	gtk? ( app-admin/gkrellm )
	gtk? ( dev-util/pkgconfig )"

RDEPEND="virtual/glibc
	x11-base/xfree
	media-libs/xpm
	dev-libs/openssl
	gtk? ( >=x11-libs/gtk+-2* )
	gtk? ( app-admin/gkrellm )
	!gtk? ( x11-wm/windowmaker )"

S=${WORKDIR}/${P}

src_compile() {

	emake build || die "Cannot make ${P}"
	use gtk && emake build-gk2
}

src_install() {

	if [ `use gtk` ]; then
		exeinto /usr/lib/gkrellm2/plugins
		doexe src-gk2/wmium-gk2.so
	fi

	dobin src/wmium

	dodoc BUGS INSTALL-GK2  README dot.wmiumrc.sample \
		CHANGES  INSTALL README-GK2

	doman src/wmium.1

	einfo ""
	einfo "To configure look at the /usr/share/doc/${PF}/dot.wmiumrc.sample"
	einfo "(if using /usr/bin/wmium with WINDOWMAKER ONLY)"
	einfo ""
	einfo " or use the preferences within gkrellm"
}

