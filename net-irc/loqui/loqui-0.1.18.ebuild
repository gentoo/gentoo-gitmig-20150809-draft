# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/loqui/loqui-0.1.18.ebuild,v 1.2 2004/02/05 22:50:58 zul Exp $

DESCRIPTION="Loqui is a graphical IRC client for GNOME2 on UNIX like operating system."
SRC_URI="http://loqui.good-day.net/src/${P}.tar.gz"
HOMEPAGE="http://loqui.good-day.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"

RDEPEND=">=dev-libs/glib-2.2.1
	>=x11-libs/gtk+-2.2.1
	>=net-libs/gnet-2.0.3"
DEPEND=">=dev-libs/glib-2.2.1
	>=x11-libs/gtk+-2.2.1
	>=net-libs/gnet-2.0.3
	nls? ( sys-devel/gettext )"

src_compile() {
	econf `use_enable nls`|| die "Configure failed"
	emake || die "Compile failed"
}

src_install() {
	einstall install || die "Install failed"
	dodoc COPYING ChangeLog README
}
