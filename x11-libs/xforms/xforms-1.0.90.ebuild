# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xforms/xforms-1.0.90.ebuild,v 1.9 2005/08/20 18:55:20 grobian Exp $

DESCRIPTION="A graphical user interface toolkit for X"
HOMEPAGE="http://www.nongnu.org/xforms/"
SRC_URI="http://savannah.nongnu.org/download/xforms/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="amd64 ppc ~ppc-macos sparc x86"
IUSE=""

DEPEND="virtual/x11
	media-libs/jpeg"

src_install () {
	make DESTDIR=${D} install || die
	dodoc ChangeLog Copyright INSTALL NEWS README
}
