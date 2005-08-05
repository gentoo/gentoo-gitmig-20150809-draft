# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnucash/gnucash-1.8.11.ebuild,v 1.3 2005/08/05 12:13:16 seemant Exp $

inherit flag-o-matic libtool eutils

# won't configure with this
filter-flags -fomit-frame-pointer
# gnucash uses GLIB_INLINE, this will break it
filter-flags -fno-inline

DOC_VER="1.8.5"
IUSE="nls postgres ofx hbci quotes chipcard"

DESCRIPTION="A personal finance manager"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://sourceforge/${PN}/${PN}-docs-${DOC_VER}.tar.gz"
HOMEPAGE="http://www.gnucash.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~amd64"

RDEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	>=dev-util/guile-1.6
	amd64? ( >=dev-util/guile-1.6.4-r2 )
	>=dev-libs/slib-2.3.8
	>=media-libs/libpng-1.0.9
	>=media-libs/jpeg-6b
	>=sys-libs/zlib-1.1.4
	>=gnome-base/gnome-print-0.21
	media-libs/gdk-pixbuf
	>=gnome-extra/gtkhtml-0.14.0
	<gnome-extra/gal-1.99
	>=dev-libs/libxml-1.8.3
	>=dev-libs/g-wrap-1.3.4
	>=gnome-extra/guppi-0.35.5-r2
	>=dev-libs/popt-1.5
	>=app-text/scrollkeeper-0.3.1
	app-text/docbook-xsl-stylesheets
	=app-text/docbook-xml-dtd-4.1.2*
	=sys-libs/db-1*
	ofx? ( >=dev-libs/libofx-0.7.0 )
	hbci? ( net-libs/aqhbci-qt-tools )
	chipcard? ( sys-libs/libchipcard
		net-libs/aqhbci-ddvcard )
	quotes? ( dev-perl/DateManip
		dev-perl/Finance-Quote
		dev-perl/HTML-TableExtract )
	postgres? ( dev-db/postgresql )"

DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	>=dev-libs/slib-2.3.8
	>=dev-lang/swig-1.3_alpha4
	<gnome-base/libglade-2
	gnome-base/libghttp
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

MAKEOPTS="${MAKEOPTS} -j1"

pkg_setup() {
	if built_with_use virtual/x11 bitmap-fonts
	then
		einfo "bitmap-fonts support is enabled in virtual/x11, continuing..."
	else
		eerror "Please rebuild virtual/x11 with bitmap font support!"
		eerror "To do so: USE=\"bitmap-fonts\" emerge virtual/x11"
		eerror "Or, add \"bitmap-fonts\" to your USE string in"
		eerror "/etc/make.conf"
		die "Will not build gnucash without bitmap-fonts support in virtual/x11"
	fi
}

src_compile() {
	elibtoolize

	append-ldflags -L/usr/X11R6/$(get_libdir)
	econf \
		--enable-etags \
		--enable-ctags \
		--enable-compile-warnings=no \
		--disable-error-on-warning \
		`use_enable postgres sql` \
		`use_enable nls` \
		`use_enable ofx` \
		`use_enable hbci` \
		${myconf} || die "configure failed"

	emake || die "make failed"

	cd ${WORKDIR}/${P}/src/doc/design
	emake gnucash-design || die "make gnucash-design failed"

	cd ${WORKDIR}/${PN}-docs-${DOC_VER}
	econf --localstatedir=/var/lib || die "doc configure failed"
	emake || die "doc make failed"
}

src_install() {
	einstall pkgdatadir=${D}/usr/share/gnucash || die "install failed"
	dodoc ABOUT-NLS AUTHORS ChangeLog HACKING NEWS README* TODO
	dodoc docs/README*

	cd ${WORKDIR}/${PN}-docs-${DOC_VER}
	make DESTDIR=${D} \
		scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper \
		install || die "doc install failed"
	rm -rf ${D}/var/lib/scrollkeeper
}

pkg_postinst() {
	if [ -x ${ROOT}/usr/bin/scrollkeeper-update ]; then
		echo ">>> Updating Scrollkeeper"
		scrollkeeper-update -q -p ${ROOT}/var/lib/scrollkeeper
	fi

	if ! use quotes; then
		ewarn
		einfo "If you wish to enable Online Stock Quotes Retrieval,"
		einfo "Please re-emerge gnucash with USE=\"quotes\""
		ewarn
	fi
}

pkg_postrm() {
	if [ -x ${ROOT}/usr/bin/scrollkeeper-update ]; then
		echo ">>> Updating Scrollkeeper"
		scrollkeeper-update -q -p ${ROOT}/var/lib/scrollkeeper
	fi
}
