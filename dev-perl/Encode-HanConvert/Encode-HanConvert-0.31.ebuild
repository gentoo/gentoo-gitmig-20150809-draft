# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Encode-HanConvert/Encode-HanConvert-0.31.ebuild,v 1.9 2007/01/15 17:41:08 mcummings Exp $

inherit perl-module

DESCRIPTION="Traditional and Simplified Chinese mappings"
HOMEPAGE="http://search.cpan.org/~autrijus/"
SRC_URI="mirror://cpan/authors/id/A/AU/AUTRIJUS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND=">dev-lang/perl-5.6.1"
