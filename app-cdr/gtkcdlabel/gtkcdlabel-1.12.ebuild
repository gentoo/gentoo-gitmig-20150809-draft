# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gtkcdlabel/gtkcdlabel-1.12.ebuild,v 1.1 2008/05/14 17:28:34 drac Exp $

DESCRIPTION="a GUI frontend to cdlabelgen which is a program that can generate a variety of CD tray covers."
HOMEPAGE="http://gtkcdlabel.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.5
	>=app-cdr/cdlabelgen-3
	dev-python/pygtk"

src_install() {
	dobin usr/bin/${PN}.py || die "dobin failed."
	insinto /usr/share
	doins -r usr/share/{applications,${PN},pixmaps} || die "doins failed."
	dodoc usr/share/doc/${PN}/{AUTHORS,README}
}
