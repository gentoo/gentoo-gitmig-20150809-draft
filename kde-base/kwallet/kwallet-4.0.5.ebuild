# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwallet/kwallet-4.0.5.ebuild,v 1.1 2008/06/05 22:32:31 keytoaster Exp $

EAPI="1"

KMNAME=kdeutils
inherit kde4-meta

DESCRIPTION="KDE Wallet Management Tool"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND=""
RDEPEND=">=kde-base/kcmshell-${PV}:${SLOT}"
