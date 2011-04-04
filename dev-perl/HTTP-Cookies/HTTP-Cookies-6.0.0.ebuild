# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-Cookies/HTTP-Cookies-6.0.0.ebuild,v 1.2 2011/04/04 23:15:36 jer Exp $

EAPI=3

MODULE_AUTHOR=GAAS
MODULE_VERSION=6.00
inherit perl-module

DESCRIPTION="Storage of cookies"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

RDEPEND="
	!<dev-perl/libwww-perl-6
	>=dev-perl/HTTP-Date-6.0.0
	virtual/perl-Time-Local
	>=dev-perl/HTTP-Message-6.0.0
"
DEPEND="${RDEPEND}"

SRC_TEST=online
