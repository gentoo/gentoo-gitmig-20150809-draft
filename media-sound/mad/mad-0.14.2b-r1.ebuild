# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/mad/mad-0.14.2b-r1.ebuild,v 1.3 2002/07/11 06:30:40 drobbins Exp $

S=${WORKDIR}/${P}
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

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
