# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmget/wmget-0.6.0.ebuild,v 1.6 2006/05/03 00:53:25 weeve Exp $

IUSE=""
DESCRIPTION="libcurl-based dockapp for automated-downloads"
HOMEPAGE="http://amtrickey.net/wmget/"
SRC_URI="http://amtrickey.net/download/${P}-src.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )
	>=net-misc/curl-7.9.7"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xproto
		x11-proto/xextproto )
	virtual/x11 )"

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
