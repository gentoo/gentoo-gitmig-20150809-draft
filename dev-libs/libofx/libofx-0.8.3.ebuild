# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libofx/libofx-0.8.3.ebuild,v 1.3 2007/09/21 13:21:17 opfer Exp $

inherit eutils

DESCRIPTION="Library to support the Open Financial eXchange XML Format"
HOMEPAGE="http://libofx.sourceforge.net/"
SRC_URI="mirror://sourceforge/libofx/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ppc ~sparc x86"
IUSE=""

DEPEND=">=app-text/opensp-1.5
	 >=net-misc/curl-7.9.7"

src_unpack() {
	unpack ${A}

	# because we redefine docdir in src_install, we need to make sure the
	# dtd's go to the right place, LIBOFX_DTD_DIR
	cd "${S}/dtd"
	sed -i -e 's/$(DESTDIR)$(docdir)/$(DESTDIR)$(LIBOFX_DTD_DIR)/g' \
		Makefile.in
}

src_install() {
	dodir /usr/share/doc/${PF}
	make install DESTDIR="${D}" docdir="/usr/share/doc/${PF}" || die 'install failed'
}
