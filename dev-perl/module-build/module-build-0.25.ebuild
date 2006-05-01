# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/module-build/module-build-0.25.ebuild,v 1.17 2006/05/01 16:33:21 mcummings Exp $

inherit perl-module

MY_P="Module-Build-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Build and install Perl modules"
HOMEPAGE="http://search.cpan.org/~kwilliams/${MY_P}/"
SRC_URI="mirror://cpan/authors/id/K/KW/KWILLIAMS/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="dev-perl/yaml
	>=dev-perl/Archive-Tar-1.09"

SRC_TEST="do"
