# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/suite3270/suite3270-3.2.20.ebuild,v 1.3 2003/12/23 01:25:05 robbat2 Exp $

IUSE="tcltk X"

S="${WORKDIR}"
DESCRIPTION="Complete 3270 access package"
SRC_URI="http://x3270.bgp.nu/download/${PN}-${PV//.}.tgz"
HOMEPAGE="http://www.geocities.com/SiliconValley/Peaks/7814/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

DEPEND="X? ( virtual/x11 )
		tcltk? ( dev-lang/tcl )
		sys-libs/ncurses
		sys-libs/readline"

suite3270_src_compile() {
	[ -z "${1}" ] && die "Need a parameter of the item to build!"
	local MY_P="${1}"
	shift
	cd ${S}/${MY_P}-3.2
	local myconf_tmp="${*}"
	local myconf=""
	for i in ${myconf_tmp}; do
		grep -q -- "${i/=*}" configure
		[ "$?" -eq "0" ] && myconf="${myconf} ${i}"
	done
	einfo "Compiling ${MY_P} with ${myconf}"
	econf ${myconf} || die
	emake || die
	cd ${S}
}

suite3270_src_install() {
	[ -z "${1}" ] && die "Need a parameter of the item to build!"
	local MY_P="${1}"
	shift
	cd ${S}/${MY_P}-3.2
	local myconf="${*}"
	make DESTDIR=${D} ${myconf} install || die
	cd ${S}
}

suite3270_makelist() {
	MY_PLIST="c3270 pr3287 s3270"
	use X && MY_PLIST="${MY_PLIST} x3270"
	use tcltk && MY_PLIST="${MY_PLIST} tcl3270"
}

src_compile() {
	suite3270_makelist
	local myconf_common
	myconf_common="--without-pr3287 --cache-file=${S}/config.cache"
	use X && myconf_common="${myconf_common} --with-x"
	if use tcltk; then
		for j in `seq 9 1`; do
		has_version "=dev-lang/tcl-8.${j}*"
		if [ "$?" -eq "0" ]; then
			einfo "Found TCL-8.${j}"
			myconf_common="${myconf_common} --with-tcl=8.${j}"
			break
		fi
		done
	fi
	for i in ${MY_PLIST}; do
		suite3270_src_compile ${i}  "${myconf_common}"
	done
}

src_install () {
	suite3270_makelist
	for i in ${MY_PLIST}; do
		suite3270_src_install ${i}
	done

	use X && rm ${D}/usr/X11R6/lib/X11/fonts/misc/fonts.dir
}

pkg_postinst() {
	if use X; then
		einfo ">>> Running mkfontdir on /usr/X11R6/lib/X11/fonts/misc"
		mkfontdir /usr/lib/X11/fonts/misc
	fi
}

pkg_postrm() {
	if use X; then
		einfo ">>> Running mkfontdir on /usr/X11R6/lib/X11/fonts/misc"
		mkfontdir /usr/lib/X11/fonts/misc
	fi
}
