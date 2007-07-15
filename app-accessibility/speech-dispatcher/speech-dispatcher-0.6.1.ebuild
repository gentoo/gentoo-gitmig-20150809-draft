# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speech-dispatcher/speech-dispatcher-0.6.1.ebuild,v 1.2 2007/07/15 23:02:29 mr_bones_ Exp $

DESCRIPTION="speech-dispatcher speech synthesis interface"
HOMEPAGE="http://www.freebsoft.org/speechd"
SRC_URI="http://www.freebsoft.org/pub/projects/speechd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-libs/dotconf
	>=app-accessibility/flite-1.2
	>=dev-libs/glib-2
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	sed -i -e 's/install;/install --root $(DESTDIR) --no-compile;/' ${S}/src/python/Makefile
}

src_compile() {
	econf || die "configure failed"
	make all || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die

	newinitd ${FILESDIR}/speech-dispatcher speech-dispatcher

	insinto /usr/include
	doins ${S}/src/c/api/libspeechd.h
}

pkg_postinst() {
	elog "To enable Festival support, you must install app-accessibility/festival-freebsoft-utils."
}
