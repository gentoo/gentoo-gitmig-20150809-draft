# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kgraphviewer/kgraphviewer-2.0.ebuild,v 1.1 2008/04/05 16:50:50 philantrop Exp $

EAPI="1"

KDE_PV="4.0.3"
KDE_LINGUAS="ar be da de el et fr ga gl ja km lt nb nds nl nn pl pt pt_BR ro se
sk sv th tr uk vi zh_CN"

SLOT="kde-4"
NEED_KDE=":${SLOT}"
inherit kde4-base

DESCRIPTION="KGraphViewer is a tool to display graphviz .dot graphs."
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"
SRC_URI="mirror://kde/stable/${KDE_PV}/src/extragear/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

PREFIX="${KDEDIR}"

DEPEND="sys-devel/gettext"
RDEPEND="media-gfx/graphviz"
