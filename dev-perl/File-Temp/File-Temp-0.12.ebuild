# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Temp/File-Temp-0.12.ebuild,v 1.5 2003/06/09 05:06:20 rac Exp $

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
KEYWORDS="x86 ~ppc ~sparc ~alpha"
