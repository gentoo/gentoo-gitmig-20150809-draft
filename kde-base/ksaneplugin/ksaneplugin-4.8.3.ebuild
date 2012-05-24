# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksaneplugin/ksaneplugin-4.8.3.ebuild,v 1.4 2012/05/24 09:37:11 ago Exp $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="SANE Plugin for KDE"
HOMEPAGE="http://www.kipi-plugins.org"

LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libksane)
"
RDEPEND="${DEPEND}"
