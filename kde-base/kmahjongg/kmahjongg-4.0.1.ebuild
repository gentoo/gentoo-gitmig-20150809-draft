# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmahjongg/kmahjongg-4.0.1.ebuild,v 1.2 2008/03/04 04:43:11 jer Exp $

EAPI="1"
KMNAME=kdegames
inherit kde4-meta

DESCRIPTION="Mahjongg for KDE"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="debug htmlhandbook"
DEPEND="${DEPEND}
		>=kde-base/libkmahjongg-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkdegames libkmahjongg"
