# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.6 2002/05/07 03:58:19 drobbins Exp

A="kinput2-v3.1-beta4.tar.gz"

S="${WORKDIR}/kinput2-v3.1-beta4"

DESCRIPTION="A Japanese input server which supports the XIM protocol"

SRC_URI="ftp://ftp.sra.co.jp/pub/x11/kinput2/${A}"

LICENSE="as-is"

DEPEND="virtual/glibc
        >=app-i18n/canna-3.5_beta2"

src_unpack() {

	# unpack the archive
	unpack ${A}

	# patch Kinput2.conf to ensure that files are installed into image dir
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}/gentoo.diff || die
}

src_compile() {

	# create a Makefile from Kinput2.conf
	xmkmf          || die "xmkmf failed"
	make Makefiles || die "Makefile creation failed"

	# build Kinput2
	make depend ; make
}

src_install () {

	# install libs, executables, dictionaries
	make DESTDIR=${D} install     || die "installation failed"

	# install docs
	dodoc README NEWS
}
