# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gutenprint/gutenprint-5.1.4.ebuild,v 1.6 2011/03/29 08:06:43 angelos Exp $

EAPI=1
inherit flag-o-matic eutils multilib

IUSE="cups foomaticdb gimp gtk readline ppds"

DESCRIPTION="Ghostscript and cups printer drivers"
HOMEPAGE="http://gutenprint.sourceforge.net"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
SRC_URI="mirror://sourceforge/gimp-print/${P}.tar.bz2"
RESTRICT="test"

RDEPEND="cups? ( >=net-print/cups-1.1.14 )
	app-text/ghostscript-gpl
	sys-libs/readline
	gtk? ( x11-libs/gtk+:2 )
	gimp? ( >=media-gfx/gimp-2.2 x11-libs/gtk+:2 )
	dev-lang/perl
	foomaticdb? ( net-print/foomatic-db-engine )"
DEPEND="${RDEPEND}
	gtk? ( dev-util/pkgconfig )"

LICENSE="GPL-2"
SLOT="0"

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

pkg_postinst() {
	if [ "${ROOT}" == "/" ] && [ -x /usr/sbin/cups-genppdupdate.5.1 ]; then
		elog "Updating installed printer ppd files"
		elog $(/usr/sbin/cups-genppdupdate.5.1)
	else
		elog "You need to update installed ppds manually using cups-genppdupdate.5.1"
	fi
}
