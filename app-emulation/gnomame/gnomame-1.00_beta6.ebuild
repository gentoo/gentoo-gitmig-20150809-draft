# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/gnomame/gnomame-1.00_beta6.ebuild,v 1.1 2003/06/21 10:01:53 vapier Exp $

MY_P="${P/_beta/b}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="GTK+ xmame catalog and frontend"
SRC_URI="http://gnomame.sourceforge.net/files/${MY_P}.tar.gz"
HOMEPAGE="http://gnomame.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND="=x11-libs/gtk+-1.2*
	media-libs/gdk-pixbuf"

src_compile() {
	econf || die
	emake || die "Compilation failed"
}
src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog README
}
