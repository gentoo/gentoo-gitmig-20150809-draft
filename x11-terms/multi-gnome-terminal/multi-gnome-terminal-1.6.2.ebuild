# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/multi-gnome-terminal/multi-gnome-terminal-1.6.2.ebuild,v 1.1 2003/04/28 02:44:39 azarah Exp $

IUSE="nls"

inherit libtool

S="${WORKDIR}/${P/_rc?}"
DESCRIPTION="Extended version of the Gnome Terminal."
SRC_URI="mirror://sourceforge/multignometerm/${P}.tar.bz2"
HOMEPAGE="http://multignometerm.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND=">=x11-libs/gtk+-1.2.10
	<x11-libs/gtk+-2.0
	>=gnome-base/gnome-libs-1.4.1.7
	>=media-libs/gdk-pixbuf-0.11.0-r1
	>=gnome-base/libglade-0.17-r1
	<gnome-base/libglade-1.99
	>=app-text/scrollkeeper-0.3.10-r1
	>=gnome-base/ORBit-0.5.16"

RDEPEND="nls? ( sys-devel/gettext )"


src_compile() {

	elibtoolize

	local myconf=""
	use nls || myconf="--disable-nls"
		
	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --mandir=/usr/share/man \
		    --infodir=/usr/share/info \
		    --sysconfdir=/etc \
		    ${myconf} || die

	emake || die "Compilation failed"
}

src_install() {

	cp  ${S}/omf-install/Makefile ${S}/omf-install/Makefile.orig
	sed -e "s:scrollkeeper-update.*::g" \
	    ${S}/omf-install/Makefile.orig > ${S}/omf-install/Makefile

	# Remove the NO_XALF nonsense from the .desktop file
	cp ${S}/gnome-terminal/multi-gnome-terminal.desktop \
	   ${S}/gnome-terminal/mgt.desktop.old
	sed -e "s:NO_XALF ::" \
	    ${S}/gnome-terminal/mgt.desktop.old > \
		${S}/gnome-terminal/multi-gnome-terminal.desktop

	make DESTDIR=${D} install || die "Installation failed"

	dosym mgt/multignometerm.png /usr/share/pixmaps/multignometerm.png

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README
}

pkg_postinst() {

	echo ">>> Updating Scrollkeeper database..."
	scrollkeeper-update &>/dev/null
}

pkg_postrm() {

	echo ">>> Updating Scrollkeeper database..."
	scrollkeeper-update &>/dev/null
}

