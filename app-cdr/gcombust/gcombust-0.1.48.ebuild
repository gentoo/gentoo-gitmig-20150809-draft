# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Matthew Kennedy <mbkennedy@ieee.com>
# Maintainer: Chris Houser <chouser@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gcombust/gcombust-0.1.48.ebuild,v 1.1 2002/02/05 04:05:35 chouser Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A GUI for mkisofs/mkhybrid/cdda2wav/cdrecord/cdlabelgen"
SRC_URI="http://www.abo.fi/~jmunsin/gcombust/${P}.tar.gz"
HOMEPAGE="http://www.abo.fi/~jmunsin/gcombust/"

DEPEND=">=x11-libs/gtk+-1.2.10"

src_compile() {
	./configure --host=${CHOST} --prefix=/usr || die
	emake || die
}

src_install() {
	make prefix=${D}/usr install || die
	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING INSTALL NEWS README THANKS TODO
	dohtml -a shtml FAQ.shtml
}
