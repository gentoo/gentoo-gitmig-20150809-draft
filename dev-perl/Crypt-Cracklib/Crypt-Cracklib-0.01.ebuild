# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Cracklib/Crypt-Cracklib-0.01.ebuild,v 1.1 2003/08/19 00:24:19 robbat2 Exp $ 

inherit perl-module

AUTHOR="DANIEL"
S=${WORKDIR}/${P}
DESCRIPTION="Perl interface to Alec Muffett's Cracklib"
HOMEPAGE="http://search.cpan.org/author/${AUTHOR}/${P}/"
SRC_URI_BASE="http://search.cpan.org/CPAN/authors/id/${AUTHOR:0:1}/${AUTHOR:0:2}/${AUTHOR}/"
SRC_URI="${SRC_URI_BASE}/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86"

mydoc="Changes"
DEPEND="${DEPEND}
		sys-libs/cracklib"

src_compile() {
	# this ebuild is very non-standard it seems
	echo -en "/usr/include\n/usr/lib\n"| perl Makefile.PL
	emake
}

