# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header $

IUSE=""

inherit perl-module

MY_P=Text-Shellwords-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Provides shellwords() routine which parses lines of text and returns a set of tokens using the same rules that the Unix shell does."

SRC_URI="http://www.cpan.org/modules/by-module/Text/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Text/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
