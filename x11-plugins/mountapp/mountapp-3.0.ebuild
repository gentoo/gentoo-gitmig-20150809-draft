# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/mountapp/mountapp-3.0.ebuild,v 1.1 2002/12/09 08:08:19 raker Exp $

DESCRIPTION="mount filesystems via an easy-to-use windowmaker applet"
HOMEPAGE="http://mountapp.sourceforge.net"
SRC_URI="http://mountapp.sourceforge.net/mountapp-3.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND="virtual/glibc
	>=x11-wm/WindowMaker-0.80"

S=${WORKDIR}/${P}

src_compile() {

	econf || die "configure failed"

	emake || die "parallel make failed"

}

src_install() {

	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README* THANKS TODO

}
