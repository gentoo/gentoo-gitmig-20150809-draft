# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/faac/faac-1.23.5.ebuild,v 1.2 2004/04/09 14:49:11 dholm Exp $

inherit libtool

S=${WORKDIR}/faac
DESCRIPTION="Free MPEG-4 audio codecs by AudioCoding.com"
HOMEPAGE="http://faac.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"

RDEPEND=">=media-libs/libsndfile-1.0.0"

DEPEND="${RDEPEND}
	>=sys-devel/libtool-1.3.5
	sys-devel/autoconf
	sys-devel/automake"


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

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO docs/libfaac.pdf
}
