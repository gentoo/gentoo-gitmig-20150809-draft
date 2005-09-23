# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/yate/yate-0.9.0_pre1.ebuild,v 1.2 2005/09/23 00:04:39 stkn Exp $

IUSE="gsm gtk h323 ilbc zaptel"

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
	gsm? ( media-sound/gsm )"

src_compile() {
	econf \
		$(use_with gtk libgtk2 /usr) \
		$(use_with h323 openh323 /usr) \
		$(use_with h323 pwlib /usr) \
		$(use_with zaptel libpri) \
		$(use_with gsm libgsm) \
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
