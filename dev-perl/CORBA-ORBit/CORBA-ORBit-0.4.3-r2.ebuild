# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CORBA-ORBit/CORBA-ORBit-0.4.3-r2.ebuild,v 1.2 2002/05/21 18:14:07 danarmak Exp $

# Inherit the perl-module.eclass functions

inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="A Convert Perl Module"
SRC_URI="http://www.cpan.org/modules/by-module/CORBA/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/CORBA/${P}.readme"

DEPEND="${DEPEND}
	>=dev-perl/Error-0.13
	>=gnome-base/ORBit-0.5.6"

src_compile() {

	base_src_compile makemake

	cp Makefile Makefile.orig
	sed -e "s:-I/usr/include/orbit-1.0:-I/usr/include/orbit-1.0 -I/usr/include/libIDL-1.0:g" \
		Makefile.orig > Makefile
	base_src_compile test
}
