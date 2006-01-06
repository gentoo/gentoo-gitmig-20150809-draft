# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/iso-codes/iso-codes-0.49.ebuild,v 1.1 2006/01/06 23:54:24 joem Exp $

inherit autotools

DESCRIPTION="Provides the list of country and language names"
HOMEPAGE="http://alioth.debian.org/projects/pkg-isocodes/"
SRC_URI="mirror://debian/pool/main/i/iso-codes/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="sys-devel/gettext
		>=dev-lang/python-2.3
		>=dev-python/pyxml-0.8.4
		>=sys-devel/automake-1.9"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:(datadir)/pkgconfig:(libdir)/pkgconfig:g' Makefile.am
	eaclocal
	eautoconf
	eautomake
}

src_install() {
	econf || die "configure failed"
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc ChangeLog README TODO
}
