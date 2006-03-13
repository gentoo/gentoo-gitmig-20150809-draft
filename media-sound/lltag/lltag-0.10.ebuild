# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lltag/lltag-0.10.ebuild,v 1.2 2006/03/13 07:07:55 tsunam Exp $

DESCRIPTION="Automatic command-line mp3/ogg file tagger"
HOMEPAGE="http://home.gna.org/lltag"
SRC_URI="http://download.gna.org/lltag/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="mp3 ogg flac readline"

RDEPEND="dev-lang/perl
	mp3? ( media-sound/mp3info )
	ogg? ( media-sound/vorbis-tools )
	flac? ( media-libs/flac )
	readline? ( || ( dev-perl/Term-ReadLine-Gnu dev-perl/Term-ReadLine-Perl ) )"

src_compile() {
	make PREFIX=/usr SYSCONFDIR=/etc MANDIR=/usr/share/man \
	|| die "Failed to compile"
}

src_install() {
	make DESTDIR="${D}/" PREFIX=/usr SYSCONFDIR=/etc MANDIR=/usr/share/man \
	install || die "Failed to install"
	dodoc COPYING Changes
}
