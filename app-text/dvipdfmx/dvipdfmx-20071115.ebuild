# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dvipdfmx/dvipdfmx-20071115.ebuild,v 1.1 2007/12/03 20:51:10 aballier Exp $

inherit eutils

IUSE=""

DESCRIPTION="DVI to PDF translator with multi-byte character support"
HOMEPAGE="http://project.ktug.or.kr/dvipdfmx/"
SRC_URI="http://project.ktug.or.kr/dvipdfmx/snapshot/current/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

RDEPEND="virtual/tex-base
	virtual/ghostscript
	>=media-libs/libpng-1.2.1
	>=sys-libs/zlib-1.1.4
	app-text/libpaper
	!<app-text/texlive-core-2007-r10"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

has_tetex_3() {
	if has_version '>=app-text/tetex-3' || has_version '>=app-text/ptex-3.1.8' || has_version '>=app-text/texlive-core-2007' ; then
		true
	else
		false
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die

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
