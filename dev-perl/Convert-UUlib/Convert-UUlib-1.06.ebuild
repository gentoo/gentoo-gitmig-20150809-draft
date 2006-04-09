# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Convert-UUlib/Convert-UUlib-1.06.ebuild,v 1.5 2006/04/09 17:49:44 vapier Exp $

inherit perl-module

DESCRIPTION="A Perl interface to the uulib library"
HOMEPAGE="http://www.cpan.org/modules/by-module/Convert/MLEHMANN/${P}.readme"
SRC_URI="mirror://cpan/authors/id/M/ML/MLEHMANN/${P}.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 m68k ppc ppc64 s390 sh sparc x86"
IUSE=""

SRC_TEST="do"
