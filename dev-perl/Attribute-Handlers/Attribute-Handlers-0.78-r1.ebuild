# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Attribute-Handlers/Attribute-Handlers-0.78-r1.ebuild,v 1.1 2003/05/21 21:50:55 rac Exp $

inherit perl-module

S=${WORKDIR}/${P}

DESCRIPTION="A Perl module for I/O on in-core objects like strings and arrays"
SRC_URI="http://www.cpan.org/CPAN/authors/id/A/AB/ABERGMAN/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/author/ABERGMAN/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc sparc alpha"

myconf="${myconf} INSTALLDIRS=perl"
