# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/streamtuner/streamtuner-0.12.3.ebuild,v 1.7 2004/07/22 06:28:29 chriswhite Exp $

inherit gnome2 eutils

DESCRIPTION="Stream directory browser for browsing internet radio streams"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/streamtuner/"

IUSE=""
SLOT="0"
KEYWORDS="x86 ~ppc amd64 ~sparc"
LICENSE="BSD"

RDEPEND=">=x11-libs/gtk+-2.2.2
	>=net-misc/curl-7.10.8
	>=app-text/scrollkeeper-0.3.0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README TODO"

src_unpack() {
	unpack ${A}

	cd ${S}
	# sandbox errors work around
	gnome2_omf_fix ${S}/help/C/Makefile.in
	epatch ${FILESDIR}/$P-gcc34.patch

}
