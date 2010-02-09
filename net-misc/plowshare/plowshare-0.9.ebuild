# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/plowshare/plowshare-0.9.ebuild,v 1.1 2010/02/09 18:38:45 volkmar Exp $

EAPI="2"

DESCRIPTION="Command-line downloader and uploader for file-sharing websites"
HOMEPAGE="http://code.google.com/p/plowshare/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+javascript +perl view-captcha"

RDEPEND="
	javascript? ( dev-lang/spidermonkey )
	perl? ( dev-lang/perl
		media-gfx/imagemagick[perl] )
	view-captcha? ( || ( media-gfx/aview media-libs/libcaca ) )
	app-shells/bash
	app-text/recode
	app-text/tesseract[tiff]
	|| ( app-text/tesseract[linguas_en] >=app-text/tesseract-2.04-r1 )
	media-gfx/imagemagick[tiff]
	net-misc/curl
	sys-apps/util-linux"
DEPEND=""

# NOTES:
# spidermonkey dep should be any javascript interpreter using /usr/bin/js
# linguas_en is a workaround for bug 287373 and bug 297991

src_prepare() {
	if ! use javascript; then
		sed -i -e "s: mediafire::" src/upload.sh src/download.sh \
			|| die "sed failed"
		sed -i -e "s: zshare::" src/upload.sh src/download.sh \
			|| die "sed failed"
		rm src/modules/{mediafire,zshare}.sh || die "rm failed"
	fi
	if ! use perl; then
		sed -i -e "s: netload_in::" src/upload.sh src/download.sh \
			|| die "sed failed"
		rm src/modules/netload_in.sh || die "rm failed"
	fi
}

src_test() {
	# don't use test_modules.sh because it needs a working internet connection
	./test/test_lib.sh || die "test failed"
}

src_install() {
	insinto /usr/share/${PN}
	doins src/lib.sh || die "doins failed"

	if use perl; then
		doins src/strip_single_color.pl || die "doins failed"
	fi

	insinto /usr/share/${PN}/modules
	doins -r src/modules/* || die "doins failed"

	exeinto /usr/share/${PN}
	doexe src/{download,upload,delete}.sh || die "doexe failed"

	dosym /usr/share/${PN}/download.sh /usr/bin/plowdown
	dosym /usr/share/${PN}/upload.sh /usr/bin/plowup
	dosym /usr/share/${PN}/delete.sh /usr/bin/plowdel

	dodoc CHANGELOG README || die "dodoc failed"
}

pkg_postinst() {
	if ! use javascript; then
		ewarn "Without javascript you will not be able to use zshare and mediafire"
	fi
	if ! use perl; then
		ewarn "Without perl you will not be able to use netload.in"
	fi
}
