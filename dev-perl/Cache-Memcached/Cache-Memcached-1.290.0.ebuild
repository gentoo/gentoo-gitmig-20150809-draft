# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cache-Memcached/Cache-Memcached-1.290.0.ebuild,v 1.1 2011/09/01 11:41:10 tove Exp $

EAPI=4

MODULE_AUTHOR=DORMANDO
MODULE_VERSION=1.29
inherit perl-module

DESCRIPTION="Perl API for memcached"
HOMEPAGE="http://www.danga.com/memcached/ ${HOMEPAGE}"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="dev-perl/string-crc32"
RDEPEND="${DEPEND}"

SRC_TEST="do"
