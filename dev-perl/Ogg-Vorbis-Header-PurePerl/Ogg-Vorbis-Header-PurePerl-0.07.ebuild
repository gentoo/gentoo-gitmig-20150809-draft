# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Ogg-Vorbis-Header-PurePerl/Ogg-Vorbis-Header-PurePerl-0.07.ebuild,v 1.13 2012/03/25 16:52:50 armin76 Exp $

inherit perl-module

DESCRIPTION="An object-oriented interface to Ogg Vorbis information and comment fields, implemented entirely in Perl. Intended to be a drop in replacement for Ogg::Vobis::Header."
HOMEPAGE="http://search.cpan.org/~amolloy/"
SRC_URI="mirror://cpan/authors/id/A/AM/AMOLLOY/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
