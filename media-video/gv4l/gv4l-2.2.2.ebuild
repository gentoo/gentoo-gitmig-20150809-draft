# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gv4l/gv4l-2.2.2.ebuild,v 1.1 2004/04/20 22:54:37 kanaka Exp $

DESCRIPTION="Gv4l is a GUI frontend for the V4L functions of transcode"
HOMEPAGE="http://gv4l.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

IUSE="debug"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

S="${WORKDIR}/${P}"

DEPEND="virtual/x11
	>=media-video/transcode-0.6.7
	media-tv/xawtv"
# gtk and/or gnome is also required

src_compile() {
	cd ${S}
	econf ${myconf} || die "configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO
}
