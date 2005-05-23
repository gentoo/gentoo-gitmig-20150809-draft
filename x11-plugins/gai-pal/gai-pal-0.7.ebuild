# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gai-pal/gai-pal-0.7.ebuild,v 1.1 2005/05/23 09:28:37 s4t4n Exp $

DESCRIPTION="A friend that always has something wise or funny to say ;-)"
HOMEPAGE="http://gai.sf.net"
SRC_URI="mirror://sourceforge/gai/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=x11-libs/gai-0.5.6
	dev-util/pkgconfig"

src_compile()
{
	econf || die "Configuration failed..."
	emake || die "Compilation failed..."
}

src_install()
{
	make DESTDIR=${D} install || die "Installation failed..."
}
