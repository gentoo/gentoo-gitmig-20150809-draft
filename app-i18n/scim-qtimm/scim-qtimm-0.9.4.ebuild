# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-qtimm/scim-qtimm-0.9.4.ebuild,v 1.6 2006/10/18 13:02:16 corsair Exp $

WANT_AUTOMAKE="1.9"
WANT_AUTOCONF="latest"

inherit kde-functions eutils autotools

DESCRIPTION="Qt immodules input method framework plugin for SCIM"
HOMEPAGE="http://scim.freedesktop.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.bz2
	http://freedesktop.org/~scim/${PN}/${P}.tar.bz2
	mirror://gentoo/kde-admindir-3.5.3.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

RDEPEND=">=app-i18n/scim-1.4.2
	virtual/libintl
	$(qt_min_version 3.3.4)"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig"

pkg_setup() {
	if ! built_with_use =x11-libs/qt-3* immqt-bc && ! built_with_use =x11-libs/qt-3* immqt; then
		die "You need to rebuild >=x11-libs/qt-3.3.4 with immqt-bc(recommended) or immqt USE flag enabled."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	rm -rf "${S}/admin"
	ln -sf "${WORKDIR}/admin" "${S}/admin"

	epatch "${FILESDIR}/${P}-qtimm-check.patch"

	# Fix for autoconf 2.60
	sed -i -e '/case $AUTO\(CONF\|HEADER\)_VERSION in/,+1 s/2\.5/2.[56]/g' \
		admin/cvs.sh

	export WANT_AUTOCONF WANT_AUTOMAKE
	emake -j1 -f admin/Makefile.common || die "reautotooling failed"
}

src_compile() {
	econf \
		$(use_enable debug scim-debug) \
		--disable-static \
		--disable-dependency-tracking || die "econf failed"
	emake || die "make failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog README NEWS TODO
}

pkg_postinst() {
	einfo
	einfo "After you emerged ${PN}, use right click to switch immodules for Qt."
	einfo "If you would like to use ${PN} as default instead of XIM, set"
	einfo "	% export QT_IM_MODULE=scim"
	einfo
}
