# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/entrance/entrance-0.9.0.20031013.ebuild,v 1.1 2003/10/14 03:48:50 vapier Exp $

inherit enlightenment eutils

DESCRIPTION="next generation of Elogin, a login/display manager for X"
HOMEPAGE="http://xcomputerman.com/pages/entrance.html"
SRC_URI="${SRC_URI}
	mirror://gentoo/extraicons-1.tar.bz2
	http://wh0rd.de/gentoo/distfiles/extraicons-1.tar.bz2"

DEPEND="${DEPEND}
	virtual/x11
	sys-libs/pam
	>=dev-db/edb-1.0.4.20031013
	>=x11-libs/evas-1.0.0.20031013_pre11
	>=x11-libs/ecore-0.0.2.20031013_pre4
	>=media-libs/edje-0.0.1.20031013"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gentoo-sessions.patch
	gettext_modify
}

src_install() {
	enlightenment_src_install
	insinto /etc/pam.d
	doins config/pam.d/entrance
	insinto /usr/share/entrance/images/sessions
	doins ${WORKDIR}/extraicons/*
	exeinto /usr/share/entrance
	doexe data/config/build_config.sh
}

pkg_postinst() {
	cd /usr/share/entrance
	./build_config.sh || die
}
