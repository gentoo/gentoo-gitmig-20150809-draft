# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gnomame/gnomame-1.00_beta6.ebuild,v 1.7 2004/11/05 04:46:11 josejx Exp $

MY_P="${P/_beta/b}"
DESCRIPTION="GTK+ xmame catalog and frontend"
SRC_URI="http://gnomame.sourceforge.net/files/${MY_P}.tar.gz"
HOMEPAGE="http://gnomame.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	media-libs/gdk-pixbuf
	games-emulation/xmame"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf || die
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog README || die "dodoc failed"
}
