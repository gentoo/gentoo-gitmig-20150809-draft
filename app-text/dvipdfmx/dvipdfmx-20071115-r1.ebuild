# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dvipdfmx/dvipdfmx-20071115-r1.ebuild,v 1.3 2009/11/11 20:47:58 jer Exp $

inherit eutils

IUSE=""

DESCRIPTION="DVI to PDF translator with multi-byte character support"
HOMEPAGE="http://project.ktug.or.kr/dvipdfmx/"
SRC_URI="http://project.ktug.or.kr/dvipdfmx/snapshot/current/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

DEPEND="virtual/tex-base
	>=media-libs/libpng-1.2.1
	>=sys-libs/zlib-1.1.4
	app-text/libpaper
	!<app-text/texlive-core-2007-r10"
RDEPEND="${DEPEND}
	app-text/poppler-data"

has_tetex_3() {
	if has_version '>=app-text/tetex-3' || has_version '>=app-text/ptex-3.1.8' || has_version '>=app-text/texlive-core-2007' ; then
		true
	else
		false
	fi
}

src_install() {
	# Override dvipdfmx.cfg default installation location so that it is easy to
	# modify it and it gets config protected. Symlink it from the old location.
	emake configdatadir="/etc/texmf/dvipdfm" DESTDIR="${D}" install || die "make install failed"
	dosym /etc/texmf/dvipdfm/dvipdfmx.cfg /usr/share/texmf/dvipdfm/dvipdfmx.cfg

	# Symlink poppler-data cMap, bug #201258
	dosym /usr/share/poppler/cMap /usr/share/texmf/fonts/cmap/cMap
	dodoc AUTHORS ChangeLog README TODO
}

pkg_postinst() {
	if [ "$ROOT" = "/" ] ; then
		has_tetex_3 && texmf-update || mktexlsr
	fi
}

pkg_postrm() {
	if [ "$ROOT" = "/" ] ; then
		has_tetex_3 && texmf-update || mktexlsr
	fi
}
