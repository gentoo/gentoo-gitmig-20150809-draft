# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/archive/archive-2.2.ebuild,v 1.5 2008/08/30 19:57:58 maekke Exp $

ROX_LIB_VER=2.0.0
inherit rox-0install

DESCRIPTION="Archive is a simple archiver for ROX Desktop"
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="mirror://sourceforge/rox/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

IUSE="bzip2 compress rar uuencode zip ace rpm cpio"

RDEPEND="virtual/gzip
	app-arch/tar
	app-arch/lzma-utils
	bzip2? ( app-arch/bzip2 )
	compress? ( app-arch/ncompress )
	rar? ( app-arch/unrar )
	uuencode? ( app-arch/sharutils )
	zip? ( app-arch/unzip app-arch/zip )
	ace? ( app-arch/unace )
	rpm? ( app-arch/rpm app-arch/cpio )
	cpio? ( app-arch/cpio )"

APPNAME=Archive
APPCATEGORY="Utility;Archiving"

src_install() {
	APPMIME="application/x-gzip;application/x-tar;application/x-compressed-tar;application/x-lzma
		$(usemime bzip2 "application/x-bzip;application/x-bzip-compressed-tar" )
		$(usemime compress "application/x-compress;application/x-tarz" )
		$(usemime rar "application/x-rar" )
		$(usemime uuencode "application/x-shar")
		$(usemime zip "application/zip")
		$(usemime ace "application/x-ace")
		$(usemime rpm "application/x-rpm" )
		$(usemime cpio "application/x-cpio;application/x-cpio-compressed")"
	if use rpm && ! use cpio; then
		APPMIME="${APPMIME}
			application/x-cpio;application/x-cpio-compressed"
	fi

	rox-0install_src_install
}
