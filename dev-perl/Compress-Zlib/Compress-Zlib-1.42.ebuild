# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Compress-Zlib/Compress-Zlib-1.42.ebuild,v 1.8 2006/10/20 18:58:39 kloeri Exp $

inherit perl-module

DESCRIPTION="A Zlib perl module"
HOMEPAGE="http://cpan.pair.com/modules/by-module/Compress/${P}.readme"
SRC_URI="mirror://cpan/modules/by-module/Compress/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ~ppc64 s390 sh sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-libs/zlib
	dev-lang/perl"
RDEPEND="${DEPEND}"

SRC_TEST="do"

mydoc="TODO"
