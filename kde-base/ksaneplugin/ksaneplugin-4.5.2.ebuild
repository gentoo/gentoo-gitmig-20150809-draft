# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksaneplugin/ksaneplugin-4.5.2.ebuild,v 1.1 2010/10/06 09:17:29 alexxy Exp $

EAPI="3"

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="SANE Plugin for KDE"
HOMEPAGE="http://www.kipi-plugins.org"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libksane)
"
RDEPEND="${DEPEND}"
