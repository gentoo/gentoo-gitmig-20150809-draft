# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/yp-tools/yp-tools-2.7.ebuild,v 1.10 2003/05/13 23:53:11 wwoods Exp $

S=${WORKDIR}/${P}
DESCRIPTION="NIS Tools"
SRC_URI="ftp://ftp.kernel.org/pub/linux/utils/net/NIS/${P}.tar.bz2"
HOMEPAGE="http://www.linux-nis.org/nis"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha ~ppc"

DEPEND="virtual/glibc"

src_compile() {
	local myconf="--sysconfdir=/etc/yp"
	use nls || myconf="${myconf} --disable-nls"
	econf ${myconf} || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING NEWS README THANKS TODO
	insinto /etc/yp ; doins etc/nicknames
	# This messes up boot so we remove it
	rm -d ${D}/bin/ypdomainname
	rm -d ${D}/bin/nisdomainname
	rm -d ${D}/bin/domainname
}
