# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Matthew Kennedy <mbkennedy@ieee.com>
# Maintainer: Chris Houser <chouser@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gcombust/gcombust-0.1.48.ebuild,v 1.3 2002/05/23 06:50:08 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A GUI for mkisofs/mkhybrid/cdda2wav/cdrecord/cdlabelgen"
SRC_URI="http://www.abo.fi/~jmunsin/gcombust/${P}.tar.gz"
HOMEPAGE="http://www.abo.fi/~jmunsin/gcombust/"
SLOT="0"
DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {
	./configure --host=${CHOST} --prefix=/usr || die
	emake || die
}

src_install() {
	make prefix=${D}/usr install || die
	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING INSTALL NEWS README THANKS TODO
	dohtml -a shtml FAQ.shtml
}
