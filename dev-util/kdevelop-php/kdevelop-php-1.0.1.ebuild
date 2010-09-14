# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop-php/kdevelop-php-1.0.1.ebuild,v 1.5 2010/09/14 17:14:47 fauli Exp $

EAPI="2"

# Bug 330051
RESTRICT="test"

if [[ ${PV} != *9999* ]]; then
	KDE_LINGUAS="ca ca@valencia da en_GB es et fr gl it nds nl pt pt_BR sv th uk zh_CN zh_TW"
fi

KMNAME="kdevelop"
KMMODULE="php"
KDEVELOP_VERSION="4.0.1"
inherit kde4-base

DESCRIPTION="PHP plugin for KDevelop 4"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="amd64 x86"
IUSE="debug doc"

RDEPEND="
	doc? ( >=dev-util/kdevelop-php-docs-${PV}:${SLOT} )
"
