# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/poppler-glib/poppler-glib-0.10.4.ebuild,v 1.5 2010/01/11 11:10:11 ulm Exp $

EAPI=2

DESCRIPTION="Virtual package, includes packages that contain libpoppler-glib.so"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="+cairo"

PROPERTIES="virtual"

RDEPEND="~app-text/poppler-bindings-${PV}[gtk,cairo?]"
DEPEND="${RDEPEND}"
