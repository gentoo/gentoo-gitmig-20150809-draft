# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Zip/Archive-Zip-1.12.ebuild,v 1.3 2004/10/09 12:11:39 dholm Exp $

inherit perl-module

DESCRIPTION="A wrapper that lets you read Zip archive members as if they were files"
HOMEPAGE="http://www.cpan.org/modules/by-module/Archive/${P}.readme"
SRC_URI="http://www.cpan.org/modules/by-module/Archive/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/Compress-Zlib"
