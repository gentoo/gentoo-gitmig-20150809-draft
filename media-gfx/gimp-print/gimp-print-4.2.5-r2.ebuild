# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp-print/gimp-print-4.2.5-r2.ebuild,v 1.7 2004/02/12 15:32:32 lanius Exp $

inherit libtool

IUSE="nls gtk readline cups foomaticdb ppds"

DESCRIPTION="Gimp Print Drivers"
HOMEPAGE="http://gimp-print.sourceforge.net"
KEYWORDS="x86 ppc alpha sparc hppa amd64"
SRC_URI="mirror://sourceforge/gimp-print/${P}.tar.gz"

DEPEND="cups? ( >=net-print/cups-1.1.14 )
	media-gfx/imagemagick
	virtual/ghostscript
	sys-libs/readline
	gtk? ( =x11-libs/gtk+-1.2* )
	dev-lang/perl
	foomaticdb? ( net-print/foomatic-db-engine )"

LICENSE="GPL-2"
SLOT="0"

src_compile() {
	elibtoolize --reverse-deps

	local myconf

	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	use readline \
		&& myconf="${myconf} --with-readline" \
		|| myconf="${myconf} --without-readline"

	use gtk \
		&& myconf="${myconf} --enable-lexmarkutil" \
		|| myconf="${myconf} --disable-lexmarkutil"

	has_version =media-gfx/gimp-1.2* \
		&& myconf="${myconf} --with-gimp" \
		|| myconf="${myconf} --without-gimp"

	if [ "`use cups`" ]; then
		myconf="${myconf} --with-cups"
	else
		myconf="${myconf} --without-cups"
	fi

	use foomaticdb \
		&& myconf="${myconf} --with-foomatic3" \
		|| myconf="${myconf} --without-foomatic"

	econf \
		--enable-test \
		--with-ghosts \
		--with-user-guide \
		--with-samples \
		--with-escputil \
		--without-translated-ppds \
		$myconf || die

	# IJS Patch
	cp src/ghost/ijsgimpprint.c src/ghost/ijsgimpprint.c.org
	sed -e "s/<ijs/<ijs\/ijs/g" src/ghost/ijsgimpprint.c.org > src/ghost/ijsgimpprint.c

	emake || die "compile problem"
}

src_install () {
	make install DESTDIR=${D} || die

	if [ ! "`use ppds`" ]; then
		rm -fR ${D}/usr/share/cups/model/
	fi

	exeinto /usr/share/gimp-print
	doexe test/{unprint,pcl-unprint,bjc-unprint,parse-escp2,curve,escp2-weavetest,run-testdither,run-weavetest,testdither}

	dodoc AUTHORS COPYING ChangeLog NEWS README \
		doc/users_guide/users-guide.ps doc/users_guide/users-guide.pdf \
		${D}/usr/share/gimp-print/doc/gimpprint.ps
	dohtml doc/FAQ.html
	dohtml -r doc/users_guide/html doc/developer/developer-html
	rm -fR ${D}/usr/share/gimp-print/doc
}

pkg_postinst () {
	einfo "The gimp-print ebuild no longer creates the ppds automatically, please use foomatic"
	einfo "to do so or remerge gimp-print with the ppds use flag."
}
