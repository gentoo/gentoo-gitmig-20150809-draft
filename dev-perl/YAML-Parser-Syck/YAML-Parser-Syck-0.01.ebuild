# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/YAML-Parser-Syck/YAML-Parser-Syck-0.01.ebuild,v 1.8 2007/01/19 17:53:28 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl Wrapper for the YAML Parser Extension: libsyck"
HOMEPAGE="http://search.cpan.org/~ingy/"
SRC_URI="mirror://cpan/authors/id/I/IN/INGY/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-libs/syck
	dev-lang/perl"
