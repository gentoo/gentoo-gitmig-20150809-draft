# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/canna/canna-3.5_beta2.ebuild,v 1.1 2002/06/01 13:40:35 wmertens Exp $

A="Canna35b2.tar.gz"

S="${WORKDIR}/Canna35b2"

DESCRIPTION="A client-server based Kana-Kanji conversion system"

SRC_URI="ftp://ftp.tokyonet.ad.jp/pub/misc/Canna/Canna35/${A}"

HOMEPAGE="http://www.nec.co.jp/canna/"

LICENSE="as-is"

DEPEND="virtual/glibc"

src_unpack() {

	# unpack the archive
	unpack ${A}

	# patch Canna.conf to ensure that files are installed into image dir
	patch -p0 < ${FILESDIR}/${P}/gentoo.diff || die
}

src_compile() {

	# create a Makefile from Canna.conf
	xmkmf         || die "xmkmf failed"
	make Makefile || die "Makefile creation failed"

	# build Canna
	emake canna   || die "Canna build failed"
}

src_install () {

	# install libs, executables, dictionaries
	make DESTDIR=${D} install     || die "installation failed"

	# install man pages
	make DESTDIR=${D} install.man || die "installation of manpages failed"

	# install docs
	dodoc README WHATIS

	# install rc script and its config file
	exeinto /etc/init.d ; newexe ${FILESDIR}/${P}/canna.initd canna
	insinto /etc/conf.d ; newins ${FILESDIR}/${P}/canna.confd canna
}
