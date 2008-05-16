# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwallet/kwallet-4.0.4.ebuild,v 1.1 2008/05/16 00:39:15 ingmar Exp $

EAPI="1"

KMNAME=kdeutils
inherit kde4-meta

DESCRIPTION="KDE Wallet Management Tool"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND=""
RDEPEND=">=kde-base/kcmshell-${PV}:${SLOT}"
