# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/ding/ding-1.2.ebuild,v 1.4 2003/07/11 20:35:22 aliz Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Tk based dictionary (German-English) (incl. dictionary itself)"
SRC_URI="http://cgi.tu-chemnitz.de/ftp-home/pub/Local/urz/ding/${P}.tar.gz"
HOMEPAGE="http://www-user.tu-chemnitz.de/~fri/ding/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc "

RDEPEND=">=dev-lang/tk-8*
	>=sys-apps/grep-2*"
DEPEND="${RDEPEND}"

src_install() {
  	exeinto /usr/bin
	doexe ding
	insinto /usr/share/dict
	doins ger-eng.txt
	insinto /usr/share/pixmaps
	doins dbook.xpm
	doins mini-dbook.xpm
	doman ding.1
	dodoc CHANGES
	dodoc COPYING
	dodoc README
	dodoc ding.wmconfig
}
