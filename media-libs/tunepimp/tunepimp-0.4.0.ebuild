# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/tunepimp/tunepimp-0.4.0.ebuild,v 1.2 2005/12/01 23:26:19 carlo Exp $

inherit eutils distutils perl-app

MY_P="lib${P}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Client library to create MusicBrainz enabled tagging applications"
HOMEPAGE="http://www.musicbrainz.org/products/tunepimp"
SRC_URI="http://ftp.musicbrainz.org/pub/musicbrainz/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="examples flac mp3 readline perl python vorbis"

RDEPEND=">=media-libs/musicbrainz-2.1.0
	flac? ( media-libs/flac )
	vorbis? ( media-libs/libvorbis )
	readline? ( sys-libs/readline )
	mp3? ( media-libs/libmad )
	!media-sound/trm"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gcc41.patch

	# do not try to link against obsolete libtermcap
	sed -i -e 's,-ltermcap,-lncurses,' ${S}/configure
	sed -i -e 's:-lthr:-lpthread:g' ${S}/lib/threads/posix/Makefile.in
}

src_compile() {
	econf || die "configure failed"
	emake || die "emake failed"
	if use perl; then
		cd ${S}/perl/tunepimp-perl
		perl-app_src_compile || die "perl module failed to compile"
	fi
}

src_install() {
	cd ${S}
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL README TODO
	if use python; then
		cd ${S}/python
		distutils_src_install
		if use examples ; then
			insinto /usr/share/doc/${PF}/examples/
			doins examples/*
		fi
	fi
	if use perl; then
		cd ${S}/perl/tunepimp-perl
		perl-module_src_install || die "perl module failed to install"
		if use examples ; then
			insinto /usr/share/doc/${PF}/examples/
			doins examples/*
		fi
	fi
}
