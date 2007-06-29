# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qjackctl/qjackctl-0.2.22.ebuild,v 1.1 2007/06/29 12:22:55 flameeyes Exp $

inherit eutils qt3

DESCRIPTION="A Qt application to control the JACK Audio Connection Kit and ALSA sequencer connections."
HOMEPAGE="http://qjackctl.sourceforge.net/"
SRC_URI="mirror://sourceforge/qjackctl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE="alsa debug"

DEPEND="alsa? ( media-libs/alsa-lib )
	$(qt_min_version 3.1.1)
	media-sound/jack-audio-connection-kit"

pkg_setup() {
	if use alsa && ! built_with_use --missing true media-libs/alsa-lib midi; then
		eerror ""
		eerror "To be able to build ${CATEGORY}/${PN} with ALSA support you"
		eerror "need to have built media-libs/alsa-lib with midi USE flag."
		die "Missing midi USE flag on media-libs/alsa-lib"
	fi
}

src_compile() {
	local myconf

	# Upstream's configure.ac is broken, assumes that passing any
	# --(dis|en)able-(feature) means the non-default option.

	use alsa || myconf="${myconf} --disable-alsa-seq"
	use debug && myconf="${myconf} --enable-debug"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "make install failed"

	# The icon is installed in the wrong place, move it into a more
	# proper path.
	dodir /usr/share/icons/hicolor/32x32/apps
	mv "${D}/usr/share/icons/${PN}.png" "${D}/usr/share/icons/hicolor/32x32/apps/"

	make_desktop_entry "${PN}" "QjackCtl" "${PN}"

	dodoc README ChangeLog TODO AUTHORS
}
