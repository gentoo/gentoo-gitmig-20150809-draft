# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/jed/jed-0.99.16.ebuild,v 1.8 2004/04/06 03:37:20 vapier Exp $

inherit eutils

P0=${PN}-0.99-16
S=${WORKDIR}/${P0}
DESCRIPTION="Console S-Lang-based editor"
HOMEPAGE="http://www.jedsoft.org/jed/"
SRC_URI="ftp://ftp.jedsoft.org/pub/davis/jed/v0.99/${PN}-0.99-16.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="X gpm"

DEPEND=">=sys-libs/slang-1.4.5
	X? ( virtual/x11 )
	gpm? ( sys-libs/gpm )"
PROVIDE="virtual/editor"

src_compile() {
	export JED_ROOT=/usr/share/jed

	./configure	\
		--host=${CHOST} \
		--prefix=$PJED_ROOT} \
		--bindir=/usr/bin \
		--mandir=/usr/share/man || die

	if use gpm ; then
		cd src
		sed -i 	-e 's/#MOUSEFLAGS/MOUSEFLAGS/' \
			-e 's/#MOUSELIB/MOUSELIB/' \
			-e 's/#GPMMOUSEO/GPMMOUSEO/' \
			-e 's/#OBJGPMMOUSEO/OBJGPMMOUSEO/' \
			Makefile
		cd ${S}
	fi

	make clean || die

	emake || die

	if use X ; then
		emake xjed || die
	fi
}

src_install() {
	make DESTDIR=${D} install || die

	cd doc
	cp README AUTHORS

	cd ${S}
	dodoc INSTALL INSTALL.unx README doc/AUTHORS doc/manual/jed.tex

	cd ${S}/info
	rm info.info
	epatch${FILESDIR}/jed.info.diff
	cd ${S}

	insinto /usr/share/info
	doins info/*

	insinto /etc
	doins lib/jed.conf

	cd ${D}
	rm -rf usr/share/jed/info
	# can't rm usr/share/jed/doc -- used internally by jed/xjed
}
