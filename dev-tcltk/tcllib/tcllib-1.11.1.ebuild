# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tcllib/tcllib-1.11.1.ebuild,v 1.7 2009/09/22 11:47:03 maekke Exp $

DESCRIPTION="Tcl Standard Library."
HOMEPAGE="http://www.tcl.tk/software/tcllib/"
SRC_URI="mirror://sourceforge/tcllib/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
IUSE="examples"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc s390 sparc x86 ~x86-fbsd"

DEPEND=">=dev-lang/tcl-8.4"

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc ChangeLog DESCRIPTION.txt README* STATUS devdoc/*.txt
	dohtml devdoc/*.html
	if use examples ; then
		for f in $(find examples -type f); do
			docinto $(dirname $f)
			dodoc $f
		done
	fi
}
