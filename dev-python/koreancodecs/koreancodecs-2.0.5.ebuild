# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/koreancodecs/koreancodecs-2.0.5.ebuild,v 1.4 2005/02/07 05:11:27 fserb Exp $

inherit distutils

MY_P=${P/koreancodecs/KoreanCodecs}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Python Codecs for Korean Language Encodings"
SRC_URI="mirror://sourceforge/koco/${MY_P}.tar.bz2"
HOMEPAGE="http://sourceforge.net/projects/koco"

IUSE=""
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86"

DEPEND=">=dev-lang/python-1.6"
DOCS="doc/*"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/test
	doins test/*
}
