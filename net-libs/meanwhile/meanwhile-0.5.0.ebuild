# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/meanwhile/meanwhile-0.5.0.ebuild,v 1.4 2006/07/22 22:23:39 psi29a Exp $

inherit debug

IUSE="doc debug"

DESCRIPTION="Meanwhile (Sametime protocol) library"
HOMEPAGE="http://meanwhile.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2"

DEPEND="${RDEPEND}
	dev-libs/gmp
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_compile() {

	local myconf
	use doc || myconf="${myconf} --enable-doxygen=no"
	use debug && myconf="${myconf} --enable-debug"

	econf ${myconf} || die "Configuration failed"
	emake || die "Make failed"

}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
