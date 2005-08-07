# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gnomame/gnomame-1.00_beta6.ebuild,v 1.9 2005/08/07 13:07:50 hansmi Exp $

MY_P="${P/_beta/b}"
DESCRIPTION="GTK+ xmame catalog and frontend"
HOMEPAGE="http://gnomame.sourceforge.net/"
SRC_URI="http://gnomame.sourceforge.net/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	media-libs/gdk-pixbuf
	games-emulation/xmame"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf || die
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog README || die "dodoc failed"
}
