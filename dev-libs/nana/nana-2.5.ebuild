# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/nana/nana-2.5.ebuild,v 1.3 2005/09/25 11:07:56 vapier Exp $

DESCRIPTION="a library that provides support for assertion checking and logging"
HOMEPAGE="http://www.gnu.org/software/nana/"
SRC_URI="ftp://ftp.cs.ntu.edu.au/pub/nana/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=sys-devel/gdb-4.17"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# remove duplicated install target
	sed -i \
		-e '/^install-data-am:/s:install-data-local::' \
		man/Makefile.in || die
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"

	dodoc ANNOUNCE AUTHORS ChangeLog NEWS PROJECTS README REGISTRATION THANKS TODO
	dodoc examples/*.ex examples/*.[ch] tcl/status.tcl
}
