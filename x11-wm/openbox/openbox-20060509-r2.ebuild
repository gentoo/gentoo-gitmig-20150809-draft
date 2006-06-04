# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-20060509-r2.ebuild,v 1.1 2006/06/04 01:03:03 anarchy Exp $

inherit eutils autotools

DESCRIPTION="Openbox is a standards compliant, fast, light-weight, extensible window manager."
HOMEPAGE="http://icculus.org/openbox/"
SRC_URI="mirror://gentoo/${P}.tar.gz
	mirror://gentoo/ob-themes-usability.tar.bz2"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="pango nls startup-notification xinerama gtk"

RDEPEND="|| ( ( x11-libs/libXrandr
		x11-libs/libXt
		xinerama? ( x11-libs/libXinerama )
		)
		virtual/x11
	)
	virtual/xft
	>=dev-libs/glib-2
	>=media-libs/fontconfig-2
	>=dev-libs/libxml2-2.0
	gtk? ( >=x11-libs/gtk+-2 )"
DEPEND="${RDEPEND}
	|| ( (
		xinerama? ( x11-proto/xineramaproto )
		x11-proto/xextproto
		x11-proto/xf86vidmodeproto
		)
		virtual/x11
	 )
	pango? ( x11-libs/pango )
	startup-notification? ( x11-libs/startup-notification )
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-asneeded.patch
	epatch ${FILESDIR}/${P}-hideMenuHeader.patch
	epatch ${FILESDIR}/${P}-pipedsplitgradient.patch
	epatch ${FILESDIR}/${P}-gtkcolors.patch

	AT_M4DIR="m4" \
	eautoreconf || die "failed running eautoreconf"
}

src_compile() {
	econf `use_enable nls` `use_enable pango` `use_enable startup-notification` `use_enable gtk` ${myconf} || die "failed running configure"
	emake || die "failed running make"
}

src_install() {
	dodir /etc/X11/Sessions
	echo "/usr/bin/openbox" > ${D}/etc/X11/Sessions/openbox
	fperms a+x /etc/X11/Sessions/openbox

	insinto /usr/share/xsessions
	doins ${FILESDIR}/${PN}.desktop

	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS AUTHORS CHANGELOG COMPLIANCE COPYING README

	insinto /usr/share/themes
	doins -r ${WORKDIR}/ob-themes-usability/*
}
