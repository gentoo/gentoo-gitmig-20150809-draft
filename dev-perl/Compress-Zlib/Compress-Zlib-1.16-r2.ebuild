# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Compress-Zlib/Compress-Zlib-1.16-r2.ebuild,v 1.7 2004/06/25 00:14:29 agriffis Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A Zlib perl module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/Compress/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/Compress/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="${DEPEND}
	>=sys-libs/zlib-1.1.3"

mydoc="TODO"
