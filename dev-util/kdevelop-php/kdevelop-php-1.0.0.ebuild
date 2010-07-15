# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop-php/kdevelop-php-1.0.0.ebuild,v 1.3 2010/07/15 10:45:54 hwoarang Exp $

EAPI="2"

KMNAME="kdevelop"
KMMODULE="php"
inherit kde4-base

DESCRIPTION="PHP plugin for KDevelop 4"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="amd64 x86"
IUSE="debug doc"

RDEPEND="
	doc? ( >=dev-util/kdevelop-php-docs-${PV}:${SLOT} )
"
