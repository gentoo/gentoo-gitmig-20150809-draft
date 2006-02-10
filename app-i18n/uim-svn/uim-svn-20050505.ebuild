# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim-svn/uim-svn-20050505.ebuild,v 1.4 2006/02/10 20:33:54 liquidx Exp $

inherit flag-o-matic kde-functions multilib subversion

IUSE="X canna dict eb fep gtk immqt qt m17n-lib nls"

ESVN_REPO_URI="svn://svn.utyuuzin.net/uim/trunk"
ESVN_BOOTSTRAP="./autogen.sh -V"
#ESVN_PATCHES="*.diff"

DESCRIPTION="a simple, secure and flexible input method library"
HOMEPAGE="http://uim.freedesktop.org/"
SRC_URI="http://prime.sourceforge.jp/src/prime-1.0.0.1.tar.gz"

LICENSE="|| ( GPL-2 BSD )"
KEYWORDS="~x86"
SLOT="0"

RDEPEND="!app-i18n/uim
	!app-i18n/uim-fep
	!app-i18n/uim-kdehelper
	!app-i18n/uim-qt
	X? ( || ( (
	   	 	    x11-libs/libX11
				x11-libs/libXft
				x11-libs/libXt
				x11-libs/libICE
				x11-libs/libSM
				x11-libs/libXext
				x11-libs/libXrender
			  )
		   	  virtual/x11 ) )
	canna? ( app-i18n/canna )
	eb? ( dev-libs/eb )
	gtk? ( >=x11-libs/gtk+-2 )
	immqt? ( $(qt_min_version 3.3.4) )
	qt? ( $(qt_min_version 3.3.4) )
	m17n-lib? ( dev-libs/m17n-lib )"

DEPEND="${RDEPEND}
	X? ( || ( ( x11-proto/xextproto x11-proto/xproto )
	   	 	  virtual/x11 ) )
	dev-perl/XML-Parser
	nls? ( sys-devel/gettext )"


pkg_setup() {

	local co_dir="${ESVN_STORE_DIR}/uim/trunk"

	[[ ! -e ${co_dir} ]] || [[ -e ${co_dir}.freedesktop.org ]] && return

	local repo_uri repo loc

	cd ${co_dir}

	repo_uri=$(LANG=C svn info | grep "^URL" | cut -d" " -f2)

	if [[ "$repo_uri" = "http://freedesktop.org:8080/svn/uim/trunk" ]]; then
		einfo "freedesktop.org had stopped the anonymous svn access."
		einfo "switch to the mirror svn repository."

		cd ..

		repo=$(basename ${co_dir})
		loc=$(echo ${repo_uri} | sed -e "s:^.*//\([^:/]*\).*:\1:")

		mv ${repo} ${repo}.${loc}
		einfo "    move ${repo} -> ${repo}.${loc}"

	fi

}

src_compile() {

	if use qt || use immqt; then
		set-qtdir 3
	fi

	econf \
		`use_enable fep` \
		`use_enable dict` \
		`use_enable nls` \
		`use_with X x` \
		`use_with canna` \
		`use_with eb` \
		`use_with immqt qt-immodule` \
		`use_with qt` \
		`use_with gtk gtk2` \
		`use_with m17n-lib m17nlib` \
		|| die
	emake || die

	cd ${WORKDIR}/prime-1.0.0.1
	econf || die

}

src_install() {

	make DESTDIR=${D} install || die

	cd ${WORKDIR}/prime-1.0.0.1
	make DESTDIR="${D}" install-uim || die
	cd -

	rm doc/Makefile*

	dodoc AUTHORS COPYING ChangeLog* INSTALL* NEWS README*
	dodoc doc/*

	if use fep; then
		cd fep
		docinto fep
		dodoc COPYING INSTALL README*
		cd -
	fi

}

pkg_postinst() {

	einfo
	einfo "To use uim-anthy you should emerge app-i18n/anthy or app-i18n/anthy-ss."
	einfo "To use uim-skk you should emerge app-i18n/skk-jisyo."
	einfo "To use uim-prime you should emerge app-i18n/prime."
	einfo

	local chost

	has_multilib_profile && chost=${CHOST}
	use gtk && gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/${chost}/gtk.immodules

}

pkg_postrm() {

	local chost

	has_multilib_profile && chost=${CHOST}
	use gtk && gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/${chost}/gtk.immodules

}

# $Id: uim-svn-20050505.ebuild,v 1.4 2006/02/10 20:33:54 liquidx Exp $
