# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/speex/speex-1.1.7.ebuild,v 1.9 2008/01/10 14:58:30 drac Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Speech encoding library"
HOMEPAGE="http://www.speex.org"
SRC_URI="http://www.speex.org/download/${MY_P}.tar.gz"

LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="mips"
IUSE="ogg sse"

DEPEND="ogg? ( >=media-libs/libogg-1 )"

src_compile() {
	local myconf
	use ogg \
		&& myconf="--enable-ogg=yes --with-ogg-dir=/usr" \
		|| myconf="--enable-ogg=no"
	if [ "${ARCH}" != "amd64" ]
	then
		use sse && myconf="${myconf} --enable-sse"
	fi
	econf ${myconf} || die "econf failed."
	emake || die "emake failed."
}

src_install () {
	einstall || die "einstall failed."
	rm -rf "${D}"/usr/share/doc/*

	insinto /usr/share/doc/${P}
	doins "${S}"/doc/manual.pdf
	dodoc AUTHORS ChangeLog README TODO NEWS
}
