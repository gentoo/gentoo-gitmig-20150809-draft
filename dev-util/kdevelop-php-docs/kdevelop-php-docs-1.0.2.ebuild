# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop-php-docs/kdevelop-php-docs-1.0.2.ebuild,v 1.2 2010/10/10 01:17:40 hwoarang Exp $

EAPI="2"

if [[ ${PV} != *9999* ]]; then
	KDE_LINGUAS="ca ca@valencia da en_GB es et fr gl it nds nl pt pt_BR sv uk zh_TW"
fi

KMNAME="kdevelop"
KMMODULE="php-docs"
KDEVELOP_VERSION="4.0.2"
inherit kde4-base

DESCRIPTION="PHP documentation plugin for KDevelop 4"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="amd64 ~x86"
IUSE="debug"
