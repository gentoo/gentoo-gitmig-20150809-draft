# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gtk-gnutella/gtk-gnutella-0.91.9.ebuild,v 1.1 2003/02/28 04:37:54 lostlogic Exp $

IUSE="gnome"

S=${WORKDIR}/${P}
DESCRIPTION="A GTK+ Gnutella client"
#SRC_URI="gtk2?mirror://sourceforge/${PN}/${PN}-GTK2-${PV}.tar.gz
#	 !gtk2?mirror://sourceforge/${PN}/${PN}-GTK1-${PV}.tar.gz"
SRC_URI="mirror://sourceforge/${PN}/${PN}-GTK1-${PV}.tar.gz"
HOMEPAGE="http://gtk-gnutella.sourceforge.net/"

SLOT="0"
LICENSE="GPL"
KEYWORDS="~x86 ~ppc ~sparc"

#DEPEND="( gtk2? =x11-libs/gtk+-2* : =x11-libs/gtk+-1.2* )
#	 ( gtk2? =dev-libs/glib-2* : =dev-libs/glib-1.2* )"
DEPEND="=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*"

src_unpack() {
	unpack ${A}
#	if [ `use gtk2` ]; then
#		einfo "Using GTK2"
#		mv ${PN}-GTK2-${PV} ${P}
#	else
		einfo "Using GTK1"
		mv ${PN}-GTK1-${PV} ${P}
#	fi
}

src_compile() {
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
