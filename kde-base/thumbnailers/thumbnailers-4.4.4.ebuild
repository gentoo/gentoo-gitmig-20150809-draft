# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/thumbnailers/thumbnailers-4.4.4.ebuild,v 1.4 2010/06/28 04:11:00 fauli Exp $

EAPI="3"

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="KDE 4 thumbnail generators for PDF/PS files"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="debug"

KMEXTRACTONLY="
	libs/mobipocket
"

DEPEND="
	$(add_kdebase_dep libkdcraw)
	$(add_kdebase_dep libkexiv2)
"
RDEPEND="${DEPEND}"

add_blocker kdegraphics-strigi-analyzer '<4.2.91'
