# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/faac/faac-1.24.ebuild,v 1.9 2004/11/22 18:53:10 vapier Exp $

inherit libtool

DESCRIPTION="Free MPEG-4 audio codecs by AudioCoding.com"
HOMEPAGE="http://www.audiocoding.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~ppc-macos sparc x86"
IUSE=""

RDEPEND=">=media-libs/libsndfile-1.0.0"
DEPEND="${RDEPEND}
	>=sys-devel/libtool-1.3.5
	sys-devel/automake"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	cd ${S}

	export WANT_AUTOMAKE=1.7
	export WANT_AUTOCONF=2.5
	sh ./bootstrap
	elibtoolize
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO docs/libfaac.pdf
}
