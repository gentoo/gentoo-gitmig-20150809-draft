# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/cilk/cilk-5.4.6.ebuild,v 1.2 2011/01/22 03:35:44 bicatali Exp $

EAPI=2
inherit flag-o-matic

DESCRIPTION="Language for multithreaded parallel programming based on ANSI C."
HOMEPAGE="http://supertech.csail.mit.edu/${PN}/"
SRC_URI="http://supertech.csail.mit.edu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples static-libs"

src_prepare() {
	# cilk compiler doesn't like this flags...
	filter-flags "-pipe"
	filter-flags "-ggdb"
	append-cppflags -D_XOPEN_SOURCE=500
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc NEWS README THANKS

	insinto /usr/share/doc/${PF}
	use doc && doins doc/manual.pdf
	use examples && doins -r examples
}
