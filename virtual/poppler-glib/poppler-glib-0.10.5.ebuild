# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/poppler-glib/poppler-glib-0.10.5.ebuild,v 1.13 2010/01/24 01:39:56 abcd Exp $

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
