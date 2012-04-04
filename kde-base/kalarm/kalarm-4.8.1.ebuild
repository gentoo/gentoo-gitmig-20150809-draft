# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalarm/kalarm-4.8.1.ebuild,v 1.3 2012/04/04 16:55:16 ago Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdepim"
KDE_SCM="git"
inherit kde4-meta

DESCRIPTION="Personal alarm message, command and email scheduler for KDE"
KEYWORDS="amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdepimlibs 'semantic-desktop')
	$(add_kdebase_dep kdepim-common-libs)
	media-libs/phonon
"
DEPEND="${RDEPEND}"

KMEXTRACTONLY="
	kmail/
"
