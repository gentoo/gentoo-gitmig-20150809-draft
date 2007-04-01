# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/freetype/freetype-2.1.9-r1.ebuild,v 1.25 2007/04/01 04:48:12 dirtyepic Exp $

inherit eutils flag-o-matic libtool

SPV="`echo ${PV} | cut -d. -f1,2`"

DESCRIPTION="A high-quality and portable font engine"
HOMEPAGE="http://www.freetype.org/"
SRC_URI="mirror://sourceforge/freetype/${P/_/}.tar.bz2
	doc? ( mirror://sourceforge/${PN}/ftdocs-${PV}.tar.bz2 )"

LICENSE="FTL GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
#IUSE="zlib bindist cjk doc"
IUSE="zlib bindist doc"

# The RDEPEND below makes sure that if there is a version of moz/ff/tb
# installed, then it will have the freetype-2.1.8+ binary compatibility patch.
# Otherwise updating freetype will cause moz/ff/tb crashes.  #59849
# 20 Nov 2004 agriffis
DEPEND="virtual/libc
	zlib? ( sys-libs/zlib )"

RDEPEND="${DEPEND}
	!<www-client/mozilla-1.7.3-r3
	!<www-client/mozilla-firefox-1.0-r3
	!<mail-client/mozilla-thunderbird-0.9-r3
	!<media-libs/libwmf-0.2.8.2"

src_unpack() {

	unpack ${A}

	cd ${S}
	# add autohint patch from http://www.kde.gr.jp/~akito/patch/freetype2/
	# FIXME : patch hasn't been updated yet
	# use cjk && epatch ${FILESDIR}/${SPV}/${P}-autohint-cjkfonts-20031130.patch
	epatch ${FILESDIR}/${P}-fix_bci.patch

	uclibctoolize
	epunt_cxx

}

src_compile() {

	# https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=118021
	append-flags "-fno-strict-aliasing"

	use bindist || append-flags -DTT_CONFIG_OPTION_BYTECODE_INTERPRETER

	make setup CFG="--host=${CHOST} --prefix=/usr `use_with zlib` --libdir=/usr/$(get_libdir)" unix || die

	emake || die

	# Just a check to see if the Bytecode Interpreter was enabled ...
	if [ -z "`grep TT_Goto_CodeRange ${S}/objs/.libs/libfreetype.so`" ]
	then
		ewarn "Bytecode Interpreter is disabled."
	fi

}

src_install() {

	# make prefix=${D}/usr install || die
	make DESTDIR="${D}" install || die

	dodoc ChangeLog README
	dodoc docs/{CHANGES,CUSTOMIZE,DEBUG,*.txt,PATENTS,TODO}

	use doc && dohtml -r docs/*

}
