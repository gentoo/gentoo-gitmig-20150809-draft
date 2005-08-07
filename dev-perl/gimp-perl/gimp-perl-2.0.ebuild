# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gimp-perl/gimp-perl-2.0.ebuild,v 1.2 2005/08/07 20:19:49 weeve Exp $

inherit perl-module

MY_P="Gimp-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Perl extension for writing Gimp Extensions/Plug-ins/Load & Save-Handlers"
HOMEPAGE="http://search.cpan.org/~sjburges/Gimp/"
SRC_URI="mirror://cpan/authors/id/S/SJ/SJBURGES/Gimp2/${MY_P}.tar.gz
		mirror://gimp/plug-ins/v2.0/perl/${MY_P}.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.8
	>=dev-perl/PDL-2.4
	>=dev-perl/gtk2-perl-1.00
	=media-gfx/gimp-2*"
DEPEND="${RDEPEND}
	dev-perl/extutils-depends
	dev-util/pkgconfig"

myinst="DESTDIR=${D} INSTALLDIRS=vendor"

src_unpack() {
	unpack ${A}
	cd ${S}
	# workaround for writability check of install dirs
	sed -i -e 's:$$dir:$(DESTDIR)$$dir:g' Makefile.PL
}
