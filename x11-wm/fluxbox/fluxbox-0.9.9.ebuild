# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fluxbox/fluxbox-0.9.9.ebuild,v 1.14 2004/07/26 13:37:19 usata Exp $

inherit eutils

IUSE="nls xinerama truetype kde gnome"

DESCRIPTION="Fluxbox is a lightweight windowmanager for X featuring tabs."
SRC_URI="mirror://sourceforge/fluxbox/${P}.tar.gz"
HOMEPAGE="http://www.fluxbox.org"

# Please note that USE="kde gnome" simply adds support for
# the respective protocols, and does not depend on external libraries.
RDEPEND="virtual/x11
	truetype? ( media-libs/freetype )
	nls? ( sys-devel/gettext )"
DEPEND=">=sys-devel/autoconf-2.52
		${RDEPEND}"
PROVIDE="virtual/blackbox"

SLOT="0"
LICENSE="MIT"
KEYWORDS="x86 ppc sparc amd64 alpha hppa ~ia64 mips ~ppc64 macos"

src_unpack() {
	unpack ${A}
	cd ${S}
	# upstream tell us we probably want to apply this if there's any chance
	# anyone will ever try to compile using gcc 3.4.
	epatch ${FILESDIR}/${PN}-0.9.9-gcc3.4.patch
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

