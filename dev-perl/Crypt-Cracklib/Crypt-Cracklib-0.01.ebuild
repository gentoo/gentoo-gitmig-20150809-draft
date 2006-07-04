# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Cracklib/Crypt-Cracklib-0.01.ebuild,v 1.9 2006/07/04 07:01:33 ian Exp $

inherit perl-module

AUTHOR="DANIEL"
DESCRIPTION="Perl interface to Alec Muffett's Cracklib"
HOMEPAGE="http://search.cpan.org/~daniel/${P}/"
SRC_URI_BASE="mirror://cpan/authors/id/${AUTHOR:0:1}/${AUTHOR:0:2}/${AUTHOR}/"
SRC_URI="${SRC_URI_BASE}/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~ia64 x86"
IUSE=""

mydoc="Changes"
DEPEND="sys-libs/cracklib"
RDEPEND="${DEPEND}"

src_compile() {
	# this ebuild is very non-standard it seems
	echo -en "/usr/include\n/usr/lib\n"| perl Makefile.PL
	emake
}

src_install() {
	myinst="DESTDIR=${D}"
	perl-module_src_install
}