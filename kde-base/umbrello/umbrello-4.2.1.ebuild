# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/umbrello/umbrello-4.2.1.ebuild,v 1.1 2009/03/04 23:02:08 alexxy Exp $

EAPI="2"

KMNAME="kdesdk"
inherit kde4-meta

DESCRIPTION="KDE: Umbrello UML Modeller"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

COMMONDEPEND="dev-libs/boost
	dev-libs/libxml2
	dev-libs/libxslt"
DEPEND="${COMMONDEPEND}"
RDEPEND="${COMMONDEPEND}"
