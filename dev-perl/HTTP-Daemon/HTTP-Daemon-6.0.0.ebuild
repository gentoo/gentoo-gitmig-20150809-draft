# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-Daemon/HTTP-Daemon-6.0.0.ebuild,v 1.2 2011/04/04 23:16:14 jer Exp $

EAPI=3

MODULE_AUTHOR=GAAS
MODULE_VERSION=6.00
inherit perl-module

DESCRIPTION="Base class for simple HTTP servers"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

RDEPEND="
	!<dev-perl/libwww-perl-6
	>=dev-perl/HTTP-Date-6.0.0
	virtual/perl-IO
	>=dev-perl/HTTP-Message-6.0.0
	>=dev-perl/LWP-MediaTypes-6.0.0
"
DEPEND="${RDEPEND}"

SRC_TEST=online
