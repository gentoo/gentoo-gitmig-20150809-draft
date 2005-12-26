# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/edna/edna-0.5-r5.ebuild,v 1.4 2005/12/26 14:27:48 lu_zero Exp $

inherit eutils

IUSE="vorbis"

DESCRIPTION="Greg Stein's python streaming audio server for desktop or LAN use"
HOMEPAGE="http://edna.sourceforge.net/"

SRC_URI="mirror://sourceforge/edna/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"

DEPEND="dev-lang/python
	vorbis? ( dev-python/pyogg
		dev-python/pyvorbis )"

src_unpack() {
	unpack ${A}
	cd ${S}
	if has_version '>=dev-lang/python-2.3' ; then
		epatch ${FILESDIR}/${P}-pep-0263.patch || die "epatch failed"
	fi
}

src_install() {
	einfo "Installing in daemon mode"
	newinitd ${FILESDIR}/edna.gentoo edna

	dodir /usr/bin /usr/$(get_libdir)/edna /usr/$(get_libdir)/edna/templates
	exeinto /usr/bin ; newexe edna.py edna
	exeinto /usr/$(get_libdir)/edna ; doexe ezt.py
	exeinto /usr/$(get_libdir)/edna ; doexe MP3Info.py
	insinto /usr/$(get_libdir)/edna/templates
	insopts -m 644
	doins templates/*

	insinto /etc/edna
	insopts -m 644
	doins edna.conf
	dosym /usr/$(get_libdir)/edna/templates /etc/edna/templates

	dodoc README ChangeLog
	dohtml -r www/*
}

pkg_postinst() {
	ewarn
	einfo "Edit edna.conf to taste before starting (multiple source"
	einfo "directories are allowed).  Test edna from a shell prompt"
	einfo "until you have it configured properly, then add edna to"
	einfo "the default runlevel when you're ready.  Add the USE flag"
	einfo "vorbis if you want edna to serve ogg files."
	einfo
	einfo "See edna.conf and the html docs for more info, and set"
	einfo "PYTHONPATH=/usr/lib/edna to run from a shell prompt."
	ewarn
}
