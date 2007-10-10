# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp-print/gimp-print-5.1.3.ebuild,v 1.2 2007/10/10 19:08:45 genstef Exp $

inherit flag-o-matic eutils multilib

IUSE="cups foomaticdb gimp gtk readline ppds"

MY_P=gutenprint-${PV/_/-}

DESCRIPTION="Gimp Print Drivers"
HOMEPAGE="http://gimp-print.sourceforge.net"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ppc64"
SRC_URI="mirror://sourceforge/gimp-print/${MY_P}.tar.bz2"
RESTRICT="test"

RDEPEND="cups? ( >=net-print/cups-1.1.14 )
	virtual/ghostscript
	sys-libs/readline
	gtk? ( >=x11-libs/gtk+-2.0 )
	gimp? ( >=media-gfx/gimp-2.2 >=x11-libs/gtk+-2.0 )
	dev-lang/perl
	foomaticdb? ( net-print/foomatic-db-engine )"
DEPEND="${RDEPEND}
	gtk? ( dev-util/pkgconfig )"

LICENSE="GPL-2"
SLOT="0"

S=${WORKDIR}/${MY_P}

append-flags -fno-inline-functions

src_compile() {
	if use cups && use ppds; then
		myconf="${myconf} --enable-cups-ppds --enable-cups-level3-ppds"
	else
		myconf="${myconf} --disable-cups-ppds"
	fi

	if use gtk || use gimp; then
		myconf="${myconf} --enable-libgutenprintui2"
	else
		myconf="${myconf} --disable-libgutenprintui2"
	fi

	use foomaticdb \
		&& myconf="${myconf} --with-foomatic3" \
		|| myconf="${myconf} --without-foomatic"

	econf \
		--enable-test \
		--enable-epson \
		--with-ghostscript \
		--with-user-guide \
		--with-samples \
		--with-escputil \
		--disable-translated-cups-ppds \
		--enable-nls \
		$(use_with readline) \
		$(use_with gimp gimp2) \
		$(use_with gimp gimp2-as-gutenprint) \
		$(use_with cups) \
		$myconf || die "econf failed"

	# IJS Patch
	sed -i -e "s:<ijs\([^/]\):<ijs/ijs\1:g" src/ghost/ijsgutenprint.c || die "sed failed"

	emake || die "emake failed"
}

src_install () {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"

	exeinto /usr/share/gutenprint
	doexe test/{unprint,pcl-unprint,bjc-unprint,parse-escp2,escp2-weavetest,run-testdither,run-weavetest,testdither}

	dodoc AUTHORS ChangeLog NEWS README doc/gutenprint-users-manual.{pdf,odt}
	dohtml doc/FAQ.html
	dohtml -r doc/users_guide/html doc/developer/developer-html
	rm -fR "${D}"/usr/share/gutenprint/doc
	if ! use gtk && ! use gimp; then
		rm -f "${D}"/usr/$(get_libdir)/pkgconfig/gutenprintui2.pc
		rm -rf "${D}"/usr/include/gutenprintui2
	fi
}
