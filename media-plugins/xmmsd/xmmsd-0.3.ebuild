# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmmsd/xmmsd-0.3.ebuild,v 1.1 2004/07/26 07:47:13 eradicator Exp $

IUSE=""

DESCRIPTION="Web interface for controlling xmms"
HOMEPAGE="http://xmmsd.sourceforge.net/"
LICENSE="GPL-2"

DEPEND="media-sound/xmms
	=dev-libs/glib-1*
	=x11-libs/gtk+-1*"

SLOT="0"
#-sparc: 0.3: enabling plugin causes xmms to segfault
KEYWORDS="x86 ~amd64 -sparc"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="nomirror"

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	einstall XMMS_GENERAL_PLUGIN_DIR=${D}/usr/lib/xmms/General || die

	dodoc AUTHORS COPYING ChangeLog HACKING INSTALL NEWS \
		README README.libtaglist THANKS TODO
}
