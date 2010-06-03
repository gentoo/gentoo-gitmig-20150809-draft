# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/plowshare/plowshare-0.9.2.ebuild,v 1.2 2010/06/03 23:26:03 volkmar Exp $

EAPI="2"

DESCRIPTION="Command-line downloader and uploader for file-sharing websites"
HOMEPAGE="http://code.google.com/p/plowshare/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples +javascript +perl view-captcha"

RDEPEND="
	javascript? ( dev-lang/spidermonkey )
	perl? ( dev-lang/perl
		media-gfx/imagemagick[perl] )
	view-captcha? ( || ( media-gfx/aview media-libs/libcaca ) )
	app-shells/bash
	app-text/recode
	app-text/tesseract[tiff]
	|| ( app-text/tesseract[linguas_en] >=app-text/tesseract-2.04-r1 )
	|| ( media-gfx/imagemagick[tiff] media-gfx/graphicsmagick[imagemagick,tiff] )
	net-misc/curl
	sys-apps/util-linux"
DEPEND=""

# NOTES:
# spidermonkey dep should be any javascript interpreter using /usr/bin/js
# linguas_en is a workaround for bug 287373 and bug 297991

# TODO:
# dev-java/rhino could probably be an alternative for spidermonkey

src_prepare() {
	if ! use javascript; then
		sed -i -e 's:^\(MODULES=".*\)mediafire:\1:' \
			-e 's:^\(MODULES=".*\)zshare:\1:' \
			src/{delete,download,list,upload}.sh || die "sed failed"
		rm src/modules/{mediafire,zshare}.sh || die "rm failed"
	fi
	if ! use perl; then
		sed -i -e 's:^\(MODULES=\".*\)netload_in:\1:' \
			-e 's:^\(MODULES=\".*\)loadfiles:\1:' \
			src/{delete,download,list,upload}.sh || die "sed failed"
		rm src/modules/netload_in.sh || die "rm failed"
	fi
}

src_test() {
	# don't use test_modules.sh because it needs a working internet connection
	if ! use perl; then
		sed -i -e "s:\(.*\.pl\):#\1:" test/test_lib.sh || die "sed failed"
	fi
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

	insinto /usr/share/${PN}/tesseract
	doins -r src/tesseract/* || die "doins failed"

	exeinto /usr/share/${PN}
	doexe src/{delete,download,list,upload}.sh || die "doexe failed"

	dosym /usr/share/${PN}/delete.sh /usr/bin/plowdel
	dosym /usr/share/${PN}/download.sh /usr/bin/plowdown
	dosym /usr/share/${PN}/list.sh /usr/bin/plowlist
	dosym /usr/share/${PN}/upload.sh /usr/bin/plowup

	dodoc CHANGELOG README || die "dodoc failed"

	doman docs/plow{del,down,list,up}.1 || die "doman failed"

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/plowdown_{add_remote_loop,loop,parallel}.sh \
		|| die "doins failed"
	fi
}

pkg_postinst() {
	if ! use javascript; then
		ewarn "Without javascript you will not be able to use zshare and mediafire"
	fi
	if ! use perl; then
		ewarn "Without perl you will not be able to use netload.in"
	fi
}
