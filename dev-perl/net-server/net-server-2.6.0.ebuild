# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/net-server/net-server-2.6.0.ebuild,v 1.1 2012/07/24 14:36:19 flameeyes Exp $

EAPI=4

MY_PN=Net-Server
MODULE_AUTHOR=RHANDOM
MODULE_VERSION=2.006
inherit perl-module eutils

DESCRIPTION="Extensible, general Perl server engine"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="ipv6"

RDEPEND="dev-perl/IO-Multiplex
	ipv6? ( dev-perl/IO-Socket-INET6 )"
DEPEND="${RDEPEND}"

SRC_TEST="do"
