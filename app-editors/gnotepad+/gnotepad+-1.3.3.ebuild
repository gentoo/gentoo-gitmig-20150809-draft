# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gnotepad+/gnotepad+-1.3.3.ebuild,v 1.6 2004/08/10 13:33:29 fmccor Exp $

DESCRIPTION="Gnotepad+ is a simple HTML and text editor using the GTK Text Widget."
HOMEPAGE="http://gnotepad.sourceforge.net/"
SRC_URI="http://download.sourceforge.net/gnotepad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*"

src_install () {
	einstall || die
}
