# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Netmask/Net-Netmask-1.9002.ebuild,v 1.5 2003/06/21 21:36:36 drobbins Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Parse, manipulate and lookup IP network blocks"
SRC_URI="http://search.cpan.org/CPAN/authors/id/M/MU/MUIR/modules/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/MUIR/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc ~sparc ~alpha"

mydoc="TODO"
