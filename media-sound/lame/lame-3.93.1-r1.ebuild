# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lame/lame-3.93.1-r1.ebuild,v 1.5 2003/05/08 10:07:11 jje Exp $

inherit flag-o-matic

IUSE="gtk"
DESCRIPTION="LAME Ain't an Mp3 Encoder"
HOMEPAGE="http://www.mp3dev.org/mp3/"
SRC_URI="mirror://sourceforge/lame/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc sparc alpha"

RDEPEND=">=sys-libs/ncurses-5.2
	gtk? ( =x11-libs/gtk+-1.2* )"

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

# this release completely removed oggvorbis support as it was too outdated.
src_compile() {
	# fix gtk detection
	cp configure configure.orig
	sed -e "s:gtk12-config:gtk-config:" < configure.orig > configure

	# take out -fomit-frame-pointer from CFLAGS if k6-2
	is-flag "-march=k6-3" && filter-flags "-fomit-frame-pointer"
	is-flag "-march=k6-2" && filter-flags "-fomit-frame-pointer"
	is-flag "-march=k6" && filter-flags "-fomit-frame-pointer"

	local myconf=""
	if [ "`use gtk`" ] ; then
		myconf="${myconf} --enable-mp3x"
	fi
	if [ "${DEBUG}" ] ; then
		myconf="${myconf} --enable-debug=yes"
	else
		myconf="${myconf} --enable-debug=no"
	fi
	
	econf \
		--enable-shared \
		--enable-nasm \
		--enable-mp3rtp \
		--enable-extopt=full \
		${myconf} || die
		
	emake || die
}

src_install () {

	einstall \
		pkghtmldir=${D}/usr/share/doc/${PF}/html || die

	dodoc API COPYING HACKING PRESETS.draft LICENSE README* TODO USAGE
	dohtml -r ./
}

