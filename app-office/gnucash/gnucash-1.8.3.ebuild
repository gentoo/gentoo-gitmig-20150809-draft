# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnucash/gnucash-1.8.3.ebuild,v 1.1 2003/05/14 09:17:58 liquidx Exp $

inherit flag-o-matic libtool

# won't configure with this
filter-flags -fomit-frame-pointer

DOC_VER="1.8.1"
IUSE="nls postgres ofx hbci doc"

DESCRIPTION="A personal finance manager"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	doc? ( mirror://sourceforge/${PN}/${PN}-docs-${DOC_VER}.tar.gz )"
HOMEPAGE="http://www.gnucash.org/"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

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
	=gnome-extra/gal-0*
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
	nls? ( sys-devel/gettext )
	doc? ( >=app-text/scrollkeeper-0.3.1
		app-text/docbook-xsl-stylesheets )"

MAKEOPTS="${MAKEOPTS} -j1"

src_compile() {
	elibtoolize
	local myconf=""

	# allow warnings to go unheeded
	myconf="--enable-compile-warnings=no --disable-error-on-warning"

	use postgres && myconf="${myconf} --enable-sql"

	econf \
		`use_enable nls` \
		`use_enable ofx` \
		`use_enable hbci` \
		${myconf} || die "configure failed"
		
	emake || die "make failed"
	
	if [ -n "`use doc`" ]; then
		cd ${WORKDIR}/${PN}-docs-${DOC_VER}
		econf --localstatedir=/var/lib || die "doc configure failed"
		emake || die "doc make failed"
	fi		
}

src_install() {
	einstall pkgdatadir=${D}/usr/share/gnucash || die "install failed"
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog HACKING NEWS README* TODO
	dodoc docs/README*
	
	if [ -n "`use doc`" ]; then
		cd ${WORKDIR}/${PN}-docs-${DOC_VER}
		make DESTDIR=${D} \
			scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper \
			install || die "doc install failed"
		rm -rf ${D}/var/lib/scrollkeeper
	fi
}	

pkg_postinst() {
	if [ -x ${ROOT}/usr/bin/scrollkeeper-update ]; then
		echo ">>> Updating Scrollkeeper"
		scrollkeeper-update -q -p ${ROOT}/var/lib/scrollkeeper
	fi
}

pkg_postrm() {
	if [ -x ${ROOT}/usr/bin/scrollkeeper-update ]; then
		echo ">>> Updating Scrollkeeper"
		scrollkeeper-update -q -p ${ROOT}/var/lib/scrollkeeper
	fi
}
