# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/tvtime/tvtime-0.9.10.ebuild,v 1.2 2003/09/15 08:16:10 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="High quality television application for use with video capture cards."
HOMEPAGE="http://tvtime.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm"


DEPEND="virtual/x11
	>=media-libs/freetype-2*
	sys-libs/zlib
	media-libs/libpng
	dev-libs/libxml2"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-make.patch
}

src_compile() {
	local myconf

	myconf="--with-fifogroup=video"

	econf ${myconf} || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc ChangeLog AUTHORS NEWS BUGS README README.UPGRADING COPYING \
	dodoc data/COPYING.* docs/example.lircrc

	dohtml docs/html/*

	doman doc/*.1 doc/*.5
	insinto /etc/tvtime
	newins default.tvtime.xml tvtime.xml
}

pkg_postinst() {
	einfo
	einfo "A default setup for ${PN} has been saved as"
	einfo "/etc/tvtime/tvtime.xml. You may need to modify it"
	einfo "for your needs."
	einfo
	einfo "Detailed information on ${PN} setup can be"
	einfo "found at ${HOMEPAGE}help.html"
	einfo
}
