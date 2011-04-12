# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop-php/kdevelop-php-1.2.0.ebuild,v 1.6 2011/04/12 21:48:16 dilfridge Exp $

EAPI=3

# Bug 330051
# RESTRICT="test"

KDE_LINGUAS="ca ca@valencia da de en_GB es et fr it nds nl pt pt_BR sv th uk zh_CN zh_TW"

KMNAME="kdevelop"
KMMODULE="php"
KDEVELOP_VERSION="4.2.0"
VIRTUALX_REQUIRED=test
inherit kde4-base

DESCRIPTION="PHP plugin for KDevelop 4"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2 LGPL-2"
IUSE="debug doc"

DEPEND="
	>=dev-util/kdevelop-pg-qt-0.9.0
	dev-util/kdevelop
"
RDEPEND="
	doc? ( >=dev-util/kdevelop-php-docs-${PV}:${SLOT} )
"

PATCHES=( "${FILESDIR}/${P}"-dbustests.patch )
