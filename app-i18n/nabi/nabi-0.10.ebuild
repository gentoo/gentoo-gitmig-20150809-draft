# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/nabi/nabi-0.10.ebuild,v 1.2 2004/01/25 14:34:48 jayskwak Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Simple Hanguk X Input Method"
HOMEPAGE="http://nabi.kldp.net/"
SRC_URI="http://download.kldp.net/nabi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=x11-libs/gtk+-2.2"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS
}

pkg_postinst() {
	einfo "You MUST add environment variable...                           "
	einfo "                                                               "
	einfo "export XMODIFIERS=\"@im=nabi\"                                 "
	einfo "export XIM_PROGRAM=/usr/bin/nabi // for /xinit.xinitrx.d/xinput"
	einfo "                                                               "
}
