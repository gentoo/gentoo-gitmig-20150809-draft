# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/memcached-api-perl/memcached-api-perl-1.14.ebuild,v 1.2 2004/09/11 14:28:18 swegener Exp $

inherit perl-module

DESCRIPTION="Perl API for memcached"

MY_P="Cache-Memcached-${PV}"
HOMEPAGE="http://www.danga.com/memcached/"

SRC_URI="http://search.cpan.org/CPAN/authors/id/B/BR/BRADFITZ/Cache-Memcached-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~hppa ~amd64 ~ia64"
IUSE=""
DEPEND="dev-lang/perl"
RDEPEND="!ia64? ( dev-perl/string-crc32 )"
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
}
