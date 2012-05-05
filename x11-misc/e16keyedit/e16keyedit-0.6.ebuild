# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/e16keyedit/e16keyedit-0.6.ebuild,v 1.6 2012/05/05 04:53:48 jdhore Exp $

DESCRIPTION="Key binding editor for enlightenment 16"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND="=x11-libs/gtk+-2*"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_compile() {
	econf --enable-gtk2 || die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc README ChangeLog AUTHORS
}
