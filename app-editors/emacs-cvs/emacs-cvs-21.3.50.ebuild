# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/emacs-cvs/emacs-cvs-21.3.50.ebuild,v 1.5 2003/01/06 10:41:54 seemant Exp $

ECVS_SERVER="subversions.gnu.org:/cvsroot/emacs"
ECVS_MODULE="emacs"
ECVS_USER="anoncvs"
ECVS_CVS_OPTIONS="-dP"

inherit cvs

# leim integrated with emacs now
IUSE="X nls" 

S=${WORKDIR}/${ECVS_MODULE}
DESCRIPTION="An incredibly powerful, extensible text editor (latest CVS)"
SRC_URI=""
HOMEPAGE="http://www.gnu.org/software/emacs"

# Never use the sandbox, it causes Emacs to segfault on startup
SANDBOX_DISABLED="1"

DEPEND=">=sys-libs/ncurses-5.3
	sys-libs/gdbm
	dev-util/cvs
	X? ( virtual/x11
		>=media-libs/libungif-4.1.0
		>=media-libs/jpeg-6b
		>=media-libs/tiff-3.5.7
		>=media-libs/libpng-1.2.5
		>=x11-libs/Xaw3d-1.5-r1 )
	nls? ( >=sys-devel/gettext-0.11.5 )"

PROVIDE="virtual/emacs virtual/editor"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc "

src_compile() {
	local myconf

	use nls || myconf="${myconf} --disable-nls"

	use X && myconf="${myconf} 
			--with-x 
			--with-xpm 
			--with-jpeg 
			--with-tiff 
			--with-gif 
			--with-png 
			--with-toolkit-scroll-bars 
			--with-x-toolkit=athena" \
		|| myconf="${myconf} --without-x"

	myconf="${myconf} --with-toolkit-scroll-bars --with-x-toolkit=athena"

	./configure --host=${CHOST} \
		--prefix=/usr \
		--libexecdir=/usr/lib \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		${myconf} || die

	make bootstrap || die
}

src_install () {
	make prefix=${D}/usr \
		libexecdir=${D}/usr/lib \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	# fix info documentation
	find ${D}/usr/share/info -type f -print |\
		while read i
		do
			mv ${i} ${i}.info
		done
	

	dodoc BUGS ChangeLog README
}
