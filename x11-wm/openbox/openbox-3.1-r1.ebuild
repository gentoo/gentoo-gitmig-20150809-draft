# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-3.1-r1.ebuild,v 1.3 2004/03/20 19:36:35 zx Exp $

S=${WORKDIR}/${P/_/-}
DESCRIPTION="Openbox is a standards compliant, fast, light-weight, extensible window manager."

SRC_URI="http://icculus.org/openbox/releases/${P/_/-}.tar.gz
		mirror://gentoo/ob-themes-usability.tar.bz2"

HOMEPAGE="http://icculus.org/openbox/"
IUSE="nls"
SLOT="3"

RDEPEND="virtual/xft
	virtual/x11
	>=dev-libs/glib-2
	>=media-libs/fontconfig-2
	>=dev-libs/libxml2-2.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc amd64 ~hppa"

src_compile() {

	econf \
		`use_enable nls` || die
	emake || die
}

src_install () {

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
