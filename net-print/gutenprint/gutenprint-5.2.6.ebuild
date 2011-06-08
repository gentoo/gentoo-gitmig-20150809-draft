# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gutenprint/gutenprint-5.2.6.ebuild,v 1.7 2011/06/08 16:36:55 hwoarang Exp $

EAPI=4

inherit autotools flag-o-matic eutils multilib

IUSE="cups foomaticdb gimp gtk readline ppds"

DESCRIPTION="Ghostscript and cups printer drivers"
HOMEPAGE="http://gutenprint.sourceforge.net"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~sparc x86"
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

src_prepare() {
	epatch "${FILESDIR}/${PN}-5.2.4-CFLAGS.patch"
	# IJS Patch
	sed -i -e "s:<ijs\([^/]\):<ijs/ijs\1:g" src/ghost/ijsgutenprint.c || die "sed failed"
	# Regen configure
	mkdir m4local
	rm m4extra/libtool.m4 || die
	AT_M4DIR="m4extra" eautoreconf
}

src_configure() {
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
		--with-ghostscript \
		--disable-translated-cups-ppds \
		--enable-nls \
		$(use_with readline) \
		$(use_with gimp gimp2) \
		$(use_with gimp gimp2-as-gutenprint) \
		$(use_with cups) \
		${myconf}
}

src_install () {
	emake DESTDIR="${D}" install

	dodoc AUTHORS ChangeLog NEWS README doc/gutenprint-users-manual.{pdf,odt}
	dohtml doc/FAQ.html
	dohtml -r doc/gutenprintui2/html
	rm -fR "${D}"/usr/share/gutenprint/doc
	if ! use gtk && ! use gimp; then
		rm -f "${D}"/usr/$(get_libdir)/pkgconfig/gutenprintui2.pc
		rm -rf "${D}"/usr/include/gutenprintui2
	fi
}

pkg_postinst() {
	if [ "${ROOT}" == "/" ] && [ -x /usr/sbin/cups-genppdupdate ]; then
		elog "Updating installed printer ppd files"
		elog $(/usr/sbin/cups-genppdupdate)
	else
		elog "You need to update installed ppds manually using cups-genppdupdate"
	fi
}
