# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/get-flash-videos/get-flash-videos-1.24.ebuild,v 1.1 2011/11/19 23:43:25 abcd Exp $

EAPI=4

MY_PN="App-${PN//-/_}"

inherit perl-module

DESCRIPTION="Video downloader for various Flash-based video hosting sites"
HOMEPAGE="https://code.google.com/p/${PN}/"
SRC_URI="https://${PN}.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-perl/Crypt-Rijndael
	dev-perl/Data-AMF
	dev-perl/WWW-Mechanize
	dev-perl/XML-Simple
	media-video/rtmpdump
	virtual/perl-IO-Compress
"
DEPEND="${RDEPEND}"
