# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gtk-gnutella/gtk-gnutella-0.93.3.ebuild,v 1.1 2004/02/11 20:57:26 mholzer Exp $

IUSE="gnome gtk2 xml2 nls"

DESCRIPTION="A GTK+ Gnutella client"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://gtk-gnutella.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="xml2? ( dev-libs/libxml2 )
	( gtk2? ( =dev-libs/glib-2* =x11-libs/gtk+-2* )
	: ( =dev-libs/glib-1.2* =x11-libs/gtk+-1.2* ) )
	dev-util/yacc
	nls? ( >=sys-devel/gettext-0.11.5 )"

src_compile() {

	local myconf

	if [ `use gtk2` ]; then
		myconf="-Dgtkversion=2"
	else
		myconf="-Dgtkversion=1"
	fi

	if [ `use xml2` ]; then
		myconf="${myconf} -Dd_libxml2"
	else
		myconf="${myconf} -Ud_libxml2"
	fi

	if [ `use nls` ]; then
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

	use gnome && ( \
		insinto /usr/share/gnome/apps/Internet
		doins ${FILESDIR}/gtk-gnutella.desktop
	)
}

pkg_postinst() {

	if [ `use gtk2` ]; then
		ewarn "The GTK2 interface currently does not have a maintainer--not all"
		ewarn "options which are available in the GTK1 interface might have made"
		ewarn "it in the GTK2 interface.  The GTK2 interface also"
		ewarn "has a known bug which causes an invalid assertion if"
		ewarn "you select passive search"
		echo
	fi

	if [ ! `use xml2` ]; then
		ewarn "You have installed gtk-gnutella without xml2 support. As such, your"
		ewarn "search filters may not be saved when you quit the application."
		einfo "If you would like this feature enabled, re-emerge with USE=\"xml2\"."
		echo
	fi
}
