# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xforms/xforms-1.0.90.ebuild,v 1.11 2006/01/11 01:31:10 vapier Exp $

DESCRIPTION="A graphical user interface toolkit for X"
HOMEPAGE="http://www.nongnu.org/xforms/"
SRC_URI="http://savannah.nongnu.org/download/xforms/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm ppc ~ppc-macos sh sparc x86"
IUSE=""

DEPEND="virtual/x11
	media-libs/jpeg"

src_install () {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog INSTALL NEWS README
}
