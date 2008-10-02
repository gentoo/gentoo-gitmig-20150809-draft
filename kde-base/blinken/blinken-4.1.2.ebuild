# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/blinken/blinken-4.1.2.ebuild,v 1.1 2008/10/02 06:22:21 jmbsvicetto Exp $

EAPI="2"

KMNAME=kdeedu
inherit kde4-meta

DESCRIPTION="KDE version of the Simon Says game."
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

COMMONDEPEND=">=kde-base/libkdeedu-${PV}:${SLOT}"
DEPEND="${COMMONDEPEND}"
RDEPEND="${COMMONDEPEND}
	>=kde-base/knotify-${PV}:${SLOT}"

KMEXTRACTONLY=libkdeedu/kdeeduui
