# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libctl/libctl-3.1.ebuild,v 1.2 2010/12/02 10:39:39 jlec Exp $

EAPI=2

DESCRIPTION="Guile-based library for scientific simulations"
SRC_URI="http://ab-initio.mit.edu/libctl/${P}.tar.gz"
HOMEPAGE="http://ab-initio.mit.edu/libctl/"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug doc examples"

DEPEND="
	>=dev-scheme/guile-1.6[deprecated]
	sci-libs/nlopt"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		--enable-shared \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake failed"
	dodoc NEWS AUTHORS COPYRIGHT ChangeLog
	if use doc; then
		dohtml doc/* || die
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		cd examples
		doins Makefile.am README *.c *.h *.ctl *scm || die
	fi
}
