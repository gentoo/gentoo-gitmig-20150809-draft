# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libiptcdata/libiptcdata-1.0.2.ebuild,v 1.10 2007/12/15 19:20:33 corsair Exp $

inherit eutils

DESCRIPTION="library for manipulating the International Press Telecommunications
Council (IPTC) metadata"
HOMEPAGE="http://libiptcdata.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc64 x86"
IUSE="doc nls python"

RDEPEND="python? ( dev-lang/python )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	doc? ( >=dev-util/gtk-doc-1 )"

src_compile () {
	econf $(use_enable nls) \
		$(use_enable python) \
		$(use_enable doc gtk-doc)
	emake || die "emake failed."
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
