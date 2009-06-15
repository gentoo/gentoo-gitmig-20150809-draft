# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xmlrpc-epi/xmlrpc-epi-0.54.ebuild,v 1.1 2009/06/15 22:07:10 volkmar Exp $

EAPI="2"

DESCRIPTION="Epinions implementation of XML-RPC protocol in C"
HOMEPAGE="http://xmlrpc-epi.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmlrpc-epi/${P}.tar.gz"

LICENSE="Epinions"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="examples"

DEPEND="dev-libs/expat
	!!dev-libs/xmlrpc-c"
RDEPEND="${DEPEND}"

# TODO:
# fix /usr/include/xmlrpc.h conflict with dev-libs/xmlrpc-c, bug 274291

src_prepare() {
	# do not build examples
	sed -i -e "s:sample::" Makefile.in || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"

	if use examples; then
		insinto "/usr/share/doc/${PF}/examples"
		doins sample/*.c sample/*.php || die "doins failed"
		doins -r sample/tests || die "doins failed"
	fi
}
