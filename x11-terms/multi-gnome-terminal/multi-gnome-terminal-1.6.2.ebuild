# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/multi-gnome-terminal/multi-gnome-terminal-1.6.2.ebuild,v 1.9 2004/09/03 07:31:38 lu_zero Exp $

IUSE="nls"

inherit libtool eutils

DESCRIPTION="Extended version of the Gnome Terminal."
SRC_URI="mirror://sourceforge/multignometerm/${P}.tar.bz2"
HOMEPAGE="http://multignometerm.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~amd64"

DEPEND="=x11-libs/gtk+-1*
	>=gnome-base/gnome-libs-1.4.1.7
	>=media-libs/gdk-pixbuf-0.11.0-r1
	=gnome-base/libglade-0*
	>=app-text/scrollkeeper-0.3.10-r1
	=gnome-base/orbit-0*"

RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-gcc-3.4.patch"

}
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

