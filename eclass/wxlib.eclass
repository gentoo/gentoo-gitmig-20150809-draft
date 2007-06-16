# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/wxlib.eclass,v 1.19 2007/06/16 21:59:33 dirtyepic Exp $

# Original author:  Diego Pettenò <flameeyes@gentoo.org>
# Rewritten by:     Ryan Hill <dirtyepic@gentoo.org>
#
# Currently maintained by the wxWidgets team <wxwindows@gentoo.org>

# This eclass contains build logic and helper functions for wxWidgets ebuilds
# (currently only wxGTK).

inherit eutils flag-o-matic

IUSE="debug unicode"

build_wx() {
	local build_wx_conf

	case "$1" in
		ansi)
			build_wx_conf="${build_wx_conf}
			--disable-unicode
			--disable-debug
			--disable-debug_gdb"
		;;

		ansi-debug)
			build_wx_conf="${build_wx_conf}
			--disable-unicode
			--enable-debug
			--enable-debug_gdb"
		;;

		unicode)
			build_wx_conf="${build_wx_conf}
			--enable-unicode
			--disable-debug
			--disable-debug_gdb"
		;;

		unicode-debug)
			build_wx_conf="${build_wx_conf}
			--enable-unicode
			--enable-debug
			--enable-debug_gdb"
		;;

		*)
			eerror "wxlib.class: build_wx called with invalid argument(s)."
			die "wxlib.class: build_wx called with invalid argument(s)."
		;;
	esac

	mkdir -p build_$1
	cd build_$1

	ECONF_SOURCE="${S}" \
		econf ${myconf} ${build_wx_conf} || die "Failed to configure $1."

	emake || die "Failed to make $1."

	if [[ -e contrib/src ]]; then
		cd contrib/src
		emake || die "Failed to make $1 contrib."
	fi

	cd "${S}"
}

install_wx() {
	if [[ -d build_$1 ]]; then
		cd build_$1
		emake DESTDIR="${D}" install || die "Failed to install $1."
		if [[ -e contrib/src ]]; then
			cd contrib/src
			emake DESTDIR="${D}" install || die "Failed to install $1 contrib."
		fi
	else
		eerror "wxlib.eclass: install_wx called with invalid argument(s)."
		die "wxlib.class: build_wx called with invalid argument(s)."
	fi

	cd "${S}"
}

### Stuff below this line is only here for backwards compatibility
### ie. ebuilds using the old eclasses functions
### DO NOT USE THESE FUNCTIONS

configure_build() {
	export LANG='C'

	mkdir ${S}/$1_build
	cd ${S}/$1_build
	# odbc works with ansi only:
	subconfigure $3 $(use_with odbc)
	emake -j1 CXX="$(tc-getCXX)" CC="$(tc-getCC)" || die "emake failed"
	#wxbase has no contrib:
	if [[ -e contrib/src ]]; then
		cd contrib/src
		emake -j1 CXX="$(tc-getCXX)" CC="$(tc-getCC)" || die "emake contrib failed"
	fi

	if [[ "$2" == "unicode" ]] && use unicode; then
		mkdir ${S}/$1_build_unicode
		cd ${S}/$1_build_unicode
		subconfigure $3 --enable-unicode
		emake -j1 CXX="$(tc-getCXX)" CC="$(tc-getCC)" || die "Unicode emake failed"
		if [[ -e contrib/src ]]; then
			cd contrib/src
			emake -j1 CXX="$(tc-getCXX)" CC="$(tc-getCC)" || die "Unicode emake contrib failed"
		fi
	fi
}

subconfigure() {
	ECONF_SOURCE="${S}" \
		econf \
			--disable-precomp-headers \
			--with-zlib \
			$(use_enable debug) $(use_enable debug debug_gdb) \
			$* || die "./configure failed"
}

install_build() {
	cd ${S}/$1_build
	einstall libdir="${D}/usr/$(get_libdir)" || die "Install failed"
	if [[ -e contrib ]]; then
		cd contrib/src
		einstall libdir="${D}/usr/$(get_libdir)" || die "Install contrib failed"
	fi
	if [[ -e ${S}/$1_build_unicode ]]; then
		cd ${S}/$1_build_unicode
		einstall libdir="${D}/usr/$(get_libdir)" || die "Unicode install failed"
		cd contrib/src
		einstall libdir="${D}/usr/$(get_libdir)" || die "Unicode install contrib failed"
	fi
}

wxlib_src_install() {

	cp ${D}/usr/bin/wx-config ${D}/usr/bin/wx-config-2.6 || die "Failed to cp wx-config"

	# In 2.6 all wx-config*'s go in/usr/lib/wx/config not
	# /usr/bin where 2.4 keeps theirs.
	# Only install wx-config if 2.4 is not installed:
	if [ -e "/usr/bin/wx-config" ]; then
		if [ "$(/usr/bin/wx-config --release)" = "2.4" ]; then
			rm ${D}/usr/bin/wx-config
		fi
	fi


	if use doc; then
		dodir /usr/share/doc/${PF}/{demos,samples,utils}
		dohtml ${S}/contrib/docs/html/ogl/*
		dohtml ${S}/docs/html/*
		cp -R ${S}/demos/* ${D}/usr/share/doc/${PF}/demos/
		cp -R ${S}/utils/* ${D}/usr/share/doc/${PF}/utils/
		cp -R ${S}/samples/* ${D}/usr/share/doc/${PF}/samples/
		dodoc ${S}/*.txt
	fi

}
