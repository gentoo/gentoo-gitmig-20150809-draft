# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/guile-gtk/guile-gtk-1.2.0.41.ebuild,v 1.1 2005/06/21 23:17:48 vanquirius Exp $

MAJOR_PV=${PV%.[0-9]*.[0-9]*}
MINOR_PV=${PV#[0-9]*.[0-9]*.}
MY_P="${PN}-${MINOR_PV}"
DESCRIPTION="GTK+ bindings for guile"
HOMEPAGE="http://www.gnu.org/software/guile-gtk/"
SRC_URI="http://savannah.nongnu.org/download/guile-gtk/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""


DEPEND=">=dev-util/guile-1.6
	=x11-libs/gtk+-1.2*"

S=${WORKDIR}/${MY_P}

src_install() {
	make DESTDIR=${D} install

	dodoc INSTALL README* COPYING AUTHORS ChangeLog NEWS TODO
	insinto /usr/share/guile-gtk/examples
	doins ${S}/examples/*.scm
}
