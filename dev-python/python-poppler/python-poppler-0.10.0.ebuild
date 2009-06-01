# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-poppler/python-poppler-0.10.0.ebuild,v 1.2 2009/06/01 16:22:00 mr_bones_ Exp $

EAPI=2

inherit libtool

DESCRIPTION="Python bindings to the Poppler PDF library."
SRC_URI="http://launchpad.net/poppler-python/trunk/development/+download/pypoppler-${PV}.tar.gz"
HOMEPAGE="http://launchpad.net/poppler-python"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}/pypoppler-${PV}"

RDEPEND=">=virtual/poppler-glib-0.10.0
	>=dev-python/pygobject-2.11.3
	>=dev-python/pygtk-2.10.0
	>=dev-python/pycairo-1.2.0"
DEPEND="${RDEPEND}"

src_prepare() {
	elibtoolize
}

src_install() {
	emake DESTDIR="${D}" install
	find "${D}" -name '*.la' -type f -exec rm -f '{}' ';' || die "Removing .la files failed"
}
