# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/archive/archive-2.1-r2.ebuild,v 1.3 2007/11/16 15:03:23 drac Exp $

ROX_LIB_VER=2.0.0
inherit rox

DESCRIPTION="Archive is a simple archiver for ROX Desktop"
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="mirror://sourceforge/rox/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

IUSE="bzip2 compress rar uuencode zip ace rpm cpio"

RDEPEND="virtual/gzip
	app-arch/tar
	bzip2? ( app-arch/bzip2 )
	compress? ( app-arch/ncompress )
	rar? ( app-arch/rar )
	uuencode? ( app-arch/sharutils )
	zip? ( app-arch/unzip app-arch/zip )
	ace? ( app-arch/unace )
	rpm? ( app-arch/rpm app-arch/cpio )
	cpio? ( app-arch/cpio )"

APPNAME=Archive
APPCATEGORY="Utility;Archiving"
