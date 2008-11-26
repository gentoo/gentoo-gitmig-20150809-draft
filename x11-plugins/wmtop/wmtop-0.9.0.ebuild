# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmtop/wmtop-0.9.0.ebuild,v 1.4 2008/11/26 00:05:59 tcunha Exp $

inherit multilib toolchain-funcs

DESCRIPTION="dockapp for monitoring the top three processes using cpu or memory."
HOMEPAGE="http://www.swanson.ukfsn.org/#wmtop"
SRC_URI="http://www.swanson.ukfsn.org/wmdock/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto"

src_compile() {
	emake CC="$(tc-getCC)" OPTS="${CFLAGS}" \
		LIBDIR="-L/usr/$(get_libdir)" \
		INCS="-I/usr/include/X11" linux || die "emake failed."
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc BUGS CHANGES README TODO
}
