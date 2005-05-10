# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/mountapp/mountapp-3.0.ebuild,v 1.9 2005/05/10 14:27:33 s4t4n Exp $

DESCRIPTION="mount filesystems via an easy-to-use windowmaker applet"
HOMEPAGE="http://mountapp.sourceforge.net"
SRC_URI="http://mountapp.sourceforge.net/mountapp-3.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"

IUSE=""

DEPEND="virtual/libc
	=x11-libs/gtk+-1.2*
	>=x11-wm/windowmaker-0.80"

src_compile() {

	econf || die "configure failed"

	emake || die "parallel make failed"

}

src_install() {

	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README* THANKS TODO

}
