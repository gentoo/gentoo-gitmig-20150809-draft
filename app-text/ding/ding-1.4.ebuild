# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ding/ding-1.4.ebuild,v 1.3 2005/07/16 15:59:45 josejx Exp $

DESCRIPTION="Tk based dictionary (German-English) (incl. dictionary itself)"
HOMEPAGE="http://www-user.tu-chemnitz.de/~fri/ding/"
SRC_URI="http://wftp.tu-chemnitz.de/pub/Local/urz/ding/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""

RDEPEND=">=dev-lang/tk-8.3
	>=sys-apps/grep-2"

src_install() {
	dobin ding || die "dobin failed."
	insinto /usr/share/dict
	doins de-en.txt || die "doins failed."
	doman ding.1
	dodoc CHANGES COPYING README

	sed -i "s:Exec=/usr/X11R6/bin/ding:Exec=/usr/bin/ding:g" ding.desktop
	insinto /usr/share/icons
	doins ding.png || die "problem with png."
	insinto /usr/share/applnk/Utilities
	doins ding.desktop || die ".desktop problem"
}
