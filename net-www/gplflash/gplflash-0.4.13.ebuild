# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gplflash/gplflash-0.4.13.ebuild,v 1.2 2005/03/17 19:51:29 lanius Exp $

inherit nsplugins eutils flag-o-matic

DESCRIPTION="GPLFlash is a free portable and useable alternative to the
	flash-decoder released by Macromedia"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://gplflash.sourceforge.net/"

KEYWORDS="-ppc64 ~x86 ~ppc ~sparc ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE="debug alsa oss"

RDEPEND="media-libs/libmad
		media-libs/jpeg
		sys-libs/zlib
		virtual/x11
		!net-www/netscape-flash
		!media-libs/libflash"

PLUGDIR="/opt/netscape/plugins"

src_compile() {
	# check if sound support is wanted
	if ( ( use !alsa ) && ( use !oss ) ); then
		einfo "you don't have alsa or oss in your use flags."
		einfo "disabling sound support..."
		append-flags -DNOSOUND
	fi

	# configure -- includes and libraries won't be found correctly.
	# temporal solution is pointing configure to the exaclt location
	# until a better solution is found. bug #79270
	econf --with-plugin-dir=${PLUGDIR} $(use_enable debug) \
		--x-includes=/usr/include/X11/ --x-libraries=/usr/lib/ \
		|| die "configure failed"

	# compile
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install

	# install the plugin
	inst_plugin ${PLUGDIR}/libnpflash.so

	# install doc
	cd ${S}
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
