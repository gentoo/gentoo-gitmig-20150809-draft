# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkmahjongg/libkmahjongg-4.0.5.ebuild,v 1.1 2008/06/05 22:37:55 keytoaster Exp $

EAPI="1"

KMNAME=kdegames
inherit kde4-meta

DESCRIPTION="LibKMahjongg for KDE"
KEYWORDS="~amd64 ~x86"
IUSE="debug "

PATCHES="${FILESDIR}/${PN}-4.0.0-link.patch"
