# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ogg-vorbis-header/ogg-vorbis-header-0.02.ebuild,v 1.10 2006/07/05 18:53:05 ian Exp $

inherit perl-module

MY_P=Ogg-Vorbis-Header-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="This module presents an object-oriented interface to Ogg Vorbis Comments and Information"
SRC_URI="mirror://cpan/authors/id/D/DB/DBP/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/DBP/${MY_P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~ppc alpha sparc amd64"
IUSE=""

DEPEND="dev-perl/Inline
		media-libs/libogg
		media-libs/libvorbis"
RDEPEND="${DEPEND}"
