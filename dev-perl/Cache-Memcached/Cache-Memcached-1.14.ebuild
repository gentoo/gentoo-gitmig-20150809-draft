# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cache-Memcached/Cache-Memcached-1.14.ebuild,v 1.7 2005/07/07 01:11:56 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl API for memcached"

HOMEPAGE="http://www.danga.com/memcached/"
SRC_URI="mirror://cpan/authors/id/B/BR/BRADFITZ/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~mips ~alpha ~hppa amd64 ia64"
IUSE=""

DEPEND="${RDEPEND}"
RDEPEND="!ia64? ( dev-perl/string-crc32 )"
