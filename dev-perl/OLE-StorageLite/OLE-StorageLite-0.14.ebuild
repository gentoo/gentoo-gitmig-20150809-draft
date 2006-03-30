# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/OLE-StorageLite/OLE-StorageLite-0.14.ebuild,v 1.3 2006/03/30 23:09:26 agriffis Exp $

inherit perl-module

MY_P=${P/StorageLite/Storage_Lite}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Simple Class for OLE document interface."
HOMEPAGE="http://search.cpan.org/~jmcnamara/${MY_P}/"
SRC_URI="mirror://cpan/authors/id/J/JM/JMCNAMARA/${MY_P}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ia64 sparc x86"
IUSE=""

SRC_TEST="do"
