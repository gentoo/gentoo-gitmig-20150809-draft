# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gtk-gnutella/gtk-gnutella-0.96.3.ebuild,v 1.6 2007/01/04 11:36:50 kloeri Exp $

inherit eutils

#TODO: headless mode (but not very well tested yet, may still be too hardcore)
IUSE="nls dbus gnutls sqlite3"

DESCRIPTION="A GTK+ Gnutella client"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://gtk-gnutella.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc sparc x86"

DEPEND="dev-libs/libxml2
	>=x11-libs/gtk+-2.0.0
	dbus? ( sys-apps/dbus )
	gnutls? ( net-libs/gnutls )
	sqlite3? ( >=dev-db/sqlite-3.3.0 )
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

	if ! use gnutls; then
		myconf="${myconf} -U d_gnutls"
	fi

	if ! use sqlite3; then
		myconf="${myconf} -U d_sqlite"
	fi

	# yacc is not a dependency because the distribution includes the
	# generated files. The define below is to make Configure shut up
	# about yacc at all.
	./Configure -d -s -e \
		-Dprefix="/usr" \
		-Dprivlib="/usr/share/gtk-gnutella" \
		-Dccflags="${CFLAGS}" \
		-Dgtkversion=2 \
		${myconf} \
		-Doptimize=" " \
		-D yacc="yacc" \
		-Dofficial="true" || die "Configure failed"

	emake || die "Compile failed"
}

src_install() {
	dodir /usr/bin
	make INSTALL_PREFIX=${D} install || die "Install failed"
	find ${D}/usr/share -type f -exec chmod a-x {} \;
	dodoc AUTHORS ChangeLog README TODO
}
