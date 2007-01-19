# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ogg-vorbis-header/ogg-vorbis-header-0.03.ebuild,v 1.13 2007/01/19 15:05:38 mcummings Exp $

inherit perl-module

MY_P=Ogg-Vorbis-Header-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="This module presents an object-oriented interface to Ogg Vorbis Comments and Information"
SRC_URI="mirror://cpan/authors/id/D/DB/DBP/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~dbp/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Inline
	media-libs/libogg
		media-libs/libvorbis
	dev-lang/perl"
