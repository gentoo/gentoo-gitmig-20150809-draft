# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gplflash/gplflash-0.4.13-r1.ebuild,v 1.1 2005/12/17 00:13:25 vapier Exp $

inherit nsplugins eutils flag-o-matic autotools

DESCRIPTION="free, portable, and useable alternative to the flash-decoder by Macromedia"
HOMEPAGE="http://gplflash.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc -ppc64 ~sparc ~x86"
IUSE="nosound"

DEPEND="media-libs/libmad
	media-libs/jpeg
	sys-libs/zlib
	virtual/x11
	!net-www/netscape-flash
	!media-libs/libflash"

PLUGDIR="/opt/netscape/plugins"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	eautoreconf
}

src_compile() {
	use nosound && append-flags -DNOSOUND

	# configure -- includes and libraries won't be found correctly.
	# temporal solution is pointing configure to the exaclt location
	# until a better solution is found. bug #79270
	econf \
		--with-plugin-dir=${PLUGDIR} \
		--x-includes=/usr/include/X11/ --x-libraries=/usr/lib/ \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
	inst_plugin ${PLUGDIR}/libnpflash.so
}
