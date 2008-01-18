# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libtaskmanager/libtaskmanager-4.0.0.ebuild,v 1.1 2008/01/18 01:39:10 ingmar Exp $

EAPI="1"

KMNAME=kdebase-workspace
KMMODULE=libs/taskmanager
inherit kde4-meta

DESCRIPTION="A library that provides basic taskmanager functionality"
KEYWORDS="~amd64 ~x86"
IUSE="debug xcomposite"

COMMONDEPEND="
	x11-libs/libXfixes
	x11-libs/libXrender
	xcomposite? ( x11-libs/libXcomposite )"
DEPEND="${COMMONDEPEND}
	x11-proto/renderproto
	xcomposite? ( x11-proto/compositeproto )"
RDEPEND="${COMMONDEPEND}"
