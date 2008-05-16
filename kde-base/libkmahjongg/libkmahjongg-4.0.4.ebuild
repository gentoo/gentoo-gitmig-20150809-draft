# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkmahjongg/libkmahjongg-4.0.4.ebuild,v 1.1 2008/05/16 00:46:05 ingmar Exp $

EAPI="1"

KMNAME=kdegames
inherit kde4-meta

DESCRIPTION="LibKMahjongg for KDE"
KEYWORDS="~amd64 ~x86"
IUSE="debug "

PATCHES="${FILESDIR}/${PN}-4.0.0-link.patch"
