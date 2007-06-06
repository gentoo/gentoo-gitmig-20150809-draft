# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/guile-gtk/guile-gtk-1.2.0.60.ebuild,v 1.1 2007/06/06 22:51:04 dberkholz Exp $

MAJOR_PV=${PV%.[0-9]*.[0-9]*}
MINOR_PV=${PV#[0-9]*.[0-9]*.}
MY_P="${PN}-${MINOR_PV}"
DESCRIPTION="GTK+ bindings for guile"
HOMEPAGE="http://www.gnu.org/software/guile-gtk/"
SRC_URI="mirror://gnu/guile-gtk/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""


DEPEND=">=dev-scheme/guile-1.6
	=x11-libs/gtk+-1.2*"

S=${WORKDIR}/${MY_P}

src_install() {
	make DESTDIR=${D} install

	dodoc INSTALL README* COPYING AUTHORS ChangeLog NEWS TODO
	insinto /usr/share/guile-gtk/examples
	doins ${S}/examples/*.scm
}
