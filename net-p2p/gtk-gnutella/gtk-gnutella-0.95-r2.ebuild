# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gtk-gnutella/gtk-gnutella-0.95-r2.ebuild,v 1.1 2005/09/20 18:00:05 mkay Exp $

inherit eutils

IUSE="gnome xml2 nls"

DESCRIPTION="A GTK+ Gnutella client"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://gtk-gnutella.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~alpha"

DEPEND="xml2? ( dev-libs/libxml2 )
	=dev-libs/glib-1.2* =x11-libs/gtk+-1.2*
	dev-util/yacc
	nls? ( >=sys-devel/gettext-0.11.5 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gtk2.6.patch
}

src_compile() {
	local myconf

	if use xml2; then
		myconf="${myconf} -Dd_libxml2"
	else
		myconf="${myconf} -Ud_libxml2"
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
		-Dgtkversion=1 \
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

	if use gnome; then
		insinto /usr/share/gnome/apps/Internet
		doins ${FILESDIR}/gtk-gnutella.desktop || die
	fi
}

pkg_postinst() {
	if ! use xml2; then
		ewarn "You have installed gtk-gnutella without xml2 support. As such, your"
		ewarn "search filters may not be saved when you quit the application."
		einfo "If you would like this feature enabled, re-emerge with USE=\"xml2\"."
		echo
	fi
}
