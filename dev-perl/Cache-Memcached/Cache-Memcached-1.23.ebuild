# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cache-Memcached/Cache-Memcached-1.23.ebuild,v 1.5 2007/08/25 13:17:24 vapier Exp $

inherit perl-module

DESCRIPTION="Perl API for memcached"
HOMEPAGE="http://www.danga.com/memcached/"
SRC_URI="mirror://cpan/authors/id/B/BR/BRADFITZ/${P}.tar.gz"

SRC_TEST="do"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha ~amd64 arm ~hppa ia64 ~mips ppc ~ppc64 sh sparc ~sparc-fbsd x86"
IUSE=""

DEPEND="!ia64? ( dev-perl/string-crc32 )
		dev-lang/perl"
mydoc="ChangeLog README TODO"
