# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header

S=${WORKDIR}/${P}
DESCRIPTION="High quality television application for use with video capture cards."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://tvtime.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

IUSE="lirc"

myconf="--with-fifogroup=video --localstatedir=/var"

DEPEND="virtual/x11
		>=media-libs/freetype-2*
		sys-libs/zlib
		media-libs/libpng
		dev-libs/libxml2
		lirc? ( app-misc/lirc )"

src_compile() {

	econf ${myconf} || die
	emake || die
	
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc ChangeLog AUTHORS NEWS README
	cd docs
	doman tvtime.1 tvtime.xml.5 tvtime-command.1 stationlist.xml.5
	insinto /etc/tvtime
	newins default.tvtime.xml tvtime.xml
}

pkg_postinst() {
	ewarn
	ewarn "              :: !!Attention!! ::"
	ewarn "The latest versions of ${PN} use a new XML config"
	ewarn "file format. Please migrate your changes to the"
	ewarn "new format!"
	ewarn
	einfo "A default setup for ${PN} has been saved as"
	einfo "/etc/tvtime/tvtime.xml. You may need to modify it"
	einfo "for your needs."
	einfo
	einfo "Detailed information on ${PN} setup can be"
	einfo "found at ${HOMEPAGE}help.html"
	einfo
}
