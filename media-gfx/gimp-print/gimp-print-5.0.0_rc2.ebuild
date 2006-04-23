# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp-print/gimp-print-5.0.0_rc2.ebuild,v 1.6 2006/04/23 09:23:36 flameeyes Exp $

inherit flag-o-matic libtool eutils autotools

IUSE="cups foomaticdb gtk nls readline ppds"

MY_P=gutenprint-${PV/_/-}

DESCRIPTION="Gimp Print Drivers"
HOMEPAGE="http://gimp-print.sourceforge.net"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ppc64"
SRC_URI="mirror://sourceforge/gimp-print/${MY_P}.tar.bz2
	mirror://gentoo/${MY_P}-m4-2.patch.bz2"

RDEPEND="cups? ( >=net-print/cups-1.1.14 )
	media-gfx/imagemagick
	virtual/ghostscript
	sys-libs/readline
	gtk? ( x11-libs/gtk+ )
	dev-lang/perl
	foomaticdb? ( net-print/foomatic-db-engine )"
DEPEND="${RDEPEND}
	gtk? ( dev-util/pkgconfig )"

LICENSE="GPL-2"
SLOT="0"

S=${WORKDIR}/${MY_P}

append-flags -fno-inline-functions

pkg_setup() {
	if has_version media-gfx/gimp && built_with_use media-gfx/gimp gimpprint; then
		ewarn "gimpprint is not yet available due to the API Change in version 5.0"
		ewarn "Please remerge gimp with USE=-gimpprint to avoid collissions"
		die "gimp with gimpprint USE-flag detected"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${MY_P}-asneeded.patch"
	epatch "${WORKDIR}/${MY_P}-m4-2.patch"

	# Remove the broken libtool.m4
	rm ${S}/m4extra/libtool.m4

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
		$myconf || die "econf failed"

	# IJS Patch
	sed -i -e "s/<ijs/<ijs\/ijs/g" src/ghost/ijsgutenprint.c || die "sed failed"

	emake || die "emake failed"
}

src_install () {
	make install DESTDIR=${D} || die "make install failed"

	exeinto /usr/share/gutenprint
	doexe test/{unprint,pcl-unprint,bjc-unprint,parse-escp2,escp2-weavetest,run-testdither,run-weavetest,testdither}

	dodoc AUTHORS COPYING ChangeLog NEWS README \
		doc/users_guide/users-guide.ps doc/users_guide/users-guide.pdf \
		${D}/usr/share/gutenprint/doc/gutenprint.pdf
	dohtml doc/FAQ.html
	dohtml -r doc/users_guide/html doc/developer/developer-html
	rm -fR ${D}/usr/share/gutenprint/doc
}
