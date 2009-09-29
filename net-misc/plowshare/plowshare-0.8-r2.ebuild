# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/plowshare/plowshare-0.8-r2.ebuild,v 1.1 2009/09/29 18:15:27 volkmar Exp $

EAPI="2"

DESCRIPTION="Command-line downloader and uploader for file-sharing websites"
HOMEPAGE="http://code.google.com/p/plowshare/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="+javascript view-captcha"

RDEPEND="
	javascript? ( dev-lang/spidermonkey )
	view-captcha? ( media-gfx/aview )
	app-shells/bash
	app-text/recode
	app-text/tesseract
	media-gfx/imagemagick[tiff]
	net-misc/curl
	sys-apps/util-linux"
DEPEND=""

# NOTES:
# dev-lang/spidermonkey is actually any javascript interpreter using /usr/bin/js

src_prepare() {
	if ! use javascript; then
		sed -i -e "s: mediafire::" src/upload.sh src/download.sh \
			|| die "sed failed"
		sed -i -e "s: zshare::" src/upload.sh src/download.sh \
			|| die "sed failed"
		rm src/modules/{mediafire,zshare}.sh
	fi

	# removing extras/ as it's now deprecated
	rm -r src/modules/extras/ || die "rm -r failed"
}

src_test() {
	./test/test_lib.sh || die "test failed"
}

src_install() {
	insinto /usr/share/${PN}
	doins src/lib.sh || die "doins failed"

	insinto /usr/share/${PN}/modules
	doins -r src/modules/* || die "doins failed"

	exeinto /usr/share/${PN}
	doexe src/{download,upload}.sh || die "doexe failed"

	dosym /usr/share/${PN}/download.sh /usr/bin/plowdown
	dosym /usr/share/${PN}/upload.sh /usr/bin/plowup

	dodoc CHANGELOG README || die "dodoc failed"
}

pkg_postinst() {
	if ! use javascript; then
		ewarn "Without javascript you will not be able to use zshare and mediafire"
	fi
}
