# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/TimeDate/TimeDate-1.11-r1.ebuild,v 1.13 2003/06/21 21:36:38 drobbins Exp $

inherit perl-module

DESCRIPTION="A Date/Time Parsing Perl Module"
HOMEPAGE="http://www.cpan.org/modules/by-module/Date/${P}.readme"
SRC_URI="http://www.cpan.org/modules/by-module/Date/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"

mymake="/usr"
