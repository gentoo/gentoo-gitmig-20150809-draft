# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp-print/gimp-print-5.0.0_beta3.ebuild,v 1.2 2005/04/09 15:49:06 corsair Exp $

inherit flag-o-matic libtool

IUSE="cups foomaticdb gtk nls readline"

MY_P=gutenprint-5.0.0-beta3

DESCRIPTION="Gimp Print Drivers"
HOMEPAGE="http://gimp-print.sourceforge.net"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ppc64"
SRC_URI="mirror://sourceforge/gimp-print/${MY_P}.tar.bz2"

DEPEND="cups? ( >=net-print/cups-1.1.14 )
	media-gfx/imagemagick
	virtual/ghostscript
	sys-libs/readline
	gtk? ( =x11-libs/gtk+-1.2* )
	dev-lang/perl
	foomaticdb? ( net-print/foomatic-db-engine )"

LICENSE="GPL-2"
SLOT="0"

S=${WORKDIR}/${MY_P}

append-flags -fno-inline-functions

src_compile() {
	elibtoolize --reverse-deps

	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	use readline \
		&& myconf="${myconf} --with-readline" \
		|| myconf="${myconf} --without-readline"

	use gtk \
		&& myconf="${myconf} --enable-lexmarkutil" \
		|| myconf="${myconf} --disable-lexmarkutil"

	if use cups; then
		myconf="${myconf} --with-cups"
	else
		myconf="${myconf} --without-cups"
	fi

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
