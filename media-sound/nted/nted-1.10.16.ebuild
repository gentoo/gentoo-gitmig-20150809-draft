# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/nted/nted-1.10.16.ebuild,v 1.1 2010/10/03 17:00:41 hwoarang Exp $

EAPI="2"

inherit eutils

DESCRIPTION="WYSIWYG score editor for GTK+2"
HOMEPAGE="http://vsr.informatik.tu-chemnitz.de/staff/jan/nted/nted.xhtml"
SRC_URI="http://vsr.informatik.tu-chemnitz.de/staff/jan/${PN}/sources/${P}.tar.gz"

LICENSE="|| ( GPL-2 FDL-1.2 NTED_FONT )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc nls debug"
RDEPEND="doc? ( gnome-extra/yelp app-text/xmlto )
	x11-libs/cairo
	x11-libs/gtk+:2
	media-libs/alsa-lib"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf $(use_with doc) \
	$(use_enable debug) \
	$(use_enable nls) \
	--docdir=/usr/share/doc/${PF}

}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ABOUT_THE_EXAMPLES.TXT FAQ README || die "dodoc failed"
	doman "man/${PN}.1" || die "doman failed"
}
