# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/app-i18n/canna/canna-3.5_beta2-r1.ebuild,v 1.1 2002/06/02 23:03:24 wmertens Exp

KEYWORDS="x86"

DESCRIPTION="A client-server based Kana-Kanji conversion system"
HOMEPAGE="http://www.nec.co.jp/canna/"
LICENSE="as-is"

A="Canna35b2.tar.gz"
S="${WORKDIR}/Canna35b2"

SRC_URI="ftp://ftp.tokyonet.ad.jp/pub/misc/Canna/Canna35/${A}"

RDEPEND="virtual/glibc"
DEPEND="$RDEPEND"

SLOT=0

src_unpack() {

	# unpack the archive
	unpack ${A}

	# patch Canna.conf to ensure that files are installed into image dir
	cd Canna35b2
	patch -p0 < ${FILESDIR}/${PF}/gentoo.diff || die
}

src_compile() {

	# create a Makefile from Canna.conf
	xmkmf         || die "xmkmf failed"
	make Makefile || die "Makefile creation failed"

	# build Canna - emake causes trouble on my system so playing safe
	make canna   || die "Canna build failed"
}

src_install () {

	# install libs, executables, dictionaries
	make DESTDIR=${D} install     || die "installation failed"

	# install man pages
	make DESTDIR=${D} install.man || die "installation of manpages failed"

	# install docs
	dodoc README WHATIS

	# install rc script and its config file
	exeinto /etc/init.d ; newexe ${FILESDIR}/${PF}/canna.initd canna
	insinto /etc/conf.d ; newins ${FILESDIR}/${PF}/canna.confd canna
}
