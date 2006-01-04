# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp-print/gimp-print-5.0.0_rc1.ebuild,v 1.2 2006/01/04 09:28:18 flameeyes Exp $

inherit flag-o-matic libtool autotools

IUSE="cups foomaticdb gtk nls readline ppds"

MY_P=gutenprint-5.0.0-rc1

DESCRIPTION="Gimp Print Drivers"
HOMEPAGE="http://gimp-print.sourceforge.net"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ppc64"
SRC_URI="mirror://sourceforge/gimp-print/${MY_P}.tar.bz2"

RDEPEND="cups? ( >=net-print/cups-1.1.14 )
	media-gfx/imagemagick
	virtual/ghostscript
	sys-libs/readline
	gtk? ( x11-libs/gtk+ )
	dev-lang/perl
	foomaticdb? ( net-print/foomatic-db-engine )"

DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool"

LICENSE="GPL-2"
SLOT="0"

S=${WORKDIR}/${MY_P}

append-flags -fno-inline-functions

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-asneeded.patch"

	# get rid of the libtool.m4 file that's broken
	rm -f ${S}/m4extra/libtool.m4

	AT_M4DIR="m4 m4extra" eautoreconf
}

src_compile() {
	elibtoolize --reverse-deps

	if use cups && use ppds; then
		myconf="${myconf} --enable-cups-ppds --enable-cups-level3-ppds"
	else
		myconf="${myconf} --disable-cups-ppds"
	fi

	use foomaticdb \
		&& myconf="${myconf} --with-foomatic3" \
		|| myconf="${myconf} --without-foomatic"

	# --without-translated-ppds enabled \
	econf \
		--enable-test \
		--with-ghostscript \
		--with-user-guide \
		--with-samples \
		--with-escputil \
		$(use_enable nls) \
		$(use_with readline) \
		$(use_enable gtk lexmarkutil) \
		$(use_with cups) \
		$myconf || die

	# IJS Patch
	sed -i -e "s/<ijs/<ijs\/ijs/g" src/ghost/ijsgutenprint.c

	emake || die "compile problem"
}

src_install () {
	make install DESTDIR=${D} || die

	exeinto /usr/share/gutenprint
	doexe test/{unprint,pcl-unprint,bjc-unprint,parse-escp2,escp2-weavetest,run-testdither,run-weavetest,testdither}

	dodoc AUTHORS COPYING ChangeLog NEWS README \
		doc/users_guide/users-guide.ps doc/users_guide/users-guide.pdf \
		${D}/usr/share/gutenprint/doc/gutenprint.pdf
	dohtml doc/FAQ.html
	dohtml -r doc/users_guide/html doc/developer/developer-html
	rm -fR ${D}/usr/share/gutenprint/doc
}
