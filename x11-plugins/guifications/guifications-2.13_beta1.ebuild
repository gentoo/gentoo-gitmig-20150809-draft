# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/guifications/guifications-2.13_beta1.ebuild,v 1.1 2005/12/21 03:20:04 gothgirl Exp $

DESCRIPTION="Guifications are graphical notification plugin for the open source instant message client gaim"
HOMEPAGE="http://guifications.sourceforge.net"
MY_PV=${PV/_beta/beta}
SRC_URI="mirror://sourceforge/guifications/guifications-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE="debug nls"

DEPEND=">=net-im/gaim-2.0.0_beta1"
#RDEPEND=""

S="${WORKDIR}/guifications-2.13beta1"

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
