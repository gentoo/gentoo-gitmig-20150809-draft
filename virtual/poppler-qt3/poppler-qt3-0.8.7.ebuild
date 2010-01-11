# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/poppler-qt3/poppler-qt3-0.8.7.ebuild,v 1.5 2010/01/11 11:10:39 ulm Exp $

EAPI=2

DESCRIPTION="Virtual package, includes packages that contain libpoppler-qt.so"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

PROPERTIES="virtual"

RDEPEND="~app-text/poppler-bindings-${PV}[qt3]"
DEPEND="${RDEPEND}"
