# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/lout/lout-3.29.ebuild,v 1.1 2004/06/06 15:58:17 usata Exp $

inherit eutils

IUSE="zlib doc"

DESCRIPTION="high-level language for document formatting"
HOMEPAGE="http://lout.sourceforge.net/"
SRC_URI="mirror://sourceforge/lout/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="zlib? ( >=sys-libs/zlib-1.1.4 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Apply the makefile patch
	epatch ${FILESDIR}/${P}-makefile-gentoo.patch
}

src_compile() {
	local myconf
	myconf="BASEDIR=/usr"
	use zlib && myconf="$myconf PDF_COMPRESSION=1 ZLIB=/usr/lib/libz.a"
	emake prg2lout lout ${myconf} || die "emake prg2lout lout failed"
}

compile_doc() {
	#
	# SYNOPSIS:  compile_doc file times
	#

	einfo "${1}:"
	# yes, it *is* necessary to run this 6 times...
	for i in $(seq 1 $(expr $2 - 1)) ; do
		einfo " pass $i"
		lout all -o ${docdir}/$1 -e /dev/null
	done
	# in the last one, let errors be reported
	einfo " final pass"
	lout all -o ${docdir}/$1 || die "final pass failed"
}

src_install() {
	local docdir
	docdir=${D}/usr/share/doc/${P}

	emake BASEDIR=${D}/usr DOCDIR=${docdir} \
		installbin installlib installdoc installman \
		|| die "emake install failed"

	export LOUTLIB=${D}/usr/share/lout/
	export PATH="${D}/usr/bin:${PATH}"

	lout -x -s ${D}/usr/share/lout/include/init || die "lout init failed"

	mv ${docdir}/README{,.docs}
	dodoc README READMEPDF blurb blurb.short whatsnew

	if use doc ; then
		einfo "building postscript documentation (may take a while)"
		cd doc/user
		compile_doc user.ps 6
		cd ../design
		compile_doc design.ps 3
		cd ../expert
		compile_doc expert.ps 4
		cd ../slides
		compile_doc slides.ps 2
	fi
}
