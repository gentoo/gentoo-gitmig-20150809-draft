# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwallet/kwallet-4.1.4.ebuild,v 1.1 2009/01/13 23:08:02 alexxy Exp $

EAPI="2"

KMNAME=kdeutils
inherit kde4-meta

DESCRIPTION="KDE Wallet Management Tool"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

DEPEND=""
RDEPEND=">=kde-base/kcmshell-${PV}:${SLOT}"
