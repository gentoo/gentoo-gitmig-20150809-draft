# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-gdancer/xmms-gdancer-0.4.5.ebuild,v 1.5 2003/02/13 13:02:18 vapier Exp $

MY_P=${P/xmms-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Dancing character plugin for XMMS"
HOMEPAGE="http://figz.com/gdancer/"
SRC_URI="http://figz.com/gdancer/files/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="media-sound/xmms
	=x11-libs/gtk+-1.2*"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}

pkg_postinst () {
	einfo "Themes can be found at:"
	einfo "http://figz.com/gdancer/themes.php"
}
