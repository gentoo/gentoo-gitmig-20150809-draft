# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-terms/multi-gnome-terminal/multi-gnome-terminal-1.5.1.ebuild,v 1.2 2002/08/05 09:24:33 seemant Exp $

S=${WORKDIR}/${P/_rc?}
DESCRIPTION="Extended version of the Gnome Terminal."
SRC_URI="http://belnet.dl.sourceforge.net/sourceforge/multignometerm/${P}.tar.bz2"
HOMEPAGE="http://multignometerm.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1.2*
	>=gnome-base/gnome-libs-1.4.1.2-r1
	>=media-libs/gdk-pixbuf-0.11.0-r1
	>=gnome-base/libglade-0.17-r1
	<gnome-base/libglade-1.99
	>=app-text/scrollkeeper-0.3.10-r1
	>=gnome-base/ORBit-0.5.10-r1
	nls? ( sys-devel/gettext )"

src_compile() {

	local myconf=""

	use nls && ( \
		myconf="${myconf} --disable-nls"
		touch ${S}/intl/libgettext.h
	)
		
	econf ${myconf} || die
	emake || die
}

src_install() {

	cp ${S}/omf-install/Makefile ${S}/omf-install/Makefile.orig
	sed -e "s:scrollkeeper-update.*::g" ${S}/omf-install/Makefile.orig \
		> ${S}/omf-install/Makefile

	einstall || die

	insinto /usr/share/pixmaps
	doins pixmaps/multignometerm.png

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README
}

pkg_postinst() {

#	echo
#	echo "********************************************************************"
#	echo "*  Please note that the shortcut keys to create a new shell is not *"
#	echo '*  "ctrl-l n" like stated in the docs, but "ctrl-F1 n".            *'
#	echo "********************************************************************"
#	echo
	
	echo ">>> Updating Scrollkeeper database..."
	scrollkeeper-update >/dev/null 2>&1
}

pkg_postrm() {
	echo ">>> Updating Scrollkeeper database..."
	scrollkeeper-update >/dev/null 2>&1
}
