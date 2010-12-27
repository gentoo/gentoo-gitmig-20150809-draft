# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdcover/cdcover-0.7.3.ebuild,v 1.3 2010/12/27 22:15:17 arfrever Exp $

EAPI=2
PYTHON_DEPEND="2"
PYTHON_USE_WITH="tk"

inherit eutils python

DESCRIPTION="cdcover allows the creation of inlay-sheets for jewel cd-cases"
HOMEPAGE="http://cdcover.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cddb"

RDEPEND="cddb? ( dev-python/cddb-py )
	app-text/ggv
	media-sound/cd-discid"
DEPEND=""

S=${WORKDIR}/${PN}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-install_all_images.patch
}

src_compile() {
	emake prefix="${D}/usr" target="/usr" || die "emake failed."
}

src_install() {
	emake prefix="${D}/usr" docdir="${D}/usr/share/doc/${PF}" \
		install || die "emake install failed."
	python_convert_shebangs -r 2 "${D}"
	newicon share/images/document-save.png ${PN}.png
	make_desktop_entry ${PN} ${PN} ${PN}
	prepalldocs
}
