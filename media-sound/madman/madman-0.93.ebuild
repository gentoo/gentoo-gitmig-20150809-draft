# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/madman/madman-0.93.ebuild,v 1.3 2004/07/17 09:42:34 dholm Exp $

IUSE=""

inherit eutils

DESCRIPTION="MP3 organizer/ID3 tag-editor extrodinaire"
HOMEPAGE="http://madman.sf.net"
SRC_URI="mirror://sourceforge/madman/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
#-amd64: 0.93: see bug #56821
KEYWORDS="~x86 -amd64 ~sparc ~ppc"

DEPEND=">=x11-libs/qt-3.1.0-r3
	>=media-libs/libvorbis-1.0
	>=media-sound/xmms-1.2.7-r20
	>=media-libs/id3lib-3.8.3"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gcc34.patch
}

addpredict_from_config() {
	# This is a hack to be able to dynamically determine which directories
	# scons will try to create .scons* files in.
	for i in `$1 --libs --cflags | tr ' ' '\n' |
				grep -E -- '-L|-I' | cut -c 3-`; do
		addpredict $i
	done;
}

src_compile() {
	# Since I have found no way to prevent scons from trying to create
	# .scons$PID and .sconsign files, I have instead just added the
	# directiories where it tries to create them to the predict path.
	addpredict "${QTDIR}/include"
	addpredict "${QTDIR}/lib"
	addpredict_from_config glib-config
	addpredict_from_config xmms-config

	tar xzf scons-local-0.95.tar.gz

	./scons.py ${MAKEOPTS} prefix=/usr || die
}

src_install() {
	# Since I cannot make scons install the files in a different directory than
	# prefix is set to (without recompiling everyting), I opted to install
	# madman "by hand".
	dobin main/madman
	dodoc README
	dodoc COPYING
	newdoc plugins/README README.plugins
	dodir /usr/lib/${PN}/plugins
	exeinto /usr/lib/${PN}/plugins
	doexe `find plugins -perm -100 -a -type f`
}
