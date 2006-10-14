# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/liboil/liboil-0.3.8-r1.ebuild,v 1.3 2006/10/14 20:36:33 vapier Exp $

inherit eutils

DESCRIPTION="library of simple functions that are optimized for various CPUs"
HOMEPAGE="http://www.schleef.org/liboil/"
SRC_URI="http://www.schleef.org/${PN}/download/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0.3"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh -sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="=dev-libs/glib-2*"

src_compile() {
	econf $(use_enable doc gtk-doc) || die "econf failed"
	emake CFLAGS="-O2 -g" -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
