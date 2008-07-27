# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim-svn/uim-svn-1.5.ebuild,v 1.6 2008/07/27 19:49:00 carlo Exp $

EAPI=1

inherit elisp-common flag-o-matic kde-functions multilib subversion

IUSE="X anthy canna dict eb emacs fep gtk immqt libedit m17n-lib nls qt3"

DESCRIPTION="a multilingual input method library"
HOMEPAGE="http://code.google.com/p/uim/"
SRC_URI=""

LICENSE="|| ( BSD GPL-2 LGPL-2.1 )"
KEYWORDS="~x86"
SLOT="0"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.60b
	>=sys-devel/automake-1.10
	>=dev-util/intltool-0.35.2
	gnome-base/librsvg
	dev-lang/perl
	dev-lang/ruby
	app-text/asciidoc
	X? ( x11-proto/xextproto
		x11-proto/xproto )
	nls? ( virtual/libintl )"
RDEPEND="!app-i18n/uim
	X? ( x11-libs/libX11
		x11-libs/libXft
		x11-libs/libXt
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libXext
		x11-libs/libXrender )
	anthy? ( || ( app-i18n/anthy app-i18n/anthy-ss ) )
	canna? ( app-i18n/canna )
	eb? ( dev-libs/eb )
	emacs? ( virtual/emacs )
	gtk? ( >=x11-libs/gtk+-2 )
	immqt? ( x11-libs/qt:3 )
	libedit? ( dev-libs/libedit )
	qt3? ( x11-libs/qt:3 )
	m17n-lib? ( dev-libs/m17n-lib )"

src_unpack() {

	local repo_uri="http://uim.googlecode.com/svn"

	subversion_wc_info ${repo_uri}/trunk

	if [[ $? -eq 0 ]] && [ "${ESVN_WC_URL}" != "${repo_uri}/trunk" ]; then
		eerror "uim's repository is moved to Google Code."
		eerror "please remove ${ESVN_STORE_DIR}/${ESVN_PROJECT}."

		die
	fi

	subversion_fetch ${repo_uri}/trunk
	subversion_fetch ${repo_uri}/sigscheme-trunk sigscheme
	subversion_fetch ${repo_uri}/libgcroots-trunk sigscheme/libgcroots

	cd "${S}"
	sed -i -e "/^RELEASE_/d" -e "/^#RELEASE_/s:#::" Makefile.am

	cd sigscheme/libgcroots

	local i

	for ((i = 0; i < 3; i++)); do
		./autogen.sh
		cd ..
	done

}

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
		$(use_with emacs lispdir "${SITELISP}") \
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
	emake all ChangeLog || die

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
		cd "${D}/${SITELISP}"/uim-el
		elisp-comp *.el || die
		cd -
		elisp-site-file-install "${FILESDIR}"/50${PN}-gentoo.el uim-el
	fi

	# remove empty directories
	rm -rf "${D}"/usr/include/sigscheme
	rm -rf "${D}"/usr/include/libgcroots

	# remove unnecessary header
	rm -f "${D}"/usr/include/gcroots.h

}

pkg_postinst() {

	local chost

	has_multilib_profile && chost=${CHOST}
	use gtk && gtk-query-immodules-2.0 > "${ROOT}"/etc/gtk-2.0/${chost}/gtk.immodules

	if use emacs; then
		elisp-site-regen

		echo
		elog "uim is autoloaded with Emacs with a minimal set of"
		elog "features: There is no keybinding defined to call it directly,"
		elog "so please create one yourself and choose an input method."
		elog "Integration with LEIM is not done with this ebuild, please have a look"
		elog "at the documentation how to achieve this."
	fi

}

pkg_postrm() {

	local chost

	has_multilib_profile && chost=${CHOST}
	use gtk && gtk-query-immodules-2.0 > "${ROOT}"/etc/gtk-2.0/${chost}/gtk.immodules
	use emacs && elisp-site-regen

}
