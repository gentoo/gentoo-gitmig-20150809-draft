# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/module-build/module-build-0.25.ebuild,v 1.3 2004/10/22 16:59:00 mcummings Exp $

inherit perl-module

MY_P="Module-Build-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Build and install Perl modules"
SRC_URI="mirror://cpan/authors/id/K/KW/KWILLIAMS/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~kwilliams/${MY_P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~alpha ~hppa ~mips ~ppc sparc ~amd64"
IUSE=""

style="builder"

DEPEND="dev-perl/module-info
		dev-perl/yaml
		dev-perl/extutils-parsexs
		>=dev-perl/Archive-Tar-1.09"

