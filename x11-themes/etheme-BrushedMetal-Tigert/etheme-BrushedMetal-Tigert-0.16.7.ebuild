# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/etheme-BrushedMetal-Tigert/etheme-BrushedMetal-Tigert-0.16.7.ebuild,v 1.3 2004/06/24 23:24:57 agriffis Exp $

DESCRIPTION="${PN/etheme-} theme for Enlightenment 16.7"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/${PN}-0.16-0.01.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64"
IUSE=""

DEPEND=">=x11-wm/enlightenment-0.16.7_pre1"

S=${WORKDIR}/${PN}-0.16

src_compile() {
	econf --enable-fsstd || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README
}
