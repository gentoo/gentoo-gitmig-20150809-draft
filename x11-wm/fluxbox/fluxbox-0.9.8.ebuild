# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fluxbox/fluxbox-0.9.8.ebuild,v 1.2 2004/01/15 16:14:52 cybersystem Exp $

IUSE="nls xinerama truetype kde gnome"

DESCRIPTION="Fluxbox is a lightweight windowmanager for X featuring tabs."
SRC_URI="mirror://sourceforge/fluxbox/${P}.tar.gz"
HOMEPAGE="http://www.fluxbox.org"

# Please note that USE="kde gnome" simply adds support for
# the respective protocols, and does not depend on external libraries.
DEPEND=">=sys-devel/autoconf-2.52
		${RDEPEND}"
RDEPEND="virtual/x11
	truetype? ( media-libs/freetype )
	nls? ( sys-devel/gettext )"
PROVIDE="virtual/blackbox"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc"

src_compile() {
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

	dodir /etc/X11/Sessions
	echo "/usr/bin/startfluxbox" > ${D}/etc/X11/Sessions/fluxbox
	fperms a+x /etc/X11/Sessions/fluxbox
}

pkg_postinst() {
	ewarn
	ewarn "Please note that this release no longer uses commonbox.eclass"
	ewarn "and now installs data files in /usr/share/fluxbox."
	ewarn
	einfo "This ebuild now creates an /etc/X11/Sessions entry."
	einfo
}

