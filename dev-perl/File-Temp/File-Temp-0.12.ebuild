# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header $

IUSE=""

inherit perl-module

MY_P=File-Temp-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"

DESCRIPTION="File::Temp can be used to create and open temporary files in a safe way."
SRC_URI="http://www.cpan.org/modules/by-module/File/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/File/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~sparc64 ~alpha"

DEPEND="${DEPEND}"
