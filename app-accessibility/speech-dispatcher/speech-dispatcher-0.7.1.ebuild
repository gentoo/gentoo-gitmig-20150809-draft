# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speech-dispatcher/speech-dispatcher-0.7.1.ebuild,v 1.1 2010/10/05 21:11:18 williamh Exp $

EAPI="3"

inherit eutils

DESCRIPTION="speech-dispatcher speech synthesis interface"
HOMEPAGE="http://www.freebsoft.org/speechd"
SRC_URI="http://www.freebsoft.org/pub/projects/speechd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="alsa ao +espeak flite nas pulseaudio python"

RDEPEND="dev-libs/dotconf
	>=dev-libs/glib-2
	alsa? ( media-libs/alsa-lib )
	ao? ( media-libs/libao )
	espeak? ( app-accessibility/espeak )
	flite? ( app-accessibility/flite )
	nas? ( media-libs/nas )
	pulseaudio? ( media-sound/pulseaudio )
	python? ( dev-lang/python )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		$(use_enable python) \
		$(use_with alsa) \
		$(use_with ao libao) \
		$(use_with espeak) \
		$(use_with flite) \
		$(use_with pulseaudio pulse) \
		$(use_with nas)
}

src_compile() {
	emake all || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS TODO
}

pkg_postinst() {
	if ! use espeak; then
		ewarn "You have disabled espeak, which is speech-dispatcher's"
		ewarn "default speech synthesizer."
		ewarn
		editconfig="y"
	fi
	if ! use pulseaudio; then
		ewarn "You have disabled pulseaudio support."
		ewarn "pulseaudio is speech-dispatcher's default audio subsystem."
		ewarn
		editconfig="y"
	fi
	if [ -n "$editconfig" ]; then
		ewarn "You must edit ${EROOT}etc/speech-dispatcher/speechd.conf"
		ewarn "and make sure the settings there match your system."
		ewarn
	fi
	ewarn "This version does not include a system wide startup script"
	ewarn "since it is not intended to be run in system-wide mode."
	ewarn
	elog "For festival support, you need to"
	elog "install app-accessibility/festival-freebsoft-utils."
}
