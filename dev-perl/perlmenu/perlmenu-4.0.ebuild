# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perlmenu/perlmenu-4.0.ebuild,v 1.3 2006/10/20 17:51:54 mcummings Exp $

inherit perl-module

MY_P="${PN}.v${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Perl Menu Support Facility"
SRC_URI="mirror://cpan/authors/id/S/SK/SKUNZ/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~skunz/${MY_P}/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Curses
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/Makefile.PL ${S}
}


