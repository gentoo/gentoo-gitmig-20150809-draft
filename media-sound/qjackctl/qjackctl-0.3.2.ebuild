# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qjackctl/qjackctl-0.3.2.ebuild,v 1.5 2008/04/28 18:09:51 armin76 Exp $

EAPI=1

inherit eutils qt4

DESCRIPTION="A Qt application to control the JACK Audio Connection Kit and ALSA sequencer connections."
HOMEPAGE="http://qjackctl.sourceforge.net/"
SRC_URI="mirror://sourceforge/qjackctl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"

IUSE="alsa debug"

DEPEND="alsa? ( media-libs/alsa-lib )
	|| ( (
			x11-libs/qt-core:4
			x11-libs/qt-gui:4
		) >=x11-libs/qt-4.1:4 )
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
	econf \
		$(use_enable alsa alsa-seq) \
		$(use_enable debug) \
		|| die "econf failed"

	# Emulate what the Makefile does, so that we can get the correct
	# compiler used.
	eqmake4 ${PN}.pro -o ${PN}.mak || die "eqmake4 failed"

	emake -f ${PN}.mak || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	rm "${D}/usr/share/applications/qjackctl.desktop"

	# Upstream desktop file is invalid, better stick with our for now.
	make_desktop_entry "${PN}" "QjackCtl" "${PN}"

	dodoc README ChangeLog TODO AUTHORS
}
