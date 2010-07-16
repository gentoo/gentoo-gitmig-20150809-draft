# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/p5-Palm/p5-Palm-1.003.ebuild,v 1.1 2010/07/16 07:40:05 tove Exp $

inherit perl-module

# Silly tarball has a different version than labeled
MY_PV="1.003_000"
MY_P="${PN}-${MY_PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Perl Module for Palm Pilots"
SRC_URI="mirror://cpan/authors/id/A/AR/ARENSB/${PN}-1.3.0.tar.gz"
HOMEPAGE="http://search.cpan.org/~arensb/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND="dev-lang/perl"
