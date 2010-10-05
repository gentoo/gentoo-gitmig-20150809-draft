# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Event-ExecFlow/Event-ExecFlow-0.64.ebuild,v 1.4 2010/10/05 19:44:53 maekke Exp $

EAPI=2

MODULE_AUTHOR=JRED
inherit perl-module

DESCRIPTION="High level API for event-based execution flow control"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND="dev-perl/AnyEvent
	dev-perl/libintl-perl"
DEPEND="${RDEPEND}"

SRC_TEST="do"
