# Copyrigth 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <hallski@gentoo.org>
# Maintainer: Desktop Team
# $Header: /var/cvsroot/gentoo-x86/x11-misc/x11fonts-jmk/x11fonts-jmk-3.0.ebuild,v 1.1 2001/09/12 11:30:17 hallski Exp $

A=jmk-x11-fonts-3.0.tar.gz
S=${WORKDIR}/jmk-x11-fonts-3.0
DESCRIPTION="X11 Application Launch Feedback"
SRC_URI="http://www.ntrnet.net/~jmknoble/fonts/${A}"
HOMEPAGE="http://www.ntrnet.net/~jmknoble/fonts/"

DEPEND="virtual/x11"

src_compile() {
	xmkmf || die

	emake || die
}

src_install() {
	make install INSTALL_DIR='${D}/usr/X11R6/lib/X11/fonts/jmk' || die

	dodoc README NEWS
}
