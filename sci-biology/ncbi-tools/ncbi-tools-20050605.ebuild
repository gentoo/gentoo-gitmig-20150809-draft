# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/ncbi-tools/ncbi-tools-20050605.ebuild,v 1.2 2005/08/08 23:39:13 ranger Exp $

inherit flag-o-matic toolchain-funcs eutils

DESCRIPTION="Development toolkit and applications (BLAST, entrez, ddv, udv, sequin...) for computational biology"
LICENSE="public-domain"
HOMEPAGE="http://www.ncbi.nlm.nih.gov/"
SRC_URI="mirror://gentoo/${P}.tar.gz
	doc? ( mirror://gentoo/${PN}-sdk-doc.tar.bz2 )"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~ppc-macos ~ppc64"
IUSE="doc X"

DEPEND="app-shells/tcsh
	dev-lang/perl
	media-libs/libpng
	X? ( virtual/x11
		virtual/motif
	)"

S="${WORKDIR}/ncbi"

pkg_setup() {
	echo
	ewarn 'It is important to note that the NCBI tools (especially the X'
	ewarn 'applications) are known to have compilation and run-time'
	ewarn 'problems when compiled with agressive compilation flags. The'
	ewarn '"-O3" flag is filtered by the ebuild on the x86 architecture if'
	ewarn 'X support is enabled. If you experience difficulties with this'
	ewarn 'package and use agressive "CFLAGS", lower the "CFLAGS" and try'
	ewarn 'to install the NCBI tools again.'
	echo
}

src_unpack() {
	unpack ${A}

	use ppc64 && cd ${S} && epatch ${FILESDIR}/${P}-lop.patch.gz

	if ! use X; then
		cd ${S}/make
		sed -e "s:\#set HAVE_OGL=0:set HAVE_OGL=0:" \
			-e "s:\#set HAVE_MOTIF=0:set HAVE_MOTIF=0:" \
			-i makedis.csh || die
	else
		if use x86; then
			# X applications segfault on startup on x86 with -O3.
			replace-flags '-O3' '-O2'
		fi
	fi

	# Apply user C flags...
	cd ${S}/platform
	# ... on x86...
	sed -e "s/NCBI_CFLAGS1 = -c/NCBI_CFLAGS1 = -c ${CFLAGS}/" \
		-e "s/NCBI_LDFLAGS1 = -O3 -mcpu=pentium4/NCBI_LDFLAGS1 = ${CFLAGS}/" \
		-e "s/NCBI_OPTFLAG = -O3 -mcpu=pentium4/NCBI_OPTFLAG = ${CFLAGS}/" \
		-i linux-x86.ncbi.mk || die
	# ... on alpha...
	sed -e "s/NCBI_CFLAGS1 = -c/NCBI_CFLAGS1 = -c ${CFLAGS}/" \
		-e "s/NCBI_LDFLAGS1 = -O3 -mieee/NCBI_LDFLAGS1 = -mieee ${CFLAGS}/" \
		-e "s/NCBI_OPTFLAG = -O3 -mieee/NCBI_OPTFLAG = -mieee ${CFLAGS}/" \
		-i linux-alpha.ncbi.mk || die
	# ... on hppa...
	sed -e "s/NCBI_CFLAGS1 = -c/NCBI_CFLAGS1 = -c ${CFLAGS}/" \
		-e "s/NCBI_LDFLAGS1 = -O2/NCBI_LDFLAGS1 = ${CFLAGS}/" \
		-e "s/NCBI_OPTFLAG = -O2/NCBI_OPTFLAG = ${CFLAGS}/" \
		-i hppalinux.ncbi.mk || die
	# ... on ppc...
	sed -e "s/NCBI_CFLAGS1 = -c/NCBI_CFLAGS1 = -c ${CFLAGS}/" \
		-e "s/NCBI_LDFLAGS1 = -O2/NCBI_LDFLAGS1 = ${CFLAGS}/" \
		-e "s/NCBI_OPTFLAG = -O2/NCBI_OPTFLAG = ${CFLAGS}/" \
		-i ppclinux.ncbi.mk || die
	# ... on generic Linux.
	sed -e "s/NCBI_CFLAGS1 = -c/NCBI_CFLAGS1 = -c ${CFLAGS}/" \
		-e "s/NCBI_LDFLAGS1 = -O3/NCBI_LDFLAGS1 = ${CFLAGS}/" \
		-e "s/NCBI_OPTFLAG = -O3/NCBI_OPTFLAG = ${CFLAGS}/" \
		-i linux.ncbi.mk || die

	# Put in our MAKEOPTS (doesn't work).
	# sed -e "s:make \$MFLG:make ${MAKEOPTS}:" -i ncbi/make/makedis.csh

	# Set C compiler...
	# ... on x86...
	sed -i -e "s/NCBI_CC = gcc/NCBI_CC = $(tc-getCC)/" linux-x86.ncbi.mk || die
	# ... on alpha...
	sed -i -e "s/NCBI_CC = gcc/NCBI_CC = $(tc-getCC)/" linux-alpha.ncbi.mk || die
	# ... on hppa...
	sed -i -e "s/NCBI_CC = gcc/NCBI_CC = $(tc-getCC)/" hppalinux.ncbi.mk || die
	# ... on ppc...
	sed -i -e "s/NCBI_CC = gcc/NCBI_CC = $(tc-getCC)/" ppclinux.ncbi.mk || die
	# ... on generic Linux.
	sed -i -e "s/NCBI_CC = gcc/NCBI_CC = $(tc-getCC)/" linux.ncbi.mk || die
}

src_compile() {
	cd ${WORKDIR}
	ncbi/make/makedis.csh || die
	mkdir ${S}/cgi
	mkdir ${S}/real
	mv ${S}/bin/*.cgi ${S}/cgi
	mv ${S}/bin/*.REAL ${S}/real
}

src_install() {
	dobin ${S}/bin/*
	dolib ${S}/lib/*
	mkdir -p ${D}/usr/include/ncbi
	cp -RL ${S}/include/* ${D}/usr/include/ncbi

	# TODO: Web apps
	#insinto /usr/share/ncbi/lib/cgi
	#doins ${S}/cgi/*
	#insinto /usr/share/ncbi/lib/real
	#doins ${S}/real/*
	# TODO: Add support for wwwblast.

	# Basic documentation
	dodoc ${S}/{README,VERSION,doc/{*.txt,README.asn2xml}}
	newdoc ${S}/doc/fa2htgs/README README.fa2htgs
	newdoc ${S}/config/README README.config
	newdoc ${S}/network/encrypt/README README.encrypt
	newdoc ${S}/network/nsclilib/readme README.nsclilib
	newdoc ${S}/sequin/README README.sequin
	doman ${S}/doc/man/*

	# Hypertext user documentation
	dohtml ${S}/{README.html,doc/{*.html *.gif}}
	insinto /usr/share/doc/${PF}/html/blast
	doins ${S}/doc/blast/*

	# Developer documentation
	if use doc; then
		# "socks" documentation
		SOCKS="network/socks/socks.cstc.4.2"
		insinto /usr/share/doc/${PF}/socks
		doins ${S}/${SOCKS}/{CHANGES,How_to_SOCKSify,README.{1st,4.{0,1,2},DK},What_are_the_risks,What_SOCKS_expects}
		newins ${S}/${SOCKS}/libident/README README.libident
		doins ${S}/${SOCKS}/sockd/sockd.conf.sample
		doman ${S}/${SOCKS}/{doc/*.{1,5,8},libident/ident.3}
		# "regexp" documentation
		insinto /usr/share/doc/${PF}/regexp
		doins ${S}/regexp/doc/{AUTHORS,NEWS,README,Tech.Notes,*.txt}
		insinto /usr/share/doc/${PF}/regexp/html
		doins ${S}/regexp/doc/*.html
		doman ${S}/regexp/doc/*.{1,3}
		# Hypertext SDK documentation
		insinto /usr/share/doc/${PF}/html/sdk
		doins ${WORKDIR}/${PN}-sdk-doc/*
		# Demo programs
		mkdir ${D}/usr/share/ncbi
		mv ${S}/demo ${D}/usr/share/ncbi/demo
		mv ${S}/regexp/demo ${D}/usr/share/ncbi/demo/regexp
		mv ${S}/regexp/test ${D}/usr/share/ncbi/demo/regexp/test
	fi

	# Shared data (similarity matrices and such) and database directory.
	insinto /usr/share/ncbi/data
	doins ${S}/data/*
	dodir /usr/share/ncbi/formatdb

	# Default config file to set the path for shared data.
	insinto /etc/ncbi
	newins ${FILESDIR}/ncbirc .ncbirc

	# Env file to set the location of the config file and BLAST databases.
	newenvd ${FILESDIR}/21ncbi-r1 21ncbi
}
