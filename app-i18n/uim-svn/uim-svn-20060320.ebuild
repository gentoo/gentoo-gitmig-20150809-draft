# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim-svn/uim-svn-20060320.ebuild,v 1.10 2006/10/30 12:37:54 hattya Exp $

inherit elisp-common flag-o-matic kde-functions multilib subversion

IUSE="X anthy canna dict eb emacs fep gtk immqt libedit m17n-lib nls qt3"

ESVN_REPO_URI="http://anonsvn.freedesktop.org/svn/uim/trunk"
ESVN_BOOTSTRAP="./autogen.sh"
#ESVN_PATCHES="*.diff"

DESCRIPTION="a multilingual input method library"
HOMEPAGE="http://uim.freedesktop.org/"
SRC_URI=""

LICENSE="BSD GPL-2 LGPL-2.1"
KEYWORDS="~x86"
SLOT="0"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.31
	gnome-base/librsvg
	X? ( || ( (
				x11-proto/xextproto
				x11-proto/xproto
			  )
	   	 	  virtual/x11 ) )
	nls? ( virtual/libintl )"
RDEPEND="!app-i18n/uim
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
	anthy? ( || ( app-i18n/anthy app-i18n/anthy-ss ) )
	canna? ( app-i18n/canna )
	eb? ( dev-libs/eb )
	emacs? ( virtual/emacs )
	gtk? ( >=x11-libs/gtk+-2 )
	immqt? ( $(qt_min_version 3.3.4) )
	libedit? ( dev-libs/libedit )
	qt3? ( $(qt_min_version 3.3.4) )
	m17n-lib? ( dev-libs/m17n-lib )"

src_compile() {

	local myconf="--enable-maintainer-mode"

	if use dict && (use anthy || use canna); then
		myconf="${myconf} --enable-dict"

	else
		ewarn "dict use flag should use with anthy or canna use flag. disabled."
		myconf="${myconf} --disable-dict"

	fi

	if use qt3 || use immqt; then
		set-qtdir 3
	fi

	econf \
		$(use_enable emacs) \
		$(use_enable fep) \
		$(use_enable nls) \
		$(use_with X x) \
		$(use_with anthy) \
		$(use_with canna) \
		$(use_with eb) \
		$(use_with immqt qt-immodule) \
		$(use_with libedit) \
		$(use_with qt3 qt) \
		$(use_with gtk gtk2) \
		$(use_with m17n-lib m17nlib) \
		${myconf} \
		|| die
	emake || die

}

src_install() {

	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog* NEWS README*

	rm doc/Makefile*
	docinto doc
	dodoc doc/*

	local u

	for u in emacs fep; do
		if use ${u}; then
			cd ${u}
			docinto ${u}
			dodoc README*
			cd -
		fi
	done

	if use emacs; then
		local im

		if has_version app-i18n/anthy || has_version app-i18n/anthy-ss; then
			im="anthy"

		elif has_version app-i18n/prime; then
			im="prime"

		else
			im="skk"

		fi

		elisp-site-file-install "${FILESDIR}"/50uim-gentoo.el
		dosed "s:@IM@:${im}:" ${SITELISP}/50uim-gentoo.el
	fi

}

pkg_postinst() {

	local chost

	has_multilib_profile && chost=${CHOST}
	use gtk && gtk-query-immodules-2.0 > "${ROOT}"/etc/gtk-2.0/${chost}/gtk.immodules
	use emacs && elisp-site-regen

}

pkg_postrm() {

	local chost

	has_multilib_profile && chost=${CHOST}
	use gtk && gtk-query-immodules-2.0 > "${ROOT}"/etc/gtk-2.0/${chost}/gtk.immodules
	has_version virtual/emacs && elisp-site-regen

}
