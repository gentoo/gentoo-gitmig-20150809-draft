# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Matthew Kennedy <mbkennedy@ieee.com>
# Maintainer: Chris Houser <chouser@gentoo.org>

DESCRIPTION="A GUI for mkisofs/mkhybrid/cdda2wav/cdrecord/cdlabelgen"
HOMEPAGE="http://www.abo.fi/~jmunsin/gcombust/"

DEPEND="=x11-libs/gtk+-1.2*
	nls? ( sys-devel/gettext )"

SLOT="0"
SRC_URI="http://www.abo.fi/~jmunsin/gcombust/${P}.tar.gz"
S=${WORKDIR}/${P}

src_compile() {
	local myopts

	if [ -z "`use nls`" ] 
	then
		myopts="${myopts} --disable-nls"
	else
		myopts="${myopts} --enable-nls"
	fi

	./configure --host=${CHOST} \
		--prefix=/usr \
		${myopts} \
		|| die
	emake || die
}

src_install() {
	make prefix=${D}/usr install || die
	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING INSTALL NEWS README THANKS TODO
	dohtml -a shtml FAQ.shtml
}
