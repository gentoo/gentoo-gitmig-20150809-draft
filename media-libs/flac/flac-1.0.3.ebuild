# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/flac/flac-1.0.3.ebuild,v 1.2 2002/07/22 14:37:06 seemant Exp $

DESCRIPTION="A free lossless audio encoder"
SRC_URI="mirror://sourceforge/flac/${P}.tar.gz"
HOMEPAGE="http://flac.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 ppc"

RDEPEND="virtual/glibc 
	>=media-libs/libogg-1.0_rc2
	xmms? ( media-sound/xmms )"

DEPEND="${RDEPEND}
	dev-lang/nasm 
	sys-apps/gawk"

src_compile() {
	local myconf

	use sse && myconf="--enable-sse"

	#--use-3dnow is documented but apparently not yet enabled.
	#use 3dnow && myconf="${myconf} --use-3dnow"

	econf ${myconf} || die 
	cp Makefile Makefile.orig

	#the man page ebuild requires docbook2man... yick!
	sed -e 's:include man:include:g' Makefile.orig > Makefile

	#emake seems to mess up the building of the xmms input plugin
	make || die
}
src_install() {
	#it looks like we need to run the xmms install first
	cd src/plugin_xmms 
	make DESTDIR=${D} install

	cd ${S}
	make DESTDIR=${D} install
}
