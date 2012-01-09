# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics-strigi-analyzer/kdegraphics-strigi-analyzer-4.7.4.ebuild,v 1.2 2012/01/09 16:16:40 phajdan.jr Exp $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="kdegraphics: strigi plugins"
KEYWORDS="~amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	app-misc/strigi
"
RDEPEND="${DEPEND}"
