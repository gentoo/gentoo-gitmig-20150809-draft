# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Ogg-Vorbis-Header-PurePerl/Ogg-Vorbis-Header-PurePerl-0.07.ebuild,v 1.4 2006/01/13 22:07:00 mcummings Exp $

inherit perl-module

DESCRIPTION="An object-oriented interface to Ogg Vorbis information and comment fields, implemented entirely in Perl. Intended to be a drop in replacement for Ogg::Vobis::Header."
HOMEPAGE="http://search.cpan.org/~amolloy/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AM/AMOLLOY/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

SRC_TEST="do"
