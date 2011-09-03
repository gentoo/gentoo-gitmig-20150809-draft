# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Event-ExecFlow/Event-ExecFlow-0.640.0.ebuild,v 1.2 2011/09/03 21:04:54 tove Exp $

EAPI=4

MODULE_AUTHOR=JRED
MODULE_VERSION=0.64
inherit perl-module

DESCRIPTION="High level API for event-based execution flow control"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 sparc x86"
IUSE=""

RDEPEND="dev-perl/AnyEvent
	dev-perl/libintl-perl"
DEPEND="${RDEPEND}"

SRC_TEST="do"
