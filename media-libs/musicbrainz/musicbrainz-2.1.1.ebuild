# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/musicbrainz/musicbrainz-2.1.1.ebuild,v 1.10 2004/09/03 03:51:46 tgall Exp $

IUSE=""

inherit eutils

DESCRIPTION="Client library to access metadata of mp3/vorbis/CD media"
HOMEPAGE="http://www.musicbrainz.org/"
SRC_URI="http://ftp.musicbrainz.org/pub/musicbrainz/lib${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="x86 ppc sparc hppa alpha amd64 ia64 ~ppc64"

RDEPEND="dev-libs/expat"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/lib${P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc2.patch
}

src_compile() {
	econf --enable-cpp-headers || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog INSTALL README TODO docs/mb_howto.txt
}

pkg_postinst() {
	einfo "The name of the library has changed from libmusicbrainz.so.2 to libmusicbrainz.so.4."
	einfo "If you are updating from musicbrainz-2.0.x and you want to use the new library with"
	einfo "existing applications, you must re-emerge them by doing:"
	einfo "revdep-rebuild --soname libmusicbrainz.so.2"
	einfo
	einfo "After doing that, you can safely unmerge your old version by doing:"
	einfo "emerge unmerge \=media-libs/musicbrainz-<old version>"
}
