# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/umbrello/umbrello-4.0.1.ebuild,v 1.3 2008/03/04 01:34:44 jer Exp $

EAPI="1"

KMNAME=kdesdk
inherit kde4-meta

DESCRIPTION="KDE: Umbrello UML Modeller"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="debug htmlhandbook"

COMMONDEPEND="dev-libs/libxml2
	dev-libs/libxslt"
DEPEND="${COMMONDEPEND}"
RDEPEND="${COMMONDEPEND}"
