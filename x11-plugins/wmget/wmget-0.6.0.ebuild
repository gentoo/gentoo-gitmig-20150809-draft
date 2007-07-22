# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmget/wmget-0.6.0.ebuild,v 1.7 2007/07/22 05:06:52 dberkholz Exp $

IUSE=""
DESCRIPTION="libcurl-based dockapp for automated-downloads"
HOMEPAGE="http://amtrickey.net/wmget/"
SRC_URI="http://amtrickey.net/download/${P}-src.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm
	>=net-misc/curl-7.9.7"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto"

S=${WORKDIR}/${PN}

src_compile()
{
	emake CFLAGS="${CFLAGS} -Wall -W -I/usr/X11R6/include" \
		|| die "parallel make failed"
}

src_install()
{
	dobin wmget
	doman wmget.1
	dodoc NEWS TODO README
}
