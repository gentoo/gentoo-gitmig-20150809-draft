# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gtk-gnutella/gtk-gnutella-0.92_rc.ebuild,v 1.1 2003/06/04 02:16:31 lostlogic Exp $

IUSE="gnome"

MY_P=${P/_r}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A GTK+ Gnutella client"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
HOMEPAGE="http://gtk-gnutella.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

#DEPEND="( gtk2? ( =dev-libs/glib-2* =x11-libs/gtk+-2* )
#	      : ( =dev-libs/glib-1.2* =x11-libs/gtk+-1.2* ) )"
DEPEND="=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*"

src_compile() {
	
#	econf `use_enable gtk2`|| die "Configure failed"
	econf || die "Configure failed"
	emake || die "Make failed"
}

src_install () {

	einstall || die "Install failed"
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README TODO

	use gnome && ( \
		insinto /usr/share/gnome/apps/Internet
		doins ${FILESDIR}/gtk-gnutella.desktop
	)
}
