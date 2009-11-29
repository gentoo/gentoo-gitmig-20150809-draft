# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dvipdfmx/dvipdfmx-20090708.ebuild,v 1.1 2009/11/29 22:24:00 scarabeus Exp $

EAPI="2"

inherit eutils base autotools

DESCRIPTION="DVI to PDF translator with multi-byte character support"
HOMEPAGE="http://project.ktug.or.kr/dvipdfmx/"
SRC_URI="http://project.ktug.or.kr/${PN}/snapshot/latest/${P}.tar.gz"
IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

DEPEND="
	app-text/libpaper
	media-libs/libpng
	sys-libs/zlib
	virtual/tex-base
	app-text/libpaper
"
RDEPEND="${DEPEND}
	virtual/poppler
	app-text/poppler-data
"

PATCHES=(
	"${FILESDIR}/${PV}-fix_file_collisions.patch"
)

src_prepare() {
	base_src_prepare
	eautoreconf
}

src_install() {
	# Override dvipdfmx.cfg default installation location so that it is easy to
	# modify it and it gets config protected. Symlink it from the old location.
	emake configdatadir="/etc/texmf/dvipdfm" DESTDIR="${D}" install || die "make install failed"
	dosym /etc/texmf/dvipdfm/dvipdfmx.cfg /usr/share/texmf/dvipdfm/dvipdfmx.cfg || die

	# Symlink poppler-data cMap, bug #201258
	dosym /usr/share/poppler/cMap /usr/share/texmf/fonts/cmap/cMap || die
	dodoc AUTHORS ChangeLog README || die
}

pkg_postinst() {
	[[ ${ROOT} == / ]] && mktexlsr
}

pkg_postrm() {
	[[ ${ROOT} == / ]] && mktexlsr
}
