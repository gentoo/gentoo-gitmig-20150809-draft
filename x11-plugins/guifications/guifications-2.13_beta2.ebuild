# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/guifications/guifications-2.13_beta2.ebuild,v 1.2 2006/05/08 18:53:00 seemant Exp $

MY_PN=gaim-${PN}
MY_PV=${PV/_beta/beta}
MY_P=${MY_PN}-${MY_PV}
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Guifications are graphical notification plugin for the open source instant message client gaim"
HOMEPAGE="http://guifications.sourceforge.net"
SRC_URI="mirror://sourceforge/guifications/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE="debug nls"

DEPEND="=net-im/gaim-2.0.0_beta2*"

src_compile() {
	local myconf
	use debug && myconf="${myconf} --enable-debug"
	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf} || die "econf failure"
	emake || die "emake failure"
}

src_install() {
	make install DESTDIR=${D} || die "make install failure"
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README TODO VERSION
}
