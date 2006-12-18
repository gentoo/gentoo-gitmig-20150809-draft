# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/vdradmin-am/vdradmin-am-3.4.7.ebuild,v 1.3 2006/12/18 17:11:26 zzam Exp $

inherit eutils

DESCRIPTION="WWW Admin for the Video Disk Recorder"
HOMEPAGE="http://andreas.vdr-developer.org/"
SRC_URI="http://andreas.vdr-developer.org/download/${P}.tar.bz2"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE="unicode"

RDEPEND="dev-lang/perl
	dev-perl/Template-Toolkit
	>=dev-perl/Compress-Zlib-1.2.2
	media-video/vdr
	dev-perl/Compress-Zlib
	dev-perl/Locale-gettext
	dev-perl/Authen-SASL
	dev-perl/Digest-HMAC
	unicode? ( sys-devel/gettext )"

ETCDIR="/etc/vdradmin"
LIBDIR="/usr/share/vdradmin"

src_unpack() {

	unpack ${A}
	cd ${S}
}


src_compile() {

	if ! use unicode; then
		einfo "no need to compile"
	else
		einfo "additionally generating utf8 locales"
		${S}/make.sh utf8add || die
		${S}/make.sh po || die
	fi
}

src_install() {

	doinitd ${FILESDIR}/vdradmin

	dobin vdradmind.pl

	insinto ${LIBDIR}/template
	doins -r ${S}/template/*

	insinto ${LIBDIR}/lib
	doins -r ${S}/lib/*

	insinto /usr/share/locale/
	doins -r ${S}/locale/*

	dodoc COPYING HISTORY INSTALL CREDITS README* REQUIREMENTS FAQ
	docinto contrib
	dodoc ${S}/contrib/*

	keepdir /etc/vdradmin

	dosed "s:FILES_IN_SYSTEM    = 0;:FILES_IN_SYSTEM    = 1;:g" /usr/bin/vdradmind.pl
}

pkg_postinst() {
	echo
	einfo "run \"vdradmind.pl -c\" to setup ..."
	einfo "if this is a new install"
	echo
}
