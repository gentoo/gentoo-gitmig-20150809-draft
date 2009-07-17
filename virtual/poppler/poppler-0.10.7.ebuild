# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/poppler/poppler-0.10.7.ebuild,v 1.7 2009/07/17 14:05:32 armin76 Exp $

EAPI=2

DESCRIPTION="Virtual package, includes packages that contain libpoppler-glib.so"
HOMEPAGE="http://poppler.freedesktop.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

PROPERTIES="virtual"

RDEPEND="~dev-libs/poppler-${PV}"
DEPEND="${RDEPEND}"
