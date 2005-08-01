# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gtk-gnutella/gtk-gnutella-0.95.4.ebuild,v 1.1 2005/08/01 21:19:21 sekretarz Exp $

inherit eutils

IUSE="gnome gtk2 nls"

DESCRIPTION="A GTK+ Gnutella client"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://gtk-gnutella.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

DEPEND="dev-libs/libxml2
	gtk2? ( =dev-libs/glib-2* =x11-libs/gtk+-2* )
	!gtk2? ( =dev-libs/glib-1.2* =x11-libs/gtk+-1.2* )
	dev-util/yacc
	nls? ( >=sys-devel/gettext-0.11.5 )"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	local myconf

	if use gtk2; then
		myconf="-Dgtkversion=2"
	else
		myconf="-Dgtkversion=1"
	fi

	if use nls; then
		myconf="${myconf} -Dd_enablenls -Dgmsgfmt=\"/usr/bin/msgfmt\" -Dmsgfmt=\"/usr/bin/msgfmt\""
	else
		myconf="${myconf} -Ud_enablenls"
	fi

	./Configure -d -s -e \
		-Dprefix="/usr" \
		-Dprivlib="/usr/share/gtk-gnutella" \
		-Dccflags="${CFLAGS}" \
		${myconf} \
		-Doptimize=" " \
		-Dofficial="true" || die "Configure failed"

	emake || die "Compile failed"
}

src_install() {
	dodir /usr/bin
	make INSTALL_PREFIX=${D} install || die "Install failed"
	find ${D}/usr/share -type f -exec chmod a-x {} \;
	dodoc AUTHORS ChangeLog README TODO

}

