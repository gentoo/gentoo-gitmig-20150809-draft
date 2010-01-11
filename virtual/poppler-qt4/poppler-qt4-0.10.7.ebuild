# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/poppler-qt4/poppler-qt4-0.10.7.ebuild,v 1.9 2010/01/11 11:11:07 ulm Exp $

EAPI=2

DESCRIPTION="Virtual package, includes packages that contain libpoppler-qt4.so"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

PROPERTIES="virtual"

RDEPEND="~dev-libs/poppler-qt4-${PV}"
DEPEND="${RDEPEND}"
