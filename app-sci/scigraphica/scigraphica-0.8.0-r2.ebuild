# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/scigraphica/scigraphica-0.8.0-r2.ebuild,v 1.1 2004/01/04 20:49:18 george Exp $

DESCRIPTION="Scientific application for data analysis and technical graphics"
SRC_URI="http://scigraphica.sourceforge.net/src/${P}.tar.gz"
HOMEPAGE="http://scigraphica.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gnome"

DEPEND=">=x11-libs/gtk+extra-0.99.17
	=dev-python/pygtk-0.6*
	>=dev-python/numeric-20.3
	>=dev-libs/libxml-1.8.16
	>=media-libs/imlib-1.9.14
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r3 >=gnome-base/ORBit-0.5.12-r1 >=gnome-base/gnome-print-0.34 )"
	#bonobo? ( >=gnome-base/bonobo-1.0.18 )"

pkg_setup() {
	if has_version ">=dev-python/pygtk-0.99"; then
		eerror "Setup has detected that you have >=dev-python/pygtk-0.99 installed"
		eerror "on yor system. This will conflict with the required pygtk-0.6"
		ewarn "Therefore"
		ewarn 'Please "emerge unmerge pygtk",  then'
		ewarn '"emerge scigraphica; run it once, and then remerge pygtk version'
		ewarn 'you had (best accomplished by running "emerge -u --deep world")'
		die
	fi
}

src_compile() {
	#bonobo breaks compile when enabled so it is not enabled for now.
	#the result seems to be no printing under gnome.
	#also need to look into --with-lp and --with-lpr config flags

	local myconf=""
	use gnome || myconf="${myconf} --without-gnome" #default enabled
#	use bonobo && myconf="${myconf} --with-bonobo" #default disabled

	#fix Exec= in sg.desktop
	cp sg.desktop sg.desktop.orig
	sed -e 's:\(Exec=\)sga:\1scigraphica:' sg.desktop.orig > sg.desktop

	#fix termcap dependency
	cp configure configure.orig
	sed -e 's:-ltermcap:-lncurses:' configure.orig > configure

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "Configuration Failed"

	emake || die "Parallel Make Failed"
}

src_install() {
	make DESTDIR=${D} install || die "Installation Failed"
	dodoc AUTHORS ChangeLog FAQ.compile \
		INSTALL NEWS README TODO
}

pkg_postinst() {
	ewarn "Please, if you need to remerge pygtk-2* afterwards, do not forget to run scigraphica"
	ewarn "as your intended user once before that!"
	ewarn "You may also want to remove ~/.scigpahica/config first."
}
