# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fluxbox/fluxbox-0.9.10-r2.ebuild,v 1.3 2004/10/23 05:39:52 mr_bones_ Exp $

inherit eutils

IUSE="nls xinerama truetype kde gnome"

DESCRIPTION="Fluxbox is a lightweight windowmanager for X featuring tabs."
SRC_URI="mirror://sourceforge/fluxbox/${P}.tar.bz2"
HOMEPAGE="http://www.fluxbox.org"

# Please note that USE="kde gnome" simply adds support for the respective
# protocols, and does not depend on external libraries. They do, however,
# make the binary a fair bit bigger, so we don't want to turn them on unless
# the user actually wants them.

RDEPEND="virtual/x11
	truetype? ( media-libs/freetype )
	nls? ( sys-devel/gettext )"
DEPEND=">=sys-devel/autoconf-2.52
		${RDEPEND}"
PROVIDE="virtual/blackbox"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~alpha ~hppa ~ia64 ~mips ~ppc64 ~ppc-macos"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix crashy badness on amd64. Upstream sanctioned this, so we'll
	# apply it to everyone...
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-amd64-font-fix.patch

	# Other crash fixes. Pulled from -cvs upstream.
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-windowmenu-crash.patch
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-workspacemenu-crash.patch
}

src_compile() {
	export PKG_CONFIG_PATH=/usr/X11R6/lib/pkgconfig:/usr/lib/pkgconfig
	econf \
		`use_enable nls` \
		`use_enable xinerama` \
		`use_enable truetype xft` \
		`use_enable kde` \
		`use_enable gnome` \
		--sysconfdir=/etc/X11/${PN} \
		${myconf} || die "configure failed"

	emake || die "make failed"
}

src_install() {
	dodir /usr/share/fluxbox
	make DESTDIR=${D} install || die "make install failed"
	dodoc README* AUTHORS TODO* COPYING

	dodir /usr/share/xsessions
	insinto /usr/share/xsessions
	doins ${FILESDIR}/${PN}.desktop

	dodir /etc/X11/Sessions
	echo "/usr/bin/startfluxbox" > ${D}/etc/X11/Sessions/fluxbox
	fperms a+x /etc/X11/Sessions/fluxbox
}

