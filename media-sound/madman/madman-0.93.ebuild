# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/madman/madman-0.93.ebuild,v 1.10 2006/04/18 18:16:08 flameeyes Exp $

IUSE=""

inherit eutils

DESCRIPTION="MP3 organizer/ID3 tag-editor extraordinaire"
HOMEPAGE="http://madman.sourceforge.net/"
SRC_URI="mirror://sourceforge/madman/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#-amd64: 0.93: see bug #56821
KEYWORDS="x86 -amd64 sparc ~ppc"

DEPEND="=x11-libs/qt-3*
	>=media-libs/libvorbis-1.0
	>=media-sound/xmms-1.2.7-r20
	>=media-libs/libid3tag-0.15.1b"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gcc34.patch
	epatch "${FILESDIR}/${P}-uic.patch"
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
	newdoc plugins/README README.plugins
	dodir /usr/lib/${PN}/plugins
	exeinto /usr/lib/${PN}/plugins
	doexe `find plugins -perm -100 -a -type f`
}
