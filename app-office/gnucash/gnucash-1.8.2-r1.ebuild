# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnucash/gnucash-1.8.2-r1.ebuild,v 1.1 2003/04/28 02:15:05 liquidx Exp $

inherit flag-o-matic libtool

# won't configure with this
filter-flags -fomit-frame-pointer

DESCRIPTION="A personal finance manager"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnucash.org/"

KEYWORDS="~x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE="nls postgres ofx hbci debug"

RDEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	>=dev-util/guile-1.6
	>=dev-libs/slib-2.3.8
	>=media-libs/libpng-1.0.9
	>=media-libs/jpeg-6b
	>=sys-libs/zlib-1.1.4
	>=media-libs/xpm-3.4
	>=gnome-base/gnome-print-0.21
	media-libs/gdk-pixbuf
	>=gnome-extra/gtkhtml-0.14.0
	>=gnome-extra/gal-0.13-r1
	>=dev-libs/libxml-1.8.3		
	>=dev-libs/g-wrap-1.3.3
	>=gnome-extra/guppi-0.35.5-r2

	=sys-libs/db-1*
	hbci? ( >=net-libs/openhbci-0.9.6 )
	ofx? ( >=dev-libs/libofx-0.6.4 )
	postgres? ( dev-db/postgresql )"
	
DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	>=dev-libs/slib-2.3.8
	>=dev-lang/swig-1.3_alpha4
	<gnome-base/libglade-2
	gnome-base/libghttp
	nls? ( sys-devel/gettext )"

MAKEOPTS="${MAKEOPTS} -j1"

src_compile() {
	elibtoolize
	local myconf=""

	# allow warnings to go unheeded
	myconf="--enable-compile-warnings=no --disable-error-on-warning"

	use postgres && myconf="${myconf} --enable-sql"
	# note: --disable-ofx doesn't work
	use ofx && myconf="${myconf} --enable-ofx"

	econf \
		`use_enable hbci` \
		`use_enable nls` \
		`use_enable debug` \
		${myconf} || die
		
	emake || die
}

src_install() {
	einstall pkgdatadir=${D}/usr/share/gnucash || die "install failed"
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog HACKING NEWS README* TODO
}
