# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/yaml/yaml-0.35.ebuild,v 1.4 2004/02/22 20:53:53 agriffis Exp $

inherit perl-module

MY_P="YAML-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="YAML Ain't Markup Language (tm)"
SRC_URI="http://www.cpan.org/modules/by-authors/id/I/IN/INGY/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/I/IN/INGY/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~alpha ~hppa ~mips ~ppc ~sparc ~amd64"

src_compile() {
	echo "" | perl-module_src_compile
}
