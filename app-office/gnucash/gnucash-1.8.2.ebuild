# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnucash/gnucash-1.8.2.ebuild,v 1.2 2003/06/10 13:22:35 liquidx Exp $

# FIXME - ebuild needs a good look at

inherit flag-o-matic libtool

DESCRIPTION="A personal finance manager"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnucash.org/"

KEYWORDS="~x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE="nls postgres"

RDEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	 >=dev-libs/libxml-1.8.3
	 >=gnome-extra/gtkhtml-0.14.0-r1
	 <gnome-extra/gal-1.99
	 >=gnome-extra/guppi-0.35.5-r2
	 >=gnome-base/gnome-print-0.21
	 postgres? ( dev-db/postgresql )"

DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	>=dev-libs/slib-2.3.8
	>=dev-lang/swig-1.3_alpha4
	>=dev-libs/g-wrap-1.3.4
	<gnome-base/libglade-2
	media-libs/gdk-pixbuf
	<dev-util/guile-1.4.1
	gnome-base/libghttp
	nls? ( sys-devel/gettext )"

# these flags to GCC interfere with G_INLINE_FUNC usage in this package
filter-flags "-fno-inline -finline-functions"

src_compile() {
	elibtoolize
	local myconf=""

	use nls \
		&& myconf="--enable-nls" \
		|| myconf="--disable-nls"
	use postgres \
		&& myconf="${myconf} --enable-sql" \
		|| myconf="${myconf} --disable-sql"

	econf ${myconf}

	MAKEOPTS="${MAKEOPTS} -j1" emake || die # Doesn't work with make -j 4 (hallski)
}

src_install() {
        einstall \
                pkgdatadir=${D}/usr/share/gnucash

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog HACKING NEWS README* TODO
}
