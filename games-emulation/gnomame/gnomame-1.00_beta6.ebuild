# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gnomame/gnomame-1.00_beta6.ebuild,v 1.3 2004/02/20 06:26:47 mr_bones_ Exp $

MY_P="${P/_beta/b}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="GTK+ xmame catalog and frontend"
SRC_URI="http://gnomame.sourceforge.net/files/${MY_P}.tar.gz"
HOMEPAGE="http://gnomame.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND="=x11-libs/gtk+-1.2*
	media-libs/gdk-pixbuf
	games-emulation/xmame"

src_compile() {
	econf || die
	emake || die "emake failed"
}
src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog README || die "dodoc failed"
}
