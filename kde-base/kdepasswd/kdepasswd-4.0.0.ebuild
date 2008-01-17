# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepasswd/kdepasswd-4.0.0.ebuild,v 1.1 2008/01/17 23:53:03 philantrop Exp $

EAPI="1"

KMNAME=kdebase
KMMODULE=apps/${PN}

inherit flag-o-matic kde4-meta

DESCRIPTION="KDE GUI for passwd"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=kde-base/libkonq-${PV}:${SLOT}"
RDEPEND="${DEPEND}
	>=kde-base/kdesu-${PV}:${SLOT}"

PATCHES="${FILESDIR}/${P}-linkage.patch"
