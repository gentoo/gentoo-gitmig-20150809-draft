# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Attribute-Handlers/Attribute-Handlers-0.78-r1.ebuild,v 1.5 2004/12/24 14:12:49 nigoro Exp $

inherit perl-module

DESCRIPTION="A Perl module for I/O on in-core objects like strings and arrays"
SRC_URI="http://www.cpan.org/modules/by-module/Attribute/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/author/ABERGMAN/${P}/"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha ~ppc64"

myconf="${myconf} INSTALLDIRS=perl"
