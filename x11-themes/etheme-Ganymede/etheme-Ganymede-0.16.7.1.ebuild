# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/etheme-Ganymede/etheme-Ganymede-0.16.7.1.ebuild,v 1.3 2004/07/23 17:43:33 tgall Exp $

MY_PV="0.02"
MY_PN="${PN/etheme-}"
DESCRIPTION="${MY_PN} theme for Enlightenment 16.7"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/enlightenment-theme-${MY_PN}-0.16-${MY_PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ppc64"
IUSE=""

DEPEND=">=x11-wm/enlightenment-0.16.7_pre3"

S=${WORKDIR}/enlightenment-theme-${MY_PN}-0.16

src_compile() {
	econf --enable-fsstd || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README
}
