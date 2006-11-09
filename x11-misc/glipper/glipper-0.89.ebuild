# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/glipper/glipper-0.89.ebuild,v 1.1 2006/11/09 15:05:28 swegener Exp $

inherit autotools eutils

DESCRIPTION="GNOME Clipboard Manager"
HOMEPAGE="http://glipper.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6.0
	>=dev-libs/glib-2.6.0"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.23"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/0.89-as-needed.patch

	eautoreconf
}

src_install() {
	emake -j1 install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS
}
