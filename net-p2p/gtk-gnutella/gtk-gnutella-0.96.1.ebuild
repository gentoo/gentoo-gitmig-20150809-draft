# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gtk-gnutella/gtk-gnutella-0.96.1.ebuild,v 1.1 2006/04/23 04:39:01 squinky86 Exp $

inherit eutils

IUSE="gnome nls dbus"

DESCRIPTION="A GTK+ Gnutella client"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://gtk-gnutella.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

DEPEND="dev-libs/libxml2
	dev-util/yacc
	dbus? ( sys-apps/dbus )
	nls? ( >=sys-devel/gettext-0.11.5 )"

src_compile() {
	local myconf

	if use nls; then
		myconf="${myconf} -Dd_enablenls -Dgmsgfmt=\"/usr/bin/msgfmt\" -Dmsgfmt=\"/usr/bin/msgfmt\""
	else
		myconf="${myconf} -Ud_enablenls"
	fi

	if use dbus; then
		myconf="${myconf} -Ddbus=true"
	else
		myconf="${myconf} -Ddbus=false"
	fi

	./Configure -d -s -e \
		-Dprefix="/usr" \
		-Dprivlib="/usr/share/gtk-gnutella" \
		-Dccflags="${CFLAGS}" \
		-Dgtkversion=2 \
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
