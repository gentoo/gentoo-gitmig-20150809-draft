# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libvorbis/libvorbis-1.2.3.ebuild,v 1.6 2009/08/10 15:45:38 klausman Exp $

EAPI=2
MY_P=${P/_}
inherit autotools flag-o-matic eutils toolchain-funcs

DESCRIPTION="The Ogg Vorbis sound file format library with aoTuV patch"
HOMEPAGE="http://xiph.org/vorbis"
SRC_URI="http://downloads.xiph.org/releases/vorbis/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm hppa ~ia64 ~mips ~ppc ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE="doc"

RDEPEND="media-libs/libogg"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-optional_examples_and_tests.patch

	sed -e 's:-O20::g' -e 's:-mfused-madd::g' -e 's:-mcpu=750::g' \
		-i configure.ac || die "sed failed"

	AT_M4DIR=m4 eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	rm -rf "${D}"/usr/share/doc/${PN}*

	dodoc AUTHORS CHANGES README todo.txt

	if use doc; then
		docinto txt
		dodoc doc/*.txt
		docinto html
		dohtml -r doc/*
		insinto /usr/share/doc/${PF}/pdf
		doins doc/*.pdf
	fi
}
