# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libvorbis-perl/libvorbis-perl-0.04.ebuild,v 1.8 2004/03/14 13:22:54 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Ogg::Vorbis - Perl extension for Ogg Vorbis streams"
SRC_URI_BASE="http://www.cpan.org/modules/by-authors/id/F/FO/FOOF"
SRC_URI="${SRC_URI_BASE}/${P}.tar.gz"
HOMEPAGE="http://synthcode.com/code/vorbis/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 sparc ~ppc ~amd64"

DEPEND="${DEPEND}
	media-libs/libogg
	media-libs/libvorbis"
