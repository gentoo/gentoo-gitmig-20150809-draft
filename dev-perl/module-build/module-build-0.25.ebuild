# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/module-build/module-build-0.25.ebuild,v 1.6 2004/10/31 13:56:22 mcummings Exp $

inherit perl-module

MY_P="Module-Build-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Build and install Perl modules"
HOMEPAGE="http://search.cpan.org/~kwilliams/${MY_P}/"
SRC_URI="mirror://cpan/authors/id/K/KW/KWILLIAMS/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha ~amd64 hppa ~mips ~ppc sparc x86"
IUSE=""

SRC_TEST="do"

style="builder"

DEPEND="dev-perl/module-info
	dev-perl/yaml
	dev-perl/extutils-parsexs
	>=dev-perl/Archive-Tar-1.09"
