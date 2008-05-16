# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktouch/ktouch-4.0.4.ebuild,v 1.1 2008/05/16 00:32:34 ingmar Exp $

EAPI="1"

KMNAME=kdeedu
inherit kde4-meta

DESCRIPTION="KDE: A program that helps you to learn and practice touch typing"
HOMEPAGE="http://ktouch.sourceforge.net/"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

RDEPEND=">=kde-base/knotify-${PV}:${SLOT}"
