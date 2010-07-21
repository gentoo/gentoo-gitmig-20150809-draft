# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop-php-docs/kdevelop-php-docs-1.0.1.ebuild,v 1.1 2010/07/21 16:54:26 reavertm Exp $

EAPI="2"

if [[ ${PV} != *9999* ]]; then
	KDE_LINGUAS="ca ca@valencia da en_GB es et fr gl it nds nl pt pt_BR sv uk zh_TW"
fi

KMNAME="kdevelop"
KMMODULE="php-docs"
inherit kde4-base

DESCRIPTION="PHP documentation plugin for KDevelop 4"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="debug"
