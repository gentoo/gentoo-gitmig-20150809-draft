# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/flac/flac-1.0.2.ebuild,v 1.3 2002/05/27 17:27:38 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A free lossless audio encoder"
SRC_URI="mirror://sourceforge/flac/${P}-src.tar.gz"
HOMEPAGE="http://flac.sourceforge.net/"
#flac has an optional xmms plugin.  For now, we just depend on xmms.  We can optimize this later.
RDEPEND="virtual/glibc X? ( >=media-sound/xmms-1.2.5-r2 ) >=media-libs/libogg-1.0_rc2"
DEPEND="virtual/glibc dev-lang/nasm sys-apps/gawk $RDEPEND"

src_compile() {
	cd ${S}
	local myflags
	[ `use sse` ] && myflags="--enable-sse"
	#--use-3dnow is documented but apparently not yet enabled.
	#[ `use 3dnow` ] && myflags="$myflags --use-3dnow"
	./configure --prefix=/usr $myflags --host=$CHOST || die 
	cp Makefile Makefile.orig
	#the man page ebuild requires docbook2man... yick!
	sed -e 's:include man:include:g' Makefile.orig > Makefile
	#emake seems to mess up the building of the xmms input plugin
	make || die
}
src_install() {
	#it looks like we need to run the xmms install first
	( cd src/plugin_xmms; make DESTDIR=${D} install )
	make DESTDIR=${D} install
}


