# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cache-Memcached/Cache-Memcached-1.14.ebuild,v 1.4 2005/04/01 04:41:42 agriffis Exp $

inherit perl-module

DESCRIPTION="Perl API for memcached"

MY_P="Cache-Memcached-1.14"
HOMEPAGE="http://www.danga.com/memcached/"

SRC_URI="http://search.cpan.org/CPAN/authors/id/B/BR/BRADFITZ/Cache-Memcached-1.14.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~mips ~alpha ~hppa amd64 ia64"
IUSE=""
DEPEND="dev-lang/perl"
RDEPEND="!ia64? ( dev-perl/string-crc32 )"
#S=${WORKDIR}/${MY_P}
