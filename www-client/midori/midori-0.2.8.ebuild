# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/midori/midori-0.2.8.ebuild,v 1.6 2010/11/04 17:14:15 fauli Exp $

EAPI=2
inherit pax-utils eutils multilib python xfconf

DESCRIPTION="A lightweight web browser based on WebKitGTK+"
HOMEPAGE="http://www.twotoasts.de/index.php?/pages/midori_summary.html"
SRC_URI="mirror://xfce/src/apps/${PN}/0.2/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc x86 ~x86-fbsd"
IUSE="doc gnome +html idn libnotify nls +unique"

RDEPEND="libnotify? ( x11-libs/libnotify )
	>=net-libs/libsoup-2.25.2
	>=net-libs/webkit-gtk-1.1.1
	>=dev-db/sqlite-3.0
	dev-libs/libxml2
	>=x11-libs/gtk+-2.10:2
	gnome? ( net-libs/libsoup-gnome )
	idn? ( net-dns/libidn )
	unique? ( dev-libs/libunique )"
DEPEND="${RDEPEND}
	|| ( dev-lang/python:2.7 dev-lang/python:2.6 )
	dev-util/intltool
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )
	html? ( dev-python/docutils )
	nls? ( sys-devel/gettext )"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	# moving docs to version-specific directory
	sed -i -e "s:\${DOCDIR}/${PN}:\${DOCDIR}/${PF}/:g" wscript || die
	sed -i -e "s:/${PN}/user/midori.html:/${PF}/user/midori.html:g" midori/midori-browser.c || die
}

src_configure() {
	strip-linguas -i po

	CCFLAGS="${CFLAGS}" LINKFLAGS="${LDFLAGS}" ./waf \
		--prefix="/usr/" \
		--libdir="/usr/$(get_libdir)" \
		--disable-docs \
		--enable-addons \
		$(use_enable doc apidocs) \
		$(use_enable html userdocs) \
		$(use_enable idn libidn) \
		$(use_enable libnotify) \
		$(use_enable nls) \
		$(use_enable unique) \
		--disable-vala \
		configure || die
}

src_compile() {
	# This is from dev-libs/boost, keep it synced
	jobs=$( echo " ${MAKEOPTS} " | \
		sed -e 's/ --jobs[= ]/ -j /g' \
		-e 's/ -j \([1-9][0-9]*\)/ -j\1/g' \
		-e 's/ -j\>/ -j1/g' | \
		( while read -d ' ' j ; do if [[ "${j#-j}" = "$j" ]]; then continue; fi;
		jobs="${j#-j}"; done; echo ${jobs} ) )
	if [[ "${jobs}" != "" ]]; then NUMJOBS="-j"${jobs}; fi;

	./waf build ${NUMJOBS} || die
}

src_install() {
	DESTDIR=${D} ./waf install || die
	dodoc AUTHORS ChangeLog INSTALL TODO || die

	pax-mark -m "${D}"/usr/bin/midori #338561
}

pkg_postinst() {
	xfconf_pkg_postinst
	ewarn "Midori tends to crash due to bugs in WebKit."
	ewarn "Report bugs at http://www.twotoasts.de/bugs"
}
