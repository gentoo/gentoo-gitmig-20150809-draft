# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/faac/faac-26102001.ebuild,v 1.5 2002/08/14 13:08:09 murphy Exp $

S=${WORKDIR}/faac
DESCRIPTION="Free MPEG-4 audio codecs by AudioCoding.com"
SRC_URI="http://faac.sourceforge.net/files/faac_src_26102001.zip"
HOMEPAGE="http://faac.sourceforge.net/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=media-libs/libsndfile-0.0.28
	>=sys-devel/libtool-1.3.5
	sys-devel/autoconf
	sys-devel/automake"

src_unpack() {
	unpack ${A}
	sh ${FILESDIR}/fix-linefeeds.sh $S
}

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
