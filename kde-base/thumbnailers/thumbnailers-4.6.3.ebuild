# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/thumbnailers/thumbnailers-4.6.3.ebuild,v 1.2 2011/06/08 23:51:00 tomka Exp $

EAPI=4

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="KDE 4 thumbnail generators for PDF/PS files"
KEYWORDS="~amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
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
