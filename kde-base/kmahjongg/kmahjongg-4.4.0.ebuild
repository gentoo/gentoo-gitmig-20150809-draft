# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmahjongg/kmahjongg-4.4.0.ebuild,v 1.1 2010/02/09 00:20:16 alexxy Exp $

EAPI="2"

KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="Mahjongg for KDE"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

DEPEND="
	$(add_kdebase_dep libkmahjongg)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libkdegames/
	libkmahjongg/
"
