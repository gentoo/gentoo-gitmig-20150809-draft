# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/mutt/mutt-1.3.25.ebuild,v 1.1 2002/01/03 18:52:42 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a small but very powerful text-based mail client"
SRC_URI="ftp://ftp.mutt.org/pub/mutt/mutt-${PV}i.tar.gz"
HOMEPAGE="http://www.mutt.org"

DEPEND="virtual/glibc nls? ( sys-devel/gettext ) >=sys-libs/ncurses-5.2 slang? ( >=sys-libs/slang-1.4.2 ) ssl? ( >=dev-libs/openssl-0.9.6 )"
RDEPEND="virtual/glibc >=sys-libs/ncurses-5.2 slang? ( >=sys-libs/slang-1.4.2 ) ssl? ( >=dev-libs/openssl-0.9.6 )" 

src_compile() {
	local myconf
	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi
	if [ "`use ssl`" ] ; then
		myconf="$myconf --with-ssl"
	fi
	if [ "`use slang`" ] ; then
		myconf="$myconf --with-slang"
	fi
	./configure --prefix=/usr --sysconfdir=/etc/mutt --host=${CHOST} --with-regex  --enable-pop --enable-imap --enable-nfs-fix --with-homespool=Maildir $myconf || die
	cp doc/Makefile doc/Makefile.orig
	sed 's/README.UPGRADE//' doc/Makefile.orig > doc/Makefile
	make || die
}

src_install () {
	cd ${S}
	make DESTDIR=${D} install || die
	dodir /usr/share/doc/${PVF}
    mv ${D}/usr/doc/mutt/* ${D}/usr/share/doc/${PVF}
    mv ${D}/usr/man ${D}/usr/share
	rm -rf ${D}/usr/doc/mutt
    gzip ${D}/usr/share/doc/${PVF}/html/*
    gzip ${D}/usr/share/doc/${PVF}/samples/*
    gzip ${D}/usr/share/doc/${PVF}/*
	insinto /etc/mutt
	doins ${FILESDIR}/Muttrc*
}
