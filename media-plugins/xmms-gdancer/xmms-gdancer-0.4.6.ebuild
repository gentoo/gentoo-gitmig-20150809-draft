# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-gdancer/xmms-gdancer-0.4.6.ebuild,v 1.8 2004/11/27 20:24:25 corsair Exp $

IUSE=""

MY_P=${P/xmms-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Dancing character plugin for XMMS"
HOMEPAGE="http://figz.com/gdancer/"
SRC_URI="http://figz.com/gdancer/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64 sparc ~ppc64"

DEPEND="media-sound/xmms"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README README.themes TODO
}

pkg_postinst() {
	einfo "Themes can be found at:"
	einfo "http://figz.com/gdancer/themes.php"
}
