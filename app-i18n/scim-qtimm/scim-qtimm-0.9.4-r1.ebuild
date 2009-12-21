# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-qtimm/scim-qtimm-0.9.4-r1.ebuild,v 1.8 2009/12/21 15:25:32 armin76 Exp $

EAPI="2"

WANT_AUTOMAKE="1.9"
WANT_AUTOCONF="latest"

inherit qt3 eutils autotools

DESCRIPTION="Qt immodules input method framework plugin for SCIM"
HOMEPAGE="http://scim.freedesktop.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.bz2
	http://freedesktop.org/~scim/${PN}/${P}.tar.bz2
	mirror://gentoo/kde-admindir-3.5.3.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="debug"

RDEPEND=">=app-i18n/scim-1.4.2
	virtual/libintl
	|| (
		x11-libs/qt:3[immqt-bc]
		x11-libs/qt:3[immqt]
	)"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig"

src_prepare() {
	rm -rf "${S}/admin"
	ln -sf "${WORKDIR}/admin" "${S}/admin"

	epatch "${FILESDIR}/${P}-qtimm-check.patch"
	epatch "${FILESDIR}/${P}-fix-crashes.patch"
	epatch "${FILESDIR}/suse-bugzilla-116220-keyboard-layout.patch"

	if ! use debug; then
		epatch "${FILESDIR}/${P}-disable-debug.patch"
	fi

	# Fix for autoconf 2.60
	sed -i -e '/case $AUTO\(CONF\|HEADER\)_VERSION in/,+1 s/2\.5/2.[56]/g' \
		admin/cvs.sh

	export WANT_AUTOCONF WANT_AUTOMAKE
	emake -j1 -f admin/Makefile.common || die "reautotooling failed"
}

src_configure() {
	local myconf

	if use debug; then
		myconf="--enable-debug=full --enable-scim-debug"
	else
		myconf="--disable-debug"
	fi

	econf \
		--disable-static \
		--disable-dependency-tracking \
		${myconf} || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog README NEWS TODO || die
}

pkg_postinst() {
	elog
	elog "After you emerged ${PN}, use right click to switch immodules for Qt."
	elog "If you would like to use ${PN} as default instead of XIM, set"
	elog "	% export QT_IM_MODULE=scim"
	elog
}
