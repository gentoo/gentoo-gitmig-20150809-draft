# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/memcached-api-perl/memcached-api-perl-1.0.12.ebuild,v 1.3 2004/05/30 06:23:53 robbat2 Exp $

inherit perl-module

DESCRIPTION="Perl API for memcached"

MY_P="Cache-Memcached-${PV}"
HOMEPAGE="http://www.danga.com/memcached/"
SRC_URI="http://www.danga.com/memcached/dist/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~hppa ~amd64 ~ia64"
IUSE=""
DEPEND="dev-lang/perl"
#RDEPEND=""
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
}
