# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gplflash/gplflash-0.4.12.ebuild,v 1.1 2004/11/03 15:31:52 corsair Exp $

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

	# configure
	econf --with-plugin-dir=${D}/${PLUGDIR} $(use_enable debug) \
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
