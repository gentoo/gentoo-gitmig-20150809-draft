# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/recorder/recorder-1.4.1.ebuild,v 1.1 2008/09/15 20:04:03 yngwin Exp $

inherit fdo-mime

DESCRIPTION="A simple GTK+ disc burner"
HOMEPAGE="http://code.google.com/p/recorder/"
SRC_URI="http://recorder.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dvdr mp3 nls ogg vcd"

LANGS="ar cs es fr pt_BR ru it nl"
for l in ${LANGS}; do
	IUSE="${IUSE} linguas_${l}"
done

DEPEND="nls? ( sys-devel/gettext )"
RDEPEND="${DEPEND}
	dev-python/pygtk
	sys-apps/coreutils
	virtual/cdrtools
	dvdr? ( app-cdr/dvd+rw-tools )
	mp3? ( virtual/mpg123 )
	ogg? ( media-sound/vorbis-tools )
	vcd? ( app-cdr/cdrdao
		media-video/vcdimager )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:ar cs es fr pt_BR ru it nl:${LINGUAS}:" Makefile
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGELOG TRANSLATORS
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
