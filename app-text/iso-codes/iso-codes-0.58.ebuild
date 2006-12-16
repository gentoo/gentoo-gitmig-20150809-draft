# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/iso-codes/iso-codes-0.58.ebuild,v 1.5 2006/12/16 23:34:56 dertobi123 Exp $

WANT_AUTOMAKE="latest"
inherit eutils autotools

DESCRIPTION="Provides the list of country and language names"
HOMEPAGE="http://alioth.debian.org/projects/pkg-isocodes/"
SRC_URI="ftp://pkg-isocodes.alioth.debian.org/pub/pkg-isocodes/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ~ppc64 ~sh ~sparc x86"
IUSE=""

DEPEND="sys-devel/gettext
	>=dev-lang/python-2.3
	>=sys-devel/automake-1.9"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# fix install location for multilib machines
	sed -i -e 's:(datadir)/pkgconfig:(libdir)/pkgconfig:g' Makefile.am

	eautomake
}

src_compile() {
	econf || die "configure failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc ChangeLog README TODO
}
