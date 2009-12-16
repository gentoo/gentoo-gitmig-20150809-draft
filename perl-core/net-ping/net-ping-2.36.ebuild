# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/net-ping/net-ping-2.36.ebuild,v 1.7 2009/12/16 21:54:32 abcd Exp $

EAPI=2

MODULE_AUTHOR=SMPETERS
MY_PN=Net-Ping
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="check a remote host for reachability"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

# online tests
SRC_TEST=no
