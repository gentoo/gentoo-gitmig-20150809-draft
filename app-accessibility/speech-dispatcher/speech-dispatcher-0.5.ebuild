# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speech-dispatcher/speech-dispatcher-0.5.ebuild,v 1.3 2007/01/23 15:06:36 genone Exp $

DESCRIPTION="speech-dispatcher speech synthesis interface"
HOMEPAGE="http://www.freebsoft.org/speechd"
SRC_URI="http://www.freebsoft.org/pub/projects/speechd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

RDEPEND="dev-libs/dotconf
	>=app-accessibility/flite-1.2
	>=dev-libs/glib-2
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install || die

	exeinto /etc/init.d
	doexe ${FILESDIR}/speech-dispatcher

	insinto /usr/include
	doins ${S}/src/c/api/libspeechd.h
}

pkg_postinst() {
	elog
	elog "To enable Festival support, you must install app-accessibility/festival-freebsoft-utils."
	elog
}
