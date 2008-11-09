# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kjots/kjots-4.1.3.ebuild,v 1.1 2008/11/09 02:25:51 scarabeus Exp $

EAPI="2"

KMNAME=kdepim
inherit kde4-meta

DESCRIPTION="Kjots - KDE note taking utility"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND=">=kde-base/libkdepim-${PV}:${SLOT}"

KMEXTRACTONLY="libkdepim"
