# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Zip/Archive-Zip-1.06.ebuild,v 1.4 2004/02/29 10:54:45 vapier Exp $

inherit perl-module

DESCRIPTION="A wrapper that lets you read Zip archive members as if they were files"
HOMEPAGE="http://www.cpan.org/modules/by-module/Archive/${P}.readme"
SRC_URI="http://www.cpan.org/modules/by-module/Archive/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~amd64"

DEPEND="dev-perl/Compress-Zlib"
