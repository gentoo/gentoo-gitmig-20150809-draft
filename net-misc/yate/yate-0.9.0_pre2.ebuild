# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/yate/yate-0.9.0_pre2.ebuild,v 1.1 2005/10/29 15:55:35 stkn Exp $

IUSE="gsm gtk h323 ilbc postgres zaptel"

inherit eutils

DESCRIPTION="YATE - Yet Another Telephony Engine"
HOMEPAGE="http://yate.null.ro/"
SRC_URI="http://voip.null.ro/tarballs/${P/_/}.tar.gz"

S=${WORKDIR}/${PN}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

DEPEND="media-sound/sox
	zaptel? ( >=net-libs/libpri-1.0.0
	          >=net-misc/zaptel-1.0.0 )
	h323? ( >=net-libs/openh323-1.15.3 )
	gtk? ( >=x11-libs/gtk+-2.6.8 )
	gsm? ( media-sound/gsm )
	postgres? ( dev-db/postgresql )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# fix gtk2 plugin makefile
	epatch ${FILESDIR}/${PN}-0.9.0-gtk2.diff
}

src_compile() {
	econf \
		$(use_with gtk libgtk2 /usr) \
		$(use_with h323 openh323 /usr) \
		$(use_with h323 pwlib /usr) \
		$(use_with zaptel libpri) \
		$(use_with gsm libgsm) \
		$(use_with postgres libpq /usr) \
		$(use_enable ilbc) \
		|| die "Configure failed"
	emake everything || die "Make failed"
}

src_install() {
	emake DESTDIR=${D} install || die "Make install failed"

	newinitd ${FILESDIR}/yate.rc6 yate
	newconfd ${FILESDIR}/yate.confd yate

	# install standard docs...
	dodoc README ChangeLog docs/*

	docinto scripts
	dodoc scripts/*
}
