# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/musicbrainz/musicbrainz-2.0.1.ebuild,v 1.3 2003/04/16 14:15:57 mholzer Exp $

IUSE=""

inherit libtool

S="${WORKDIR}/lib${P}"
DESCRIPTION="Client library to access free metadata about mp3/vorbis/CD media"
SRC_URI="ftp://ftp.musicbrainz.org/pub/musicbrainz/lib${P}.tar.gz"
HOMEPAGE="http://www.musicbrainz.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~alpha"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Get it to build with our CFLAGS (need Reconf part below)
	cp configure.in configure.in.orig
	sed -e 's:^CFLAGS:#CFLAGS:g' \
		-e 's:^CPPFLAGS:#CPPFLAGS:g' \
		configure.in.orig > configure.in
	
	# Fix problems with later versions of automake.  Please do not
	# remove .. if there are any issues, let me know.
	# <azarah@gentoo.org> (30 Mar 2003)
	einfo "Reconfiguring..."
	export WANT_AUTOCONF_2_5=1
	aclocal
	autoconf
	automake
	
	elibtoolize
}

src_compile() {
	econf || die
	emake || die "compile problem"
}

src_install() {
	dodir /usr/lib/pkgconfig
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO docs/mb_howto.txt
}
