# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mvc/mvc-0.8.7.ebuild,v 1.2 2005/07/28 10:44:32 dholm Exp $

DESCRIPTION="Motion Video Capture, text mode v4l video capture program with motion detection feature"
HOMEPAGE="http://modesto.sourceforge.net/piave/index.html"
MY_P="${P}"
SRC_URI="http://www.turbolinux.com.cn/~merlin/mvc/${MY_P}.tar.gz"

IUSE="nls"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:prefix=/usr:prefix=${D}/usr:" Makefile || die "Could not fix install path"
}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO
}
