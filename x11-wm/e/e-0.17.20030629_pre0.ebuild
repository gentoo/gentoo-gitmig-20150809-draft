# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/e/e-0.17.20030629_pre0.ebuild,v 1.4 2004/06/24 23:40:27 agriffis Exp $

inherit enlightenment

DESCRIPTION="window manager and desktop shell"
HOMEPAGE="http://www.enlightenment.org/pages/enlightenment.html"

DEPEND="${DEPEND}
	virtual/x11
	>=media-libs/imlib2-1.0.6.2003*
	>=x11-libs/evas-1.0.0.2003*
	>=dev-db/edb-1.0.3.2003*
	>=media-libs/ebits-1.0.1.2003*
	>=x11-libs/ecore-0.0.2.2003*
	>=sys-fs/efsd-0.0.1.2003*
	>=media-libs/ebg-1.0.0.2003*
	>=media-libs/imlib2_loaders-1.0.4.2003*
	>=media-libs/freetype-2.1.3*
	perl? ( dev-lang/perl )"

S=${WORKDIR}/${PN}

pkg_setup() {
	eerror "Sorry, but this package is broken at the moment."
	eerror "That is because it has not been updated to use"
	eerror "all the latest EFL (Enlightened Foundation Libraries)."
	eerror "Next time you see an update here though, this package"
	eerror "will work ! :)"
	die "unmaintained code"
}

src_install() {
	enlightenment_src_install

	# fix name clash with 0.16.x
	cd ${D}/usr/bin
	mv enlightenment{,-0.17}

	exeinto /etc/X11/Sessions
	doexe ${FILESDIR}/e17
}
