# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xmlstarlet/xmlstarlet-1.0.3.ebuild,v 1.1 2010/11/27 11:16:34 sping Exp $

EAPI="2"

DESCRIPTION="A set of tools to transform, query, validate, and edit XML documents"
HOMEPAGE="http://xmlstar.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmlstar/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.6.12
	>=dev-libs/libxslt-1.1.9
	dev-libs/libgcrypt
	virtual/libiconv"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dosym /usr/bin/xml /usr/bin/xmlstarlet

	dodoc AUTHORS ChangeLog README TODO
	dohtml -r *
}

src_test() {
	cd tests
	# sh runTests || die "sh runTests failed."
	# Test suite does not return != 0 on failure.
	# until that is fixed, this quick hack helps at least show the known error:
	{ sh runTests |& grep -i failed ; } && die "sh runTests failed."
}
