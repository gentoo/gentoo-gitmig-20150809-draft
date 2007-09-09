# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bossogg/bossogg-0.13.6-r3.ebuild,v 1.14 2007/09/09 00:49:42 josejx Exp $

inherit autotools eutils multilib

IUSE="vorbis mad flac"

DESCRIPTION="Bossogg Music Server"
HOMEPAGE="http://bossogg.wishy.org"
SRC_URI="mirror://sourceforge/bossogg/${P}.tar.gz"

KEYWORDS="amd64 ~ppc sparc x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-libs/libao-0.8.3
	media-libs/libshout
	flac? ( >=media-libs/flac-1.1.2 )
	vorbis? ( media-libs/libvorbis )
	mad? ( media-libs/libmad
		media-libs/id3lib )
	=dev-db/sqlite-2*"

RDEPEND="${DEPEND}
	 <dev-python/pysqlite-2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-Makefile.patch
	epatch "${FILESDIR}"/${P}-gcc4.patch
	epatch "${FILESDIR}"/${P}+flac-1.1.3.patch
	epatch "${FILESDIR}"/${P}-metadata.patch
	epatch "${FILESDIR}"/${P}-sigkill.patch
	epatch "${FILESDIR}"/${P}-multilib.patch
	eautoreconf
}

src_compile() {
	econf --enable-shout \
	      $(use_enable vorbis) \
	      $(use_enable flac) \
	      $(use_enable mad mp3) \
	      $(use_enable mad id3)
	emake -j1 || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" libdir="/usr/$(get_libdir)" \
		install || die "emake install failed."
	dodoc README TODO API
	newinitd "${FILESDIR}"/bossogg.initd bossogg
}

pkg_postinst() {
	enewgroup bossogg
	enewuser bossogg -1 -1 /var/bossogg bossogg -G audio

	if ! [[ -d /var/bossogg ]]; then
		mkdir /var/bossogg
		chown bossogg:bossogg /var/bossogg
	fi

	elog "After running the /etc/init.d/bossogg service for the first"
	elog "time, /var/bossogg/.bossogg/bossogg.conf will be created."
	elog "Please edit this file and restart the service to setup."
	elog "the server."
}
