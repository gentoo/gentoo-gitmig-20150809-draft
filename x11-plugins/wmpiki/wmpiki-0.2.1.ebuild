# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpiki/wmpiki-0.2.1.ebuild,v 1.7 2007/07/22 04:39:17 dberkholz Exp $

inherit eutils

IUSE=""

DESCRIPTION="Wmpiki is a dockapp which checks and displays small leds for indicate hosts activity."
HOMEPAGE="http://clay.ll.pl/projects.html#dockapps"
SRC_URI="http://clay.ll.pl/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

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
