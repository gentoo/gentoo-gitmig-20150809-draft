# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speech-dispatcher/speech-dispatcher-0.6.2-r2.ebuild,v 1.1 2007/06/05 06:34:49 williamh Exp $

inherit eutils

DESCRIPTION="speech-dispatcher speech synthesis interface"
HOMEPAGE="http://www.freebsoft.org/speechd"
SRC_URI="http://www.freebsoft.org/pub/projects/speechd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="app-accessibility/espeak
	dev-libs/dotconf
	>=dev-libs/glib-2
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-espeak.patch
	epatch ${FILESDIR}/${P}-python.patch
}

src_compile() {
	econf || die "configure failed"
	make all || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die

	newinitd ${FILESDIR}/speech-dispatcher speech-dispatcher

	dodoc AUTHORS ChangeLog NEWS TODO

	insinto /usr/include
	doins ${S}/src/c/api/libspeechd.h
}

pkg_postinst() {
	elog "The default synthesizer for speech-dispatcher in gentoo is espeak."
	elog "This has been set up in /etc/speech-dispatcher/speechd.conf."
	elog "To enable Festival support, you must install app-accessibility/festival-freebsoft-utils."
}
