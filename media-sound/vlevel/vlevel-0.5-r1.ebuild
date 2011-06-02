# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vlevel/vlevel-0.5-r1.ebuild,v 1.1 2011/06/02 06:34:58 radhermit Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Dynamic compressor to amplify quiet parts of music"
HOMEPAGE="http://vlevel.sourceforge.net/"
SRC_URI="mirror://sourceforge/vlevel/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="media-libs/ladspa-sdk"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_compile() {
	emake CXX=$(tc-getCXX) CXXFLAGS="$CXXFLAGS -fPIC -DPIC"
}

src_install() {
	emake PREFIX="${D}/usr/bin/" LADSPA_PREFIX="${D}/usr/$(get_libdir)/ladspa/" install

	dodoc README TODO docs/*

	exeinto /usr/share/doc/${PF}/examples
	doexe utils/{levelplay,raw2wav,vlevel-dir}
	docinto examples
	dodoc utils/README
	docompress -x /usr/share/doc/${PF}/examples/{levelplay,raw2wav,vlevel-dir}
}
