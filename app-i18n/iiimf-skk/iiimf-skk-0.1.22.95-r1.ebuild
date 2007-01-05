# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/iiimf-skk/iiimf-skk-0.1.22.95-r1.ebuild,v 1.2 2007/01/05 16:18:31 flameeyes Exp $

inherit eutils

DESCRIPTION="SKK Language Engine inputh method module for IIIMF"
HOMEPAGE="http://www.momonga-linux.org/~famao/iiimf-skk/"
SRC_URI="mirror://sourceforge.jp/iiimf-skk/9344/${P}.tar.gz
	http://dev.gentoo.org/~usata/misc/${P}-db4-gentoo.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls canna debug"

DEPEND="virtual/libc
	>=sys-libs/db-3
	>=x11-libs/gtk+-2
	dev-libs/libxml2
	app-i18n/im-sdk
	virtual/skkserv
	canna? ( app-i18n/canna )"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${DISTDIR}/${P}-db4-gentoo.diff.gz
}

src_compile() {

	local myconf
	# configure script is broken wrt --disable-*
	myconf="${myconf} --enable-gtk2"
	use nls && myconf="${myconf} --enable-nls"
	use debug && myconf="${myconf} --enable-debug"
	use canna && myconf="${myconf} --enable-canna"

	econf \
		--with-skkserv-host="localhost" \
		--with-skkserv-port=1178 \
		${myconf} || die "econf failed"
	emake -j1 || die
}

src_install () {

	make DESTDIR=${D} install || die

	newbin ${FILESDIR}/iiimf-skk.sh iiimf-skk

	dodoc ABOUT-NLS AUTHORS ChangeLog INSTALL NEWS README
}

pkg_postinst() {

	elog
	elog "To use this module, follow these steps:"
	elog "(1) run /etc/init.d/iiim start (as root)"
	elog "(2) run iiimf-skk (as normal user)"
	elog "(3) export XMODIFIERS='@im=htt' (setenv XMODIFIERS '@im=htt' in csh)"
	elog
}
