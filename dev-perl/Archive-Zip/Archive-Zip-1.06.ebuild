# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Zip/Archive-Zip-1.06.ebuild,v 1.10 2005/02/06 23:09:49 kumba Exp $

inherit perl-module

DESCRIPTION="A wrapper that lets you read Zip archive members as if they were files"
HOMEPAGE="http://www.cpan.org/modules/by-module/Archive/${P}.readme"
SRC_URI="http://www.cpan.org/modules/by-module/Archive/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ~ppc sparc amd64 alpha"
IUSE=""

DEPEND="dev-perl/Compress-Zlib"
