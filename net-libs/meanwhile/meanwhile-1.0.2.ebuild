# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/meanwhile/meanwhile-1.0.2.ebuild,v 1.13 2007/01/04 22:48:55 flameeyes Exp $


DESCRIPTION="Meanwhile (Sametime protocol) library"
HOMEPAGE="http://meanwhile.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
IUSE="doc debug"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"

RDEPEND=">=dev-libs/glib-2"

DEPEND="${RDEPEND}
	dev-libs/gmp
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_compile() {
	local myconf
	use doc || myconf="${myconf} --enable-doxygen=no"

	econf ${myconf} \
		$(use_enable debug) || die "Configuration failed"
	emake || die "Make failed"

}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
