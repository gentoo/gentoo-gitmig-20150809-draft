# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gutenprint/gutenprint-5.2.5-r1.ebuild,v 1.2 2010/07/09 05:58:34 jer Exp $

EAPI="2"

inherit autotools flag-o-matic eutils multilib

IUSE="cups foomaticdb gimp gtk readline ppds"

DESCRIPTION="Ghostscript and cups printer drivers"
HOMEPAGE="http://gutenprint.sourceforge.net"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SRC_URI="mirror://sourceforge/gimp-print/${P}.tar.bz2"
RESTRICT="test"

RDEPEND="cups? ( >=net-print/cups-1.1.14 )
	app-text/ghostscript-gpl
	sys-libs/readline
	gtk? ( >=x11-libs/gtk+-2.0 )
	gimp? ( >=media-gfx/gimp-2.2 >=x11-libs/gtk+-2.0 )
	dev-lang/perl
	foomaticdb? ( net-print/foomatic-db-engine )"
DEPEND="${RDEPEND}
	gtk? ( dev-util/pkgconfig )"

LICENSE="GPL-2"
SLOT="0"

src_prepare() {
	epatch \
		"${FILESDIR}/${PN}-5.2.4-CFLAGS.patch" \
		"${FILESDIR}/${P}-Makefile.patch"
	# IJS Patch
	sed -i -e "s:<ijs\([^/]\):<ijs/ijs\1:g" src/ghost/ijsgutenprint.c || die "sed failed"
	# Regen configure
	mkdir m4local
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
		${myconf} || die "econf failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README doc/gutenprint-users-manual.{pdf,odt}
	dohtml doc/FAQ.html
	dohtml -r doc/gutenprintui2/html doc/gutenprint/developer-html
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
