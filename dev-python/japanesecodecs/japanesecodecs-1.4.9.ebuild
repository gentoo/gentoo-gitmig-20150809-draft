# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/japanesecodecs/japanesecodecs-1.4.9.ebuild,v 1.3 2004/08/03 11:49:57 dholm Exp $

inherit distutils

MY_P=${P/japanesecodecs/JapaneseCodecs}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Python Codecs for Japanese Language Encodings like EUC, Shift-JIS, ISO-2022"
SRC_URI="http://www.asahi-net.or.jp/~rd6t-kjym/python/JapaneseCodecs/dist/${MY_P}.tar.gz"
HOMEPAGE="http://www.asahi-net.or.jp/~rd6t-kjym/python/"

IUSE=""
SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~ppc"

DEPEND=">=dev-lang/python-1.6"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/test
	doins test/*
}
