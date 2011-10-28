# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/frescobaldi/frescobaldi-1.2.0.ebuild,v 1.3 2011/10/28 23:48:06 abcd Exp $

EAPI=4

KDE_LINGUAS="cs de es fr gl it nl pl ru tr"
PYTHON_DEPEND="2"
inherit python kde4-base

DESCRIPTION="a LilyPond sheet music text editor for KDE"
HOMEPAGE="http://www.frescobaldi.org/"
SRC_URI="http://lilykde.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="+handbook"

DEPEND="
	dev-python/PyQt4[examples]
	$(add_kdebase_dep pykde4)
	media-gfx/imagemagick
	media-sound/lilypond
"
RDEPEND=${DEPEND}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
	kde4-base_pkg_setup
}

src_install() {
	kde4-base_src_install
	python_clean_installation_image -q
}
