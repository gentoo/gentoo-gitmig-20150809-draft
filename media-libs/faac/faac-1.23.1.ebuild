# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/faac/faac-1.23.1.ebuild,v 1.4 2004/03/19 07:56:03 mr_bones_ Exp $

S=${WORKDIR}/faac
DESCRIPTION="Free MPEG-4 audio codecs by AudioCoding.com"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://faac.sourceforge.net/"


SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ~sparc ~amd64"

DEPEND=">=media-libs/libsndfile-1.0.0
	>=sys-devel/libtool-1.3.5
	sys-devel/autoconf
	sys-devel/automake"

src_compile() {
	aclocal -I .
	autoheader
	libtoolize --automake
	automake --add-missing
	autoconf

	econf || die
	emake || die
}

src_install() {

	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO docs/libfaac.pdf
}
