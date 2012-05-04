# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gimp-perl/gimp-perl-2.2_pre1.ebuild,v 1.11 2012/05/04 04:10:55 jdhore Exp $

inherit multilib perl-module

MY_P="Gimp-${PV/_/}"
S="${WORKDIR}/${PN}"

DESCRIPTION="Perl extension for writing Gimp Extensions/Plug-ins/Load & Save-Handlers"
HOMEPAGE="http://search.cpan.org/~sjburges/Gimp/"
SRC_URI="mirror://gimp/plug-ins/v2.2/perl/${MY_P}.tar.gz
		mirror://cpan/authors/id/S/SJ/SJBURGES/${MY_P}.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.8
	>=dev-perl/PDL-2.4
	>=dev-perl/gtk2-perl-1.00
	>=media-gfx/gimp-2.2"
DEPEND="${RDEPEND}
	dev-perl/extutils-depends
	dev-perl/extutils-pkgconfig
	virtual/pkgconfig"

myinst="DESTDIR=${D} INSTALLDIRS=vendor"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# workaround for writability check of install dirs
	sed -i -e 's:$$dir:$(DESTDIR)$$dir:g' Makefile.PL
}

src_install() {
	perl-module_src_install
	rm "${D}/usr/$(get_libdir)/gimp/2.0/plug-ins/redeye"
}
