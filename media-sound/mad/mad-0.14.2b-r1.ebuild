# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/mad/mad-0.14.2b-r1.ebuild,v 1.1 2002/03/12 22:44:18 seemant Exp $

S=${WORKDIR}/${P}
SRC_URI="http://prdownloads.sourceforge.net/${PN}/${P}.tar.gz"

HOMEPAGE="http://mad.sourceforge.net/"
DESCRIPTION="A high-quality MP3 decoder"

DEPEND="sys-devel/gcc 
		virtual/glibc 
		sys-devel/ld.so
		nls? ( sys-devel/gettext )"
RDEPEND="virtual/glibc sys-devel/ld.so"

src_compile() {
	confopts="--infodir=/usr/share/info --mandir=/usr/share/man \
			  --prefix=/usr --host=${CHOST} --enable-static \
			  --disable-debugging --enable-shared --enable-fpm=intel"

	use nls || confopts="${confopts} --disable-nls"

	./configure ${confopts} || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
