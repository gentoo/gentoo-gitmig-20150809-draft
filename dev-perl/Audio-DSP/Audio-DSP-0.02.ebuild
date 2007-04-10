# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Audio-DSP/Audio-DSP-0.02.ebuild,v 1.3 2007/04/10 11:38:14 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl interface to *NIX digital audio device"
HOMEPAGE="http://search.cpan.org/~sethj/"
SRC_URI="mirror://cpan/authors/id/S/SE/SETHJ/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 sparc ~x86"

DEPEND="dev-lang/perl"
