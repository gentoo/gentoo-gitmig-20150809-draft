# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-news/yencode/yencode-0.46.ebuild,v 1.3 2002/07/11 06:30:49 drobbins Exp $

S=${WORKDIR}/${P}
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/yencode/${P}.tar.gz"
HOMEPAGE="http://www.yencode.org"
DESCRIPTION="yEnc encoder/decoder package"
DEPEND=""

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"

	./configure \
			--host=${CHOST} \
			--prefix=/usr \
			--infodir=/usr/share/info \
			--mandir=/usr/share/man \
			${myconf} || die "./configure failed"

	emake || die
}

src_install () {
	make \
			prefix=${D}/usr \
			mandir=${D}/usr/share/man \
			infodir=${D}/usr/share/info \
			install || die

	dodoc AUTHORS COPYING NEWS README ChangeLog
	doman doc/ydecode.1 doc/yencode.1 doc/ypost.1 doc/ypostrc.5
}
