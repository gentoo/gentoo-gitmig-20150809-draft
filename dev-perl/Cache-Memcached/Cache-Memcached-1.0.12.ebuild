# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cache-Memcached/Cache-Memcached-1.0.12.ebuild,v 1.1 2005/01/05 07:10:20 lisa Exp $

inherit perl-module

DESCRIPTION="Perl API for memcached"

MY_P="Cache-Memcached-1.0.12"
HOMEPAGE="http://www.danga.com/memcached/"
SRC_URI="http://www.danga.com/memcached/dist/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~mips ~alpha ~hppa ~amd64 ~ia64"
IUSE=""
DEPEND="dev-lang/perl"
#RDEPEND=""
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
}
