# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-p2p/teknap/teknap-1.3g.ebuild,v 1.2 2002/06/25 11:12:27 bangert Exp $

MY_P=TekNap-${PV}
S=${WORKDIR}/TekNap
DESCRIPTION="TekNap is a console Napster/OpenNap client"
SRC_URI="ftp://ftp.teknap.com/pub/TekNap/${MY_P}.tar.gz"
HOMEPAGE="http://www.TekNap.com/"
SLOT="0"

DEPEND="virtual/glibc >=sys-libs/ncurses-5.2
		gtk? ( =x11-libs/gtk+-1.2* )
		tcpd? ( sys-apps/tcp-wrappers )
		xmms? ( media-sound/xmms )"

src_compile() {
	local myconf
	if [ "`use gtk`" ] ; then
		myconf="--with-gtk"
	fi
	if [ "`use tcpd`" ] ; then
		myconf="${myconf} --enable-wrap"
	fi
	if [ "`use xmms`" ] ; then
		myconf="${myconf} --enable-xmms"
	fi
	if [ "`use ipv6`" ] ; then
		myconf="${myconf} --enable-ipv6"
	fi

	myconf="${myconf} --enable-cdrom"

	econf ${myconf} || die
	make || die

}

src_install () {

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		datadir=${D}/usr/share/TekNap \
		install || die
	rm ${D}/usr/bin/TekNap
	dosym TekNap-1.3f /usr/bin/TekNap
	dodoc COPYRIGHT README TODO Changelog
	docinto txt
	cd doc
	dodoc *.txt TekNap.faq bugs link-guidelines macosx.notes
	doman TekNap.1
}

