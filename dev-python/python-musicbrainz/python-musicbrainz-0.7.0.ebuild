# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-musicbrainz/python-musicbrainz-0.7.0.ebuild,v 1.3 2010/03/10 09:25:17 josejx Exp $

MY_P=${PN}2-${PV}
inherit distutils

DESCRIPTION="Python Bindings for the MusicBrainz XML Web Service"
HOMEPAGE="http://musicbrainz.org"
SRC_URI="http://ftp.musicbrainz.org/pub/musicbrainz/${PN}2/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="doc examples"

RDEPEND=">=dev-lang/python-2.5
	media-libs/libdiscid"
DEPEND="${RDEPEND}
	doc? ( dev-python/epydoc )"

S=${WORKDIR}/${MY_P}

DOCS="AUTHORS.txt CHANGES.txt README.txt"

src_compile() {
	distutils_src_compile

	if use doc; then
		${python} setup.py docs || die "${python} setup.py docs failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml html/* || die "dohtml failed"
	fi

	if use examples; then
		docinto /usr/share/doc/${PF}/examples
		dodoc examples/*.txt || die "dodoc failed"
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.py || die "doins failed"
	fi
}
