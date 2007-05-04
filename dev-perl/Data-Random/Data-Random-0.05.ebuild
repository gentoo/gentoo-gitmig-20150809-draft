# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Random/Data-Random-0.05.ebuild,v 1.4 2007/05/04 11:43:37 ticho Exp $

inherit perl-module

DESCRIPTION="A module used to generate random data."
HOMEPAGE="http://search.cpan.org/~adeo"
SRC_URI="mirror://cpan/authors/id/A/AD/ADEO/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl"
