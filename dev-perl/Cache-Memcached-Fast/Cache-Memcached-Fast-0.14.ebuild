# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cache-Memcached-Fast/Cache-Memcached-Fast-0.14.ebuild,v 1.1 2009/06/15 06:07:33 robbat2 Exp $

MODULE_AUTHOR="KROKI"

inherit perl-module

DESCRIPTION="Perl client for memcached, in C language"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

src_unpack() {
	perl-module_src_unpack
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.14-tests-fix.patch
}

SRC_TEST="do"
