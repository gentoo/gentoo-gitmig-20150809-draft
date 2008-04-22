# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ReadLine-Perl/Term-ReadLine-Perl-1.03.02.ebuild,v 1.9 2008/04/22 18:54:34 tove Exp $

inherit versionator perl-module

MY_P="${PN}-$(delete_version_separator 2)"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Quick implementation of readline utilities."
HOMEPAGE="http:/search.cpan.org/~ilyaz/${P}/"
SRC_URI="mirror://cpan/authors/id/I/IL/ILYAZ/modules/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="dev-lang/perl"
