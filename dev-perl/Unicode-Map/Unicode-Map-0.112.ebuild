# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unicode-Map/Unicode-Map-0.112.ebuild,v 1.14 2006/11/12 03:49:07 vapier Exp $

inherit perl-module

DESCRIPTION="map charsets from and to utf16 code"
HOMEPAGE="http://www.cpan.org/~mschwartz/${P}/"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHWARTZ/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

SRC_TEST="do"
