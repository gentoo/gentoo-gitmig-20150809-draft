# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xvidcap/xvidcap-1.1.5_rc2.ebuild,v 1.1 2007/04/04 13:23:06 drac Exp $

MY_PV="${PV/_/}"

DESCRIPTION="Screen capture utility enabling you to create videos of your desktop for illustration or documentation purposes."
HOMEPAGE="http://xvidcap.sourceforge.net/"
SRC_URI="mirror://sourceforge/xvidcap/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libXmu
	x11-libs/libXfixes
	x11-libs/libXdamage
	x11-libs/libICE
	media-libs/libpng
	media-libs/jpeg
	sys-libs/zlib
	>=x11-libs/gtk+-2.4
	media-sound/lame"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	app-text/scrollkeeper
	app-text/docbook2X
	app-text/gnome-doc-utils
	sys-devel/gettext"

S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:2x-man:2man:g' configure*
}

src_compile() {
	econf --with-forced-embedded-ffmpeg
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || "emake install failed."

	# Almost like bug #58322 but directory name changed.
	rm -fr "${D}"/usr/share/doc/${PN}
	dodoc AUTHORS ChangeLog NEWS README TODO.tasks
}
