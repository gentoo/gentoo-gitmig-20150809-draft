# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Zip/Archive-Zip-1.06.ebuild,v 1.1 2003/07/21 12:02:37 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A wrapper that lets you read Zip archive members as if they were files"
SRC_URI="http://www.cpan.org/modules/by-module/Archive/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Archive/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc "

DEPEND="dev-perl/Compress-Zlib"
