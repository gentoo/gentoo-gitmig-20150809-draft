# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Server-Coro/Net-Server-Coro-0.9.ebuild,v 1.1 2011/08/15 14:09:46 patrick Exp $

EAPI=3

MODULE_AUTHOR="ALEXMV"
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
