# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim-svn/uim-svn-20040709.ebuild,v 1.2 2004/07/17 10:16:30 dholm Exp $

inherit subversion flag-o-matic

IUSE="X debug gtk nls m17n-lib kde"

ESVN_REPO_URI="http://freedesktop.org:8080/svn/uim/trunk"
ESVN_BOOTSTRAP="autogen.sh"
ESVN_PATCHES="*.diff"

DESCRIPTION="a simple, secure and flexible input method library"
HOMEPAGE="http://uim.freedesktop.org/"
SRC_URI=""

LICENSE="GPL-2 | BSD"
KEYWORDS="~x86 ~ppc"
SLOT="0"

DEPEND="${RDEPEND}
	dev-perl/XML-Parser
	nls? ( sys-devel/gettext )"
RDEPEND="X? ( virtual/x11 )
	gtk? ( >=x11-libs/gtk+-2 )
	kde? (
		=x11-libs/qt-3*
		=kde-base/kdebase-3.2*
		=kde-base/kdelibs-3.2*
	)
	m17n-lib? ( dev-libs/m17n-lib )
	!app-i18n/uim"

src_compile() {

	use X || sed -i -e '/^SUBDIRS/s/xim//' Makefile.in || die
	use debug && append-flags -g

	econf \
		`use_enable nls` \
		`use_with X x` \
		`use_with gtk gtk2` \
		`use_with m17n-lib m17nlib` \
		|| die
	emake || die

	if use X && use kde; then
		local abs_top_dir=`pwd`

		! use gtk && sed -ie "52s:NULL:\"uim-helper-candwin-qt\":" xim/canddisp.cpp

		cd qt/qtkde-helper

		make -f Makefile.cvs
		econf \
			`use_enable nls` \
			`use_enable debug '' full` \
			--with-extra-includes=${abs_top_dir} \
			|| die
		emake || die
	fi

}

src_install() {

	make DESTDIR=${D} install || die

	if use X && use kde; then
		cd qt/qtkde-helper
		make DESTDIR=${D} install || die
		cd -
	fi

	dodoc [A-Z][A-Z]* ChangeLog* doc/[A-Z0-9][A-Z0-9]*

}

pkg_postinst() {

	einfo
	einfo "To use uim-anthy you should emerge app-i18n/anthy or app-i18n/anthy-ss."
	einfo "To use uim-skk you should emerge app-i18n/skk-jisyo."
	einfo "To use uim-prime you should emerge app-i18n/prime."
	einfo

	use gtk && gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules

}

pkg_postrm() {

	use gtk && gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules

}
