# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Business-UPS/Business-UPS-2.10.0.ebuild,v 1.2 2012/02/24 09:55:24 ago Exp $

EAPI=4

MODULE_AUTHOR=TODDR
MODULE_VERSION=2.01
inherit perl-module

DESCRIPTION="A UPS Interface Module"

SLOT="0"
KEYWORDS="amd64 ~ia64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/libwww-perl"
DEPEND="${RDEPEND}"

SRC_TEST="do"
