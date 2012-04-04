# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/akonadiconsole/akonadiconsole-4.8.1.ebuild,v 1.2 2012/04/04 16:41:41 ago Exp $

EAPI=4

KMNAME="kdepim"
KDE_SCM="git"
inherit kde4-meta

DESCRIPTION="Akonadi developer console"
KEYWORDS="amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs 'semantic-desktop')
	$(add_kdebase_dep kdepim-common-libs)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	akonadi_next/
	calendarsupport/
	messageviewer/
"
