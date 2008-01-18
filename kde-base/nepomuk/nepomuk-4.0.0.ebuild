# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/nepomuk/nepomuk-4.0.0.ebuild,v 1.1 2008/01/18 01:45:11 ingmar Exp $

EAPI="1"

KMNAME=kdebase-runtime
inherit kde4-meta

DESCRIPTION="Nepomuk KDE4 client"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

# dev-cpp/clucene provides the optional strigi backend.
# As there's currently no other *usable* strigi backend, I've added it as a hard
# dependency.
DEPEND="
	>=app-misc/strigi-0.5.7
	dev-cpp/clucene
	>=dev-libs/soprano-2.0.0"
RDEPEND="${DEPEND}"

KDE4_BUILT_WITH_USE_CHECK="-a app-misc/strigi dbus qt4"
