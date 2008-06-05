# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/umbrello/umbrello-4.0.5.ebuild,v 1.1 2008/06/05 22:49:05 keytoaster Exp $

EAPI="1"

KMNAME=kdesdk
inherit kde4-meta

DESCRIPTION="KDE: Umbrello UML Modeller"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

COMMONDEPEND="dev-libs/libxml2
	dev-libs/libxslt"
DEPEND="${COMMONDEPEND}"
RDEPEND="${COMMONDEPEND}"
