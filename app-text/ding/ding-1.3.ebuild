# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ding/ding-1.3.ebuild,v 1.1 2004/04/25 21:01:54 aliz Exp $

DESCRIPTION="Tk based dictionary (German-English) (incl. dictionary itself)"
HOMEPAGE="http://www-user.tu-chemnitz.de/~fri/ding/"
SRC_URI="http://wftp.tu-chemnitz.de/pub/Local/urz/ding/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

RDEPEND=">=dev-lang/tk-8*
	>=sys-apps/grep-2*"

src_install() {
	dobin ding
	insinto /usr/share/dict
	doins ger-eng.txt
	doman ding.1
	dodoc CHANGES
	dodoc COPYING
	dodoc README

	sed -i "s:Exec=/usr/X11R6/bin/ding:Exec=/usr/bin/ding:g" ding.desktop
	insinto /usr/share/icons ; doins ding.png
	insinto /usr/share/applnk/Utilities ; doins ding.desktop
}
