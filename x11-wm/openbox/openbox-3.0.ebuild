# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-3.0.ebuild,v 1.2 2003/11/07 04:04:51 tseng Exp $

S=${WORKDIR}/${P/_/-}
DESCRIPTION="Openbox is a standards compliant, fast, light-weight, extensible window manager."
SRC_URI="http://icculus.org/openbox/releases/${P/_/-}.tar.gz"
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
		`use_enable nls` \
		--program-suffix="3" || die
	emake || die
}

src_install () {

	dodir /etc/X11/Sessions
	echo "/usr/bin/openbox3" > ${D}/etc/X11/Sessions/openbox3
	fperms a+x /etc/X11/Sessions/openbox3

	make DESTDIR=${D} install || die
	dodoc README AUTHORS ChangeLog TODO
}
