# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gnotepad+/gnotepad+-1.3.3.ebuild,v 1.4 2004/06/14 05:03:08 mr_bones_ Exp $

DESCRIPTION="Gnotepad+ is a simple HTML and text editor using the GTK Text Widget."
HOMEPAGE="http://gnotepad.sourceforge.net/"
SRC_URI="http://download.sourceforge.net/gnotepad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*"

src_install () {
	einstall || die
}
