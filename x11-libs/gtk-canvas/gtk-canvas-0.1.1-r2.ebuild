# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk-canvas/gtk-canvas-0.1.1-r2.ebuild,v 1.3 2008/07/07 05:20:22 dberkholz Exp $

WANT_AUTOMAKE="1.4"

inherit eutils autotools

DESCRIPTION="Backport of the GnomeCanvas widget to GTK+"
HOMEPAGE="http://www.atai.org/gtk-canvas/"
SRC_URI="http://www.atai.org/gtk-canvas/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND="=x11-libs/gtk+-1.2*
	media-libs/imlib"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PV}-as-needed.patch
	eautomake || die "automake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
