# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/meanwhile/meanwhile-0.4.2.ebuild,v 1.8 2006/02/07 01:12:20 agriffis Exp $

DESCRIPTION="Meanwhile (Sametime protocol) library"
HOMEPAGE="http://meanwhile.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2"

SLOT="0"
KEYWORDS="alpha ~amd64 ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
