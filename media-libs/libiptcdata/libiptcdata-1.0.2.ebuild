# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libiptcdata/libiptcdata-1.0.2.ebuild,v 1.5 2007/10/08 07:58:01 corsair Exp $

inherit eutils

DESCRIPTION="library for manipulating the International Press Telecommunications
Council (IPTC) metadata"
HOMEPAGE="http://libiptcdata.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~ppc64 ~x86"
IUSE="doc nls python"

RDEPEND="python? ( dev-lang/python )
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	doc? ( >=dev-util/gtk-doc-1 )"

src_compile () {
	econf \
		$(use_enable nls) \
		$(use_enable python) \
		$(use_enable doc gtk-doc) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
