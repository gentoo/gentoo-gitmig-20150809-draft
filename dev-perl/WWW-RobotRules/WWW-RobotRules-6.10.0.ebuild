# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-RobotRules/WWW-RobotRules-6.10.0.ebuild,v 1.1 2011/03/14 06:53:13 tove Exp $

EAPI=3

MODULE_AUTHOR=GAAS
MODULE_VERSION=6.01
inherit perl-module

DESCRIPTION="Parse /robots.txt file"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	!<dev-perl/libwww-perl-6
	>=dev-perl/URI-1.10
"
DEPEND="${RDEPEND}"

SRC_TEST=online
