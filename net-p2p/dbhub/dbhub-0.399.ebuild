# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dbhub/dbhub-0.399.ebuild,v 1.1 2007/01/26 17:17:08 armin76 Exp $

inherit eutils

DESCRIPTION="hub software for Direct Connect, fork of opendchub"
HOMEPAGE="http://dbhub.ir.pl/"
SRC_URI="http://mieszkancy.ds.pg.gda.pl/~centurion/darkbot/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lang/perl"

src_unpack() {
	unpack ${A}
	mv ${P}-dev* ${P}
	cd "${S}"
	epatch ${FILESDIR}/dbhub-gentoo.patch
}


src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	doexe ${FILESDIR}/dbhub_setup.sh

	dodir /usr/share/dbhub/scripts
	insinto /usr/share/dbhub/scripts
	doins Samplescripts/*

	dodoc Documentation/*
}

pkg_postinst() {
	einfo
	einfo "To set up perl scripts for dbhub to use, please run"
	einfo "dbhub_setup.sh as the user you will be using dbhub as."
	einfo
}
