# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Compress-Zlib/Compress-Zlib-1.22.ebuild,v 1.6 2004/01/19 21:38:34 esammer Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A Zlib perl module"
SRC_URI="http://cpan.pair.com/modules/by-module/Compress/${P}.tar.gz"
HOMEPAGE="http://cpan.pair.com/modules/by-module/Compress/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~amd64 ~ppc sparc ~alpha ~mips ~arm ~hppa"

DEPEND="${DEPEND}
	>=sys-libs/zlib-1.1.3"

mydoc="TODO"
