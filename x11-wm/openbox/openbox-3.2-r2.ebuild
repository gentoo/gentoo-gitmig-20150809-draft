# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-3.2-r2.ebuild,v 1.9 2006/04/29 01:53:25 anarchy Exp $

inherit eutils

DESCRIPTION="Openbox is a standards compliant, fast, light-weight, extensible window manager."
HOMEPAGE="http://icculus.org/openbox/"
SRC_URI="http://icculus.org/openbox/releases/${P/_/-}.tar.gz
	mirror://gentoo/ob-themes-usability.tar.bz2"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="alpha amd64 hppa ppc sparc x86"
IUSE="nls startup-notification"

RDEPEND="|| ( ( x11-libs/libXrandr
		x11-libs/libXt
		xinerama? ( x11-libs/libXinerama )
		)
		virtual/x11
	)
	virtual/xft
	>=dev-libs/glib-2
	>=media-libs/fontconfig-2
	>=dev-libs/libxml2-2.0"

DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xextproto
		x11-proto/xf86vidmodeproto
		)
		virtual/x11
	 )
	startup-notification? ( x11-libs/startup-notification )
	dev-util/pkgconfig"

S=${WORKDIR}/${P/_/-}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-makefile.patch
}

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	dodir /etc/X11/Sessions
	echo "/usr/bin/openbox" > ${D}/etc/X11/Sessions/openbox
	fperms a+x /etc/X11/Sessions/openbox

	dodir /usr/share/xsessions
	insinto /usr/share/xsessions
	doins ${FILESDIR}/${PN}.desktop

	make DESTDIR=${D} install || die
	dodoc README AUTHORS ChangeLog TODO

	# Extra styles from http://home.clara.co.uk/dpb/openbox.htm
	# These are included due to the poor usability of the default themes
	# for users with limited vision. These are based on Jimmac's
	# Gorilla and Industrial themes for Metacity.

	dodir /usr/share/themes
	cp -a ${WORKDIR}/ob-themes-usability/* ${D}/usr/share/themes
}
