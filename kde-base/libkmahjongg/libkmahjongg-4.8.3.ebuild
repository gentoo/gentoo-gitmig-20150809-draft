# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkmahjongg/libkmahjongg-4.8.3.ebuild,v 1.3 2012/05/18 20:55:54 ago Exp $

EAPI=4

KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="LibKMahjongg for KDE"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

KMLOADLIBS="libkdegames"
