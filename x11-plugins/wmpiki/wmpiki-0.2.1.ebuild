# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpiki/wmpiki-0.2.1.ebuild,v 1.6 2006/01/31 20:12:48 nelchael Exp $

inherit eutils

IUSE=""

DESCRIPTION="Wmpiki is a dockapp which checks and displays small leds for indicate hosts activity."
HOMEPAGE="http://clay.ll.pl/projects.html#dockapps"
SRC_URI="http://clay.ll.pl/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )"

src_compile()
{
	make CFLAGS="${CFLAGS}"|| die "Compilation failed"
}

src_install()
{
	dobin wmpiki
	dodoc AUTHORS ChangeLog README config.example
}

pkg_postinst()
{
	einfo "Don't forget to edit wmpiki configuration file:"
	einfo "~/.clay/wmpiki"
}
