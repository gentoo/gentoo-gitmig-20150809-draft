# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/emacs-cvs/emacs-cvs-21.3.50.ebuild,v 1.9 2003/04/16 17:14:53 mkennedy Exp $

ECVS_SERVER="subversions.gnu.org:/cvsroot/emacs"
ECVS_MODULE="emacs"
ECVS_USER="anoncvs"
ECVS_CVS_OPTIONS="-dP"

inherit cvs

IUSE="X nls gtk gtk2 Xaw3d gnome" 

S=${WORKDIR}/${ECVS_MODULE}
DESCRIPTION="Emacs is the extensible, customizable, self-documenting real-time display editor."
SRC_URI=""
HOMEPAGE="http://www.gnu.org/software/emacs"

# Never use the sandbox, it causes Emacs to segfault on startup
SANDBOX_DISABLED="1"

DEPEND=">=sys-libs/ncurses-5.3
	sys-libs/gdbm
	dev-util/cvs
	dev-python/pexpect
	app-text/ispell
	X? ( virtual/x11
		>=media-libs/libungif-4.1.0.1b
		>=media-libs/jpeg-6b
		>=media-libs/tiff-3.5.7
		>=media-libs/libpng-1.2.5 )
	gtk? ( =x11-libs/gtk+-2* )
	gtk2? ( =x11-libs/gtk+-2* )
	Xaw3d? ( x11-libs/Xaw3d )
	gnome? ( gnome-base/gnome-desktop )
	nls? ( >=sys-devel/gettext-0.11.5 )"

PROVIDE="virtual/emacs virtual/editor"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

DFILE=emacs.desktop

src_compile() {
	local myconf

	use nls || myconf="${myconf} --disable-nls"

	if use X ;
	then 
		myconf="${myconf} 
			--with-x 
			--with-xpm 
			--with-jpeg 
			--with-tiff 
			--with-gif 
			--with-png"
		if use gtk || use gtk2
		then 
			myconf="${myconf} --with-x-toolkit=gtk 
				--with-gtk
				--with-toolkit-scroll-bars"
		elif use Xaw3d
		then 
			myconf="${myconf} --with-x-toolkit=athena 
				--with-toolkit-scroll-bars"
		fi
	else
		myconf="${myconf} --without-x"
	fi

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
	find ${D}/usr/share/info -type f -exec echo mv {} {}.info \;

	dodoc BUGS ChangeLog README

	if use gnome
	then
		insinto /usr/share/gnome/apps/Application
		doins ${FILESDIR}/${DFILE}
	fi

}
