# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Zip/Archive-Zip-1.12.ebuild,v 1.1 2004/07/19 02:42:12 esammer Exp $

inherit perl-module

DESCRIPTION="A wrapper that lets you read Zip archive members as if they were files"
HOMEPAGE="http://www.cpan.org/modules/by-module/Archive/${P}.readme"
SRC_URI="http://www.cpan.org/modules/by-module/Archive/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86"
SRC_TEST="do"

DEPEND="dev-perl/Compress-Zlib"
