# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Encode-HanConvert/Encode-HanConvert-0.31.ebuild,v 1.3 2006/01/13 20:42:57 mcummings Exp $

inherit perl-module

DESCRIPTION="Traditional and Simplified Chinese mappings"
HOMEPAGE="http://search.cpan.org/~autrijus/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AU/AUTRIJUS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND=">dev-lang/perl-5.6.1"
