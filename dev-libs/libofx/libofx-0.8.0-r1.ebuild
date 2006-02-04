# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libofx/libofx-0.8.0-r1.ebuild,v 1.9 2006/02/04 18:47:01 agriffis Exp $

inherit eutils

DESCRIPTION="Library to support the Open Financial eXchange XML Format"
HOMEPAGE="http://libofx.sourceforge.net/"
SRC_URI="mirror://sourceforge/libofx/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""

RDEPEND=">=app-text/opensp-1.5
	 >=net-misc/curl-7.9.7"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	# because we redefine docdir in src_install, we need to make sure the
	# dtd's go to the right place, LIBOFX_DTD_DIR
	cd "${S}"/dtd
	sed -i -e 's/$(DESTDIR)$(docdir)/$(DESTDIR)$(LIBOFX_DTD_DIR)/g' \
		Makefile.in

	cd "${S}"
	# bug 116208
	epatch "${FILESDIR}"/${P}-tree.diff
}

src_install() {
	dodir /usr/share/doc/${PF}
	einstall docdir="${D}"/usr/share/doc/${PF} || die
}
