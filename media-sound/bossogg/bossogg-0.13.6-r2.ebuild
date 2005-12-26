# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bossogg/bossogg-0.13.6-r2.ebuild,v 1.3 2005/12/26 14:55:15 lu_zero Exp $

inherit eutils

IUSE="vorbis mad flac"

DESCRIPTION="Bossogg Music Server"
HOMEPAGE="http://bossogg.wishy.org"
SRC_URI="mirror://sourceforge/bossogg/${P}.tar.gz"

KEYWORDS="x86 sparc amd64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-libs/libao-0.8.3
	media-libs/libshout
	flac? ( media-libs/flac )
	vorbis? ( media-libs/libvorbis )
	mad? ( media-sound/madplay media-libs/id3lib )"

RDEPEND="${DEPEND}
	 dev-python/pysqlite"

DEPEND="${DEPEND}
	>=sys-devel/automake-1.7"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-Makefile.patch
	touch NEWS AUTHORS

	export WANT_AUTOMAKE=1.7
	export WANT_AUTOCONF=2.5
	aclocal || die
	automake || die
	autoconf || die
}

src_compile() {
	libtoolize --copy --force	# per bug number 83003
	econf --enable-shout \
	      `use_enable vorbis` \
	      `use_enable flac` \
	      `use_enable mad mp3` \
	      `use_enable mad id3` || die "could not configure"

	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README TODO API

	exeinto /etc/init.d
	newexe ${FILESDIR}/bossogg.initd bossogg
}

pkg_postinst() {
	enewgroup bossogg
	enewuser bossogg -1 /bin/bash /var/bossogg bossogg -G audio

	if ! [ -d /var/bossogg ]; then
		mkdir /var/bossogg
		chown bossogg:bossogg /var/bossogg
	fi

	einfo "After running the /etc/init.d/bossogg service for the first"
	einfo "time, /var/bossogg/.bossogg/bossogg.conf will be created."
	einfo "Please edit this file and restart the service to setup."
	einfo "the server."
}
