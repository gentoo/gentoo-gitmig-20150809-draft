# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xine-vcdx/xine-vcdx-1_rc1.ebuild,v 1.5 2005/02/02 21:50:41 luckyduck Exp $

IUSE=""

MY_P=${PN}-${PV/_/-}
DESCRIPTION="Navigation-Capable (S)VCD Plugin for Xine movie player."
HOMEPAGE="http://xine.sourceforge.net/"
SRC_URI="mirror://sourceforge/xine/${MY_P}.tar.gz"
LICENSE="GPL-2"
RESTRICT="nomirror"

DEPEND=">=media-libs/xine-lib-1_rc1
	>=media-video/vcdimager-0.7.19"

SLOT="0"
KEYWORDS="~x86"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} \
		docdir=/usr/share/doc/${PF} \
		docsdir=/usr/share/doc/${PF} \
		install || die

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO
}
