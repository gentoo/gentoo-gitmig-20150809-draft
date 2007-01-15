# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Encode-compat/Encode-compat-0.07.ebuild,v 1.11 2007/01/15 17:40:20 mcummings Exp $

inherit perl-module

DESCRIPTION="Encode.pm emulation layer"
HOMEPAGE="http://search.cpan.org/~autrijus/"
SRC_URI="mirror://cpan/authors/id/A/AU/AUTRIJUS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

#SRC_TEST="do"

DEPEND="dev-perl/Text-Iconv
	dev-lang/perl"
