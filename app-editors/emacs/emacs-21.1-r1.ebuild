# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Mikael Hallendal <micke@hallendal.net>
# $Header: /var/cvsroot/gentoo-x86/app-editors/emacs/emacs-21.1-r1.ebuild,v 1.1 2002/01/18 22:06:57 hallski Exp $


S=${WORKDIR}/${P}
DESCRIPTION="An incredibly powerful, extensible text editor"
SRC_URI="ftp://ftp.codefactory.se/pub/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/emacs"

DEPEND=">=sys-libs/ncurses-5.2
	sys-libs/gdbm
	X? ( 	virtual/x11
		>=media-libs/libungif-4.1.0 
		>=media-libs/jpeg-6b-r2 
		>=media-libs/tiff-3.5.5-r3 
		>=media-libs/libpng-1.0.9 ) 
	motif? ( >=x11-libs/openmotif-2.1.30 ) 
	nls? ( >=sys-devel/gettext-0.10.35 )"

PROVIDE="virtual/emacs"

src_compile() {
	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="${myconf} --disable-nls"
	fi 

	if [ "`use X`" ] ; then
		myconf="${myconf} \
			--with-x \
			--with-xpm \
			--with-jpeg \
			--with-tiff \
			--with-gif \
			--with-png"
	else
		myconf="${myconf} --without-x"
	fi

	if [ "`use motif`" ] ; then
		myconf="${myconf} --with-x-toolkit=motif"
	fi

	./configure	--host=${CHOST} \
			--prefix=/usr \
			--libexecdir=/usr/lib \
			--mandir=/usr/share/man \
			--infodir=/usr/share/info \
			${myconf} || die

	emake || die
}

src_install () {
	make 	prefix=${D}/usr \
		libexecdir=${D}/usr/lib \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	cd ${D}/usr/share/info
	rm dir

	for i in *
	do
		mv ${i%.info} $i.info
	done

	dodoc BUGS ChangeLog README
}
