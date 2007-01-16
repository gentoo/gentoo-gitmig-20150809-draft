# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libvorbis-perl/libvorbis-perl-0.05.ebuild,v 1.10 2007/01/16 01:10:12 mcummings Exp $

inherit perl-module

DESCRIPTION="Ogg::Vorbis - Perl extension for Ogg Vorbis streams"
SRC_URI="mirror://cpan/authors/id/F/FO/FOOF/${P}.tar.gz"
HOMEPAGE="http://synthcode.com/code/vorbis/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND="media-libs/libogg
	media-libs/libvorbis
	dev-lang/perl"
