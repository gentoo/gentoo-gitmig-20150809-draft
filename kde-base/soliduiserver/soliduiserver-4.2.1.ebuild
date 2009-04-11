# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/soliduiserver/soliduiserver-4.2.1.ebuild,v 1.3 2009/04/11 06:01:01 jer Exp $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="KDE4: Soliduiserver"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	>=kde-base/solid-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}"
