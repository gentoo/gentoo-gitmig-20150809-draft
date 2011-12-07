# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/thumbnailers/thumbnailers-4.7.3.ebuild,v 1.3 2011/12/07 22:13:38 hwoarang Exp $

EAPI=4

KDE_SCM="git"
KMNAME="kdegraphics-thumbnailers"
inherit kde4-base

DESCRIPTION="KDE 4 thumbnail generators for PDF/PS files"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkdcraw)
	$(add_kdebase_dep libkexiv2)
	media-libs/lcms:0
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${KMNAME}-${PV}"
