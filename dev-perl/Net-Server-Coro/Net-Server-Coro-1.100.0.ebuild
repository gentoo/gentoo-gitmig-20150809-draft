# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Server-Coro/Net-Server-Coro-1.100.0.ebuild,v 1.1 2011/09/05 16:59:10 tove Exp $

EAPI=4

MODULE_AUTHOR=ALEXMV
MODULE_VERSION=1.1
inherit perl-module

DESCRIPTION="A co-operative multithreaded server using Coro"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Coro
	dev-perl/EV
	dev-perl/net-server
	dev-perl/Net-SSLeay"
DEPEND="${RDEPEND}"

SRC_TEST="do"
