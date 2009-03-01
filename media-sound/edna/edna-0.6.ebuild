# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/edna/edna-0.6.ebuild,v 1.1 2009/03/01 14:07:03 patrick Exp $

inherit eutils

IUSE="flac vorbis"

DESCRIPTION="Greg Stein's python streaming audio server for desktop or LAN use"
HOMEPAGE="http://edna.sourceforge.net/"

SRC_URI="mirror://sourceforge/edna/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86"

DEPEND="|| ( >=dev-lang/python-2.5 ( >=dev-lang/python-2.3 >=dev-python/ctypes-1.0.0 ) )
	flac? ( media-libs/mutagen )
	oggvorbis? ( dev-python/pyogg )"
RDEPEND=${DEPEND}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}"-SystemExit.patch
	epatch "${FILESDIR}/${P}"-flac.patch
	epatch "${FILESDIR}/${P}"-daemon.patch
	epatch "${FILESDIR}/${P}"-syslog.patch
}

src_install() {
	einfo "Installing in daemon mode"
	newinitd "${FILESDIR}"/edna.gentoo edna

	dodir /usr/bin /usr/$(get_libdir)/edna /usr/$(get_libdir)/edna/templates
	exeinto /usr/bin ; newexe edna.py edna
	exeinto /usr/$(get_libdir)/edna ; doexe ezt.py
	exeinto /usr/$(get_libdir)/edna ; doexe MP3Info.py
	insinto /usr/$(get_libdir)/edna/templates
	insopts -m 644
	doins templates/*
	insinto /usr/$(get_libdir)/edna/resources
	doins resources/*

	insinto /etc/edna
	insopts -m 644
	doins edna.conf
	dosym /usr/$(get_libdir)/edna/resources /etc/edna/resources
	dosym /usr/$(get_libdir)/edna/templates /etc/edna/templates

	dodoc README ChangeLog
	dohtml -r www/*
}

pkg_postinst() {
	enewgroup edna
	enewuser edna -1 -1 -1 edna

	einfo
	einfo "Edit edna.conf to taste before starting (multiple source"
	einfo "directories are allowed).  Test edna from a shell prompt"
	einfo "until you have it configured properly, then add edna to"
	einfo "the default runlevel when you're ready.  Add the USE flag"
	einfo "vorbis if you want edna to serve ogg files."
	einfo
	einfo "See edna.conf and the html docs for more info, and set"
	einfo "PYTHONPATH=/usr/lib/edna to run from a shell prompt."
	einfo
}
