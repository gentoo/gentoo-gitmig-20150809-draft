# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-3.3_rc1-r2.ebuild,v 1.2 2005/08/24 14:33:11 flameeyes Exp $

inherit eutils

DESCRIPTION="Openbox is a standards compliant, fast, light-weight, extensible window manager."
HOMEPAGE="http://icculus.org/openbox/"
SRC_URI="http://icculus.org/openbox/releases/${P/_/-}.tar.gz
	mirror://gentoo/ob-themes-usability.tar.bz2"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
IUSE="pango nls startup-notification"

RDEPEND="virtual/xft
	virtual/x11
	>=dev-libs/glib-2
	>=media-libs/fontconfig-2
	>=dev-libs/libxml2-2.0"
DEPEND="${RDEPEND}
	pango? ( x11-libs/pango )
	startup-notification? ( x11-libs/startup-notification )
	dev-util/pkgconfig"

S=${WORKDIR}/${P/_/-}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-3.2-makefile.patch
}

src_compile() {
	if use pango ; then
		myconf="--enable-pango"
	else
		myconf=""
	fi
	econf `use_enable nls` ${myconf} || die
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
	dodoc ABOUT-NLS AUTHORS CHANGELOG COMPLIANCE COPYING README

	# Extra styles from http://home.clara.co.uk/dpb/openbox.htm
	# These are included due to the poor usability of the default themes
	# for users with limited vision. These are based on Jimmac's
	# Gorilla and Industrial themes for Metacity.

	dodir /usr/share/themes
	cp -pPR ${WORKDIR}/ob-themes-usability/* ${D}/usr/share/themes
}
