# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Period/Period-1.20-r1.ebuild,v 1.1 2002/05/05 18:56:34 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Time Period Perl Module"
SRC_URI="http://www.cpan.org/modules/by-module/Time/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Time/${P}.readme"


src_install () {
	
	base_src_compile
    dohtml Period.html
}
