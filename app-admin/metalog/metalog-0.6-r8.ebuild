# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry A! <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/metalog/metalog-0.6-r8.ebuild,v 1.1 2002/01/26 15:23:31 aeoo Exp $

GFILESDIR=${PORTDIR}/app-admin/metalog/files
S=${WORKDIR}/${P}
DESCRIPTION="A highly configurable replacement for syslogd/klogd"
SRC_URI="http://prdownloads.sourceforge.net/metalog/${P}.tar.gz"
HOMEPAGE="http://metalog.sourceforge.net/"

DEPEND="virtual/glibc
	>=dev-libs/libpcre-3.4"


src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	cat ${GFILESDIR}/metalog-0.6-gentoo.patch | patch -p0 || die
	cd ${S}/src
	mv metalog.h metalog.h.orig
	sed -e "s:/etc/metalog.conf:/etc/metalog/metalog.conf:g" \
        	metalog.h.orig > metalog.h
}

src_compile() {
	./configure --prefix=/usr --mandir=/usr/share/man || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	insinto /etc/metalog
	doins metalog.conf 

	exeinto /etc/init.d
	newexe ${FILESDIR}/metalog.rc6 metalog

	dodoc AUTHORS COPYING ChangeLog README
	newdoc metalog.conf metalog.conf.sample
}
