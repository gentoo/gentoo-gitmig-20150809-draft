# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/memcached-api-perl/memcached-api-perl-1.0.6.ebuild,v 1.1 2003/07/30 01:48:32 lisa Exp $

inherit perl-module

DESCRIPTION="Perl API for memcached"

HOMEPAGE="http://www.danga.com/memcached/"
SRC_URI="http://www.danga.com/memcached/dist/MemCachedClient-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lang/perl
	>=net-www/memcached-1.1.7"

#RDEPEND=""

S=${WORKDIR}/MemCachedClient-${PV}
ls ${S}
src_unpack() {
	unpack ${A}
}
