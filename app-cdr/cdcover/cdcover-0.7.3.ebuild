# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdcover/cdcover-0.7.3.ebuild,v 1.2 2009/08/15 13:27:45 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="cdcover allows the creation of inlay-sheets for jewel cd-cases"
HOMEPAGE="http://cdcover.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cddb"

RDEPEND="cddb? ( dev-python/cddb-py )
	dev-lang/python[tk]
	app-text/ggv
	media-sound/cd-discid"
DEPEND=""

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-install_all_images.patch
}

src_compile() {
	emake prefix="${D}/usr" target="/usr" || die "emake failed."
}

src_install() {
	emake prefix="${D}/usr" docdir="${D}/usr/share/doc/${PF}" \
		install || die "emake install failed."
	newicon share/images/document-save.png ${PN}.png
	make_desktop_entry ${PN} ${PN} ${PN}
	prepalldocs
}
