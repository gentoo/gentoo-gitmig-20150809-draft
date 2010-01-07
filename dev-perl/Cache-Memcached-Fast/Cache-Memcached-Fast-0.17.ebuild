# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cache-Memcached-Fast/Cache-Memcached-Fast-0.17.ebuild,v 1.2 2010/01/07 23:27:00 flameeyes Exp $

EAPI=2

MODULE_AUTHOR="KROKI"
inherit perl-module

DESCRIPTION="Perl client for memcached, in C language"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_TEST="do"

MAKEOPTS="${MAKEOPTS} -j1"
