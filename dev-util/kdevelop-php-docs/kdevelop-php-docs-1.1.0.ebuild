# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop-php-docs/kdevelop-php-docs-1.1.0.ebuild,v 1.1 2010/10/26 19:53:19 reavertm Exp $

EAPI="2"

KDE_LINGUAS="ca ca@valencia da en_GB es et fr gl it nds nl pt pt_BR sv uk zh_TW"

KMNAME="kdevelop"
KMMODULE="php-docs"
KDEVELOP_VERSION="4.1.0"
inherit kde4-base

DESCRIPTION="PHP documentation plugin for KDevelop 4"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2 LGPL-2"
IUSE="debug"
