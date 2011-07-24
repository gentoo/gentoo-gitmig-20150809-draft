# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libofx/libofx-0.9.4.ebuild,v 1.1 2011/07/24 04:20:32 ssuominen Exp $

EAPI=4

DESCRIPTION="A library to support the Open Financial eXchange XML format"
HOMEPAGE="http://libofx.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="static-libs test"

RDEPEND=">=app-text/opensp-1.5
	dev-cpp/libxmlpp:2.6
	>=net-misc/curl-7.9.7"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? ( app-crypt/gnupg )"

src_prepare() {
	# Be sure DTD gets installed in correct path after redefining docdir in install
	sed -i \
		-e 's:$(DESTDIR)$(docdir):$(DESTDIR)$(LIBOFX_DTD_DIR):' \
		dtd/Makefile.in || die
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--disable-doxygen
}

src_install() {
	emake DESTDIR="${D}" docdir=/usr/share/doc/${PF} install

	rm -f "${D}"/usr/share/doc/${PF}/{COPYING,INSTALL}
	find "${D}" -name '*.la' -exec rm -f {} +
}
