# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-3.1.ebuild,v 1.1 2003/12/22 21:24:47 tseng Exp $

S=${WORKDIR}/${P/_/-}
DESCRIPTION="Openbox is a standards compliant, fast, light-weight, extensible window manager."

SRC_URI="http://icculus.org/openbox/releases/${P/_/-}.tar.gz
		mirror://gentoo/ob-themes-usability.tar.bz2"

HOMEPAGE="http://icculus.org/openbox/"
IUSE="nls"
SLOT="3"

DEPEND="virtual/xft
	virtual/x11
	>=dev-libs/glib-2
	>=media-libs/fontconfig-2
	>=dev-libs/libxml2-2.0"
RDEPEND=${DEPEND}

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

src_compile() {

	econf \
		`use_enable nls` || die
	emake || die
}

src_install () {

	dodir /etc/X11/Sessions
	echo "/usr/bin/openbox" > ${D}/etc/X11/Sessions/openbox
	fperms a+x /etc/X11/Sessions/openbox

	make DESTDIR=${D} install || die
	dodoc README AUTHORS ChangeLog TODO

	# Extra styles from http://home.clara.co.uk/dpb/openbox.htm
	# These are included due to the poor usability of the default themes
	# for users with limited vision. These are based on Jimmac's
	# Gorilla and Industrial themes for Metacity.

	dodir /usr/share/themes
	cp -a ${WORKDIR}/ob-themes-usability/* ${D}/usr/share/themes
}

pkg_postinst() {
	ewarn
	ewarn "The binary is now moved to /usr/bin/openbox."
	ewarn "Likewise for the session files."
	ewarn
}
