# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/yate/yate-0.8.7.ebuild,v 1.1 2005/03/21 01:56:47 stkn Exp $

IUSE="h323 postgres zaptel fax qt gtk gsm ortp"

inherit eutils

DESCRIPTION="YATE - Yet Another Telephony Engine"
HOMEPAGE="http://yate.null.ro/"
SRC_URI="http://voip.null.ro/tarballs/${P}.tar.gz"

S=${WORKDIR}/${PN}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="media-sound/sox
	postgres? ( dev-db/postgresql )
	zaptel? ( >=net-libs/libpri-1.0.0
	       >=net-misc/zaptel-1.0.0 )
	h323? ( >=net-libs/openh323-1.13.0 )
	fax? ( >=media-libs/spandsp )
	qt? ( x11-libs/qt )
	gtk? ( <x11-libs/gtk+-2.0.0 )
	gsm? ( media-sound/gsm )
	ortp? ( net-libs/ortp )"


src_compile() {
	local myconf

	use postgres \
		&& myconf="${myconf} --with-libpq=/usr" \
		|| myconf="${myconf} --without-libpq"

	use fax \
		&& myconf="${myconf} --with-spandsp=/usr" \
		|| myconf="${myconf} --without-spandsp"

	use qt \
		&& myconf="${myconf} --with-libqt=${QTDIR}" \
		|| myconf="${myconf} --without-libqt"

	use gtk \
		&& myconf="${myconf} --with-libgtk" \
		|| myconf="${myconf} --without-libgtk"

	use h323 \
		&& myconf="${myconf} --with-openh323=/usr --with-pwlib=/usr" \
		|| myconf="${myconf} --without-openh323 --without-pwlib"

	use zaptel \
		&& myconf="${myconf} --with-libpri" \
		|| myconf="${myconf} --without-libpri"

	use gsm \
		&& myconf="${myconf} --with-libgsm" \
		|| myconf="${myconf} --without-libgsm"

	use ortp \
		&& myconf="${myconf} --with-libortp=/usr" \
		|| myconf="${myconf} --without-libortp"

	econf ${myconf} || die "Configure failed"
	emake everything || die "Make failed"
}

src_install() {
	emake DESTDIR=${D} install || die "Make install failed"

	exeinto /etc/init.d
	newexe  ${FILESDIR}/yate.rc6 yate

	insinto /etc/conf.d
	newins  ${FILESDIR}/yate.confd yate

	# install standard docs...
	dodoc README ChangeLog
	dodoc docs/*

	docinto scripts
	dodoc scripts/*
}
