# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tcllib/tcllib-1.8.ebuild,v 1.1 2006/07/11 10:57:40 matsuu Exp $

inherit eutils

DESCRIPTION="Tcl Standard Library."
HOMEPAGE="http://www.tcl.tk/software/tcllib/"
SRC_URI="mirror://sourceforge/tcllib/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
IUSE=""
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~s390 ~sparc ~x86"

DEPEND=">=dev-lang/tcl-8.3.1"

src_install() {
	make DESTDIR="${D}" install || die

	dodoc ChangeLog PACKAGES* README STATUS *.txt
}
