# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dvipdfmx/dvipdfmx-20100328.ebuild,v 1.2 2010/07/12 20:45:13 hwoarang Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="DVI to PDF translator with multi-byte character support"
HOMEPAGE="http://project.ktug.or.kr/dvipdfmx/"
SRC_URI="http://project.ktug.or.kr/${PN}/snapshot/latest/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="app-text/libpaper
	media-libs/libpng
	sys-libs/zlib
	virtual/tex-base
	app-text/libpaper"
RDEPEND="${DEPEND}
	>=app-text/poppler-0.12.3-r3
	app-text/poppler-data"

src_prepare() {
	epatch "${FILESDIR}"/20090708-fix_file_collisions.patch
	eautoreconf
}

src_install() {
	# Override dvipdfmx.cfg default installation location so that it is easy to
	# modify it and it gets config protected. Symlink it from the old location.
	emake configdatadir="/etc/texmf/dvipdfm" DESTDIR="${D}" install || die
	dosym /etc/texmf/dvipdfm/dvipdfmx.cfg /usr/share/texmf/dvipdfm/dvipdfmx.cfg || die

	# Symlink poppler-data cMap, bug #201258
	dosym /usr/share/poppler/cMap /usr/share/texmf/fonts/cmap/cMap || die
	dodoc AUTHORS ChangeLog README || die

	# Remove symlink conflicting with app-text/dvipdfm (bug #295235)
	rm "${D}"/usr/bin/ebb
}

pkg_postinst() {
	[[ ${ROOT} == / ]] && /usr/sbin/texmf-update
}

pkg_postrm() {
	[[ ${ROOT} == / ]] && /usr/sbin/texmf-update
}
