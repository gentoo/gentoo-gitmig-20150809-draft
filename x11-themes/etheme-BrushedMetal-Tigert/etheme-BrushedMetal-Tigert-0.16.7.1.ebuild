# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/etheme-BrushedMetal-Tigert/etheme-BrushedMetal-Tigert-0.16.7.1.ebuild,v 1.9 2005/03/30 16:44:02 hansmi Exp $

MY_PV="0.02"
MY_PN="${PN/etheme-}"
DESCRIPTION="${MY_PN} theme for Enlightenment 16.7"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/enlightenment-theme-${MY_PN}-0.16-${MY_PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
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
