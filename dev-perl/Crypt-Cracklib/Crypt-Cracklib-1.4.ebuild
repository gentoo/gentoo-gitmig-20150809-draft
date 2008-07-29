# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Cracklib/Crypt-Cracklib-1.4.ebuild,v 1.1 2008/07/29 19:22:35 robbat2 Exp $

MODULE_AUTHOR="DANIEL"
inherit perl-module

DESCRIPTION="Perl interface to Alec Muffett's Cracklib"
HOMEPAGE="http://search.cpan.org/~daniel/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""
SRC_TEST="do"

RDEPEND="sys-libs/cracklib
		dev-lang/perl"
DEPEND="${RDEPEND}
		test? ( dev-perl/Pod-Coverage 
				dev-perl/Test-Pod-Coverage )"

src_compile() {
	# this ebuild is very non-standard it seems
	echo -en "/usr/include\n/usr/lib\n"| perl Makefile.PL
	emake
}

src_install() {
	myinst="DESTDIR=${D}"
	perl-module_src_install
}
