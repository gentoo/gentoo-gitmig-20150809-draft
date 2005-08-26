# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CORBA-ORBit/CORBA-ORBit-0.4.7.ebuild,v 1.3 2005/08/26 02:12:07 agriffis Exp $

inherit perl-module

DESCRIPTION="Perl module implementing CORBA 2.0 via ORBit"
SRC_URI="mirror://cpan/authors/id/H/HR/HROGERS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~hrogers/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-perl/Error-0.13
	=gnome-base/orbit-0*"

src_compile() {

	perl-module_src_prep makemake

	cp Makefile Makefile.orig
	sed -e "s:-I/usr/include/orbit-1.0:-I/usr/include/orbit-1.0 -I/usr/include/libIDL-1.0:" \
		Makefile.orig > Makefile

	perl-module_src_compile makemake
	perl-module_src_compile test
}
