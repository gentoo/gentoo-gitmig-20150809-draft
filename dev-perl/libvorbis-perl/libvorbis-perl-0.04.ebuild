# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libvorbis-perl/libvorbis-perl-0.04.ebuild,v 1.2 2003/11/19 18:40:59 mholzer Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Ogg::Vorbis - Perl extension for Ogg Vorbis streams"
SRC_URI_BASE="http://www.cpan.org/modules/by-authors/id/F/FO/FOOF"
SRC_URI="${SRC_URI_BASE}/${P}.tar.gz"
HOMEPAGE="http://synthcode.com/code/vorbis/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86"

DEPEND="${DEPEND}
	media-libs/libogg
	media-libs/libvorbis"
