# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/frescobaldi/frescobaldi-1.0.2.ebuild,v 1.1 2010/05/26 07:49:52 scarabeus Exp $

EAPI="2"

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
	>=kde-base/pykde4-${KDE_MINIMAL}
	media-gfx/imagemagick
	media-sound/lilypond
"
RDEPEND=${DEPEND}

pkg_setup() {
	python_set_active_version 2
	kde4-base_pkg_setup
}

src_install() {
	kde4-base_src_install
	find "${D}" -type -f -name '*.pyc' -exec rm -f {} +
}
