# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/mozplugger/mozplugger-1.12.1.ebuild,v 1.2 2010/03/21 21:55:14 ssuominen Exp $

inherit nsplugins

DESCRIPTION="Streaming media plugin for Mozilla, based on netscape-plugger"
SRC_URI="http://mozplugger.mozdev.org/files/${P}.tar.gz"
HOMEPAGE="http://mozplugger.mozdev.org/"

KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~alpha"
LICENSE="GPL-2"

SLOT="0"
IUSE=""

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}
	net-libs/xulrunner"

src_compile() {
	emake linux || die
}

src_install() {
	emake root="${D}" install || die "install failed"
	src_mv_plugins /usr/lib/mozilla/plugins

	dodoc ChangeLog README || die "dodoc failed"
}
