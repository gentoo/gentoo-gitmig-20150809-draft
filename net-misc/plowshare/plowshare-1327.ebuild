# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/plowshare/plowshare-1327.ebuild,v 1.2 2011/04/10 07:12:05 tove Exp $

EAPI="2"

MY_P="${PN}-SVN-r${PV}-snapshot"

DESCRIPTION="Command-line downloader and uploader for file-sharing websites"
HOMEPAGE="http://code.google.com/p/plowshare/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="+javascript +perl scripts view-captcha"

RDEPEND="
	javascript? ( dev-lang/spidermonkey )
	perl? ( dev-lang/perl
		media-gfx/imagemagick[perl] )
	view-captcha? ( || ( media-gfx/aview media-libs/libcaca ) )
	app-shells/bash
	|| ( app-text/recode ( dev-lang/perl dev-perl/HTML-Parser ) )
	app-text/tesseract[tiff]
	|| ( media-gfx/imagemagick[tiff] media-gfx/graphicsmagick[imagemagick,tiff] )
	net-misc/curl
	sys-apps/util-linux"
DEPEND=""

S=${WORKDIR}/${MY_P}

# NOTES:
# spidermonkey dep should be any javascript interpreter using /usr/bin/js

# TODO:
# dev-java/rhino could probably be an alternative for spidermonkey

src_prepare() {
	if ! use javascript; then
		sed -i -e 's:^\(MODULES=".*\)mediafire:\1:' \
			-e 's:^\(MODULES=".*\)zshare:\1:' \
			-e 's:^\(MODULES=\".*\)badongo:\1:' \
			src/{delete,download,list,upload}.sh || die "sed failed"
		rm src/modules/{mediafire,zshare,badongo}.sh || die "rm failed"
	fi
	if ! use perl; then
		sed -i -e 's:^\(MODULES=\".*\)netload_in:\1:' \
			-e 's:^\(MODULES=\".*\)badongo:\1:' \
			src/{delete,download,list,upload}.sh || die "sed failed"
		rm src/modules/netload_in.sh || die "rm failed"
		if use javascript; then
			rm src/modules/badongo.sh || die "rm failed"
		fi

		# Don't install perl file helpers.
		sed -i -e 's:\(.*src/lib.sh\).*:\1:' Makefile || die "sed failed"
	fi

	# Don't let 'make install' install docs.
	sed -i -e "/INSTALL.*DOCDIR/d" Makefile || die "sed failed"
}

src_compile() {
	# There is a Makefile but it's not compiling anything, let's not try.
	:
}

src_test() {
	# don't use test_modules.sh because it needs a working internet connection
	if ! use perl; then
		sed -i -e "s:\(.*\.pl\):#\1:" test/test_lib.sh || die "sed failed"
	fi
	./test/test_lib.sh || die "test failed"
}

src_install() {
	DESTDIR="${D}" PREFIX="/usr" emake install || die "emake install failed"

	dodoc CHANGELOG README || die "dodoc failed"

	if use scripts; then
		exeinto /usr/bin/
		doexe contrib/{caturl,plowdown_{add_remote_loop,loop,parallel}}.sh \
			|| die "doins failed"
	fi
}

pkg_postinst() {
	if ! use javascript; then
		ewarn "Without javascript you will not be able to use:"
		ewarn " zshare, mediafire and badongo."
	fi
	if ! use perl; then
		ewarn "Without perl you will not be able to use:"
		ewarn " netload.in and badongo"
	fi
}
