# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/mozplugger/mozplugger-1.14.0.ebuild,v 1.1 2010/07/21 00:16:28 chutzpah Exp $

EAPI=2
inherit nsplugins toolchain-funcs

DESCRIPTION="Streaming media plugin for Mozilla, based on netscape-plugger"
SRC_URI="http://mozplugger.mozdev.org/files/${P}.tar.gz"
HOMEPAGE="http://mozplugger.mozdev.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}
	net-libs/xulrunner:1.9"

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		LD="$(tc-getCC)" \
		RPM_OPT_FLAGS="${CFLAGS}" \
		XCFLAGS="-fPIC -Wall" \
		COMMON_LDFLAGS="${LDFLAGS}" \
		all || die
}

src_install() {
	emake root="${D}" install || die
	src_mv_plugins /usr/lib/mozilla/plugins
	dodoc ChangeLog README
}
