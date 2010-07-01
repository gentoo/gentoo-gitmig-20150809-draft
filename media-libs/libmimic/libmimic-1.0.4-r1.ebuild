# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmimic/libmimic-1.0.4-r1.ebuild,v 1.8 2010/07/01 12:40:53 fauli Exp $

EAPI="2"

DESCRIPTION="Video encoding/decoding library for the codec used by msn"
HOMEPAGE="http://farsight.sourceforge.net/"
SRC_URI="mirror://sourceforge/farsight/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ia64 ~ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="doc"

RDEPEND="dev-libs/glib:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_configure() {
	econf $(use_enable doc doxygen-docs)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"

	if use doc; then
		dohtml doc/api/html/* || die "dohtml failed"
	fi
}
