# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Cracklib/Crypt-Cracklib-0.01.ebuild,v 1.5 2004/07/14 17:02:52 agriffis Exp $ 

inherit perl-module

AUTHOR="DANIEL"
DESCRIPTION="Perl interface to Alec Muffett's Cracklib"
HOMEPAGE="http://search.cpan.org/author/${AUTHOR}/${P}/"
SRC_URI_BASE="http://search.cpan.org/CPAN/authors/id/${AUTHOR:0:1}/${AUTHOR:0:2}/${AUTHOR}/"
SRC_URI="${SRC_URI_BASE}/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86"
IUSE=""

mydoc="Changes"
DEPEND="${DEPEND}
		sys-libs/cracklib"

src_compile() {
	# this ebuild is very non-standard it seems
	echo -en "/usr/include\n/usr/lib\n"| perl Makefile.PL
	emake
}

src_install() {
	myinst="DESTDIR=${D}"
	perl-module_src_install
}
