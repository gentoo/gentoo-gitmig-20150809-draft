# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/suite3270/suite3270-3.3.4_p6.ebuild,v 1.5 2007/08/25 14:34:07 vapier Exp $

IUSE="tcl X cjk ssl debug"

S="${WORKDIR}"
DESCRIPTION="Complete 3270 access package"
MY_PV_tmp="${PV//.}"
MY_PV="${MY_PV_tmp//_}"
SRC_URI="http://x3270.bgp.nu/download/${PN}-${MY_PV}.tgz"
HOMEPAGE="http://www.geocities.com/SiliconValley/Peaks/7814/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc s390 ~sparc x86"

RDEPEND="X? ( x11-libs/libXaw )
		tcl? ( dev-lang/tcl )
		sys-libs/ncurses
		sys-libs/readline
		ssl? ( dev-libs/openssl )
		cjk? ( dev-libs/icu )"
DEPEND="${RDEPEND}
		X? ( app-text/rman
			x11-misc/imake
			x11-proto/xproto )
		sys-apps/sed
		sys-apps/grep"

# for each subitem
SUB_PV="3.3"

suite3270_src_compile() {
	[ -z "${1}" ] && die "Need a parameter of the item to build!"
	local MY_PN="${1}"
	shift
	cd ${S}/${MY_PN}-${SUB_PV}
	local myconf_tmp="${*}"
	local myconf=""
	for i in ${myconf_tmp}; do
		tmpexpr=`echo ${i} | sed -re 's:--([[:alnum:]]+)-([-[:alnum:]]+)(=.*)?:\2:g'`
		use debug && einfo "Testing ${MY_PN}: ${i} => ${tmpexpr}"
		grep -q -- ${tmpexpr} configure
		[ "$?" -eq "0" ] && myconf="${myconf} ${i}"
	done
	echo
	einfo "Compiling ${MY_PN} with ${myconf}"
	econf ${myconf} || die
	emake || die
	cd ${S}
}

suite3270_src_install() {
	[ -z "${1}" ] && die "Need a parameter of the item to build!"
	local MY_PN="${1}"
	shift
	cd ${S}/${MY_PN}-${SUB_PV}
	local myconf="${*}"
	make DESTDIR=${D} ${myconf} install install.man || die
	docinto ${MY_PN}
	dohtml html/*
}

suite3270_makelist() {
	MY_PLIST="c3270 pr3287 s3270"
	use tcl && MY_PLIST="${MY_PLIST} tcl3270"
	use X && MY_PLIST="${MY_PLIST} x3270"
}

src_compile() {
	suite3270_makelist
	local myconf_common
	myconf_common="--without-pr3287 --cache-file=${S}/config.cache"
	#use X && myconf_common="${myconf_common} --with-x"
	myconf_common="${myconf_common} `use_with X x`"
	#myconf_common="${myconf_common} `use_with ssl`"
	myconf_common="${myconf_common} `use_enable ssl`"
	if use cjk; then
		myconf_common="${myconf_common} --with-icu=/usr --enable-dbcs"
	else
		myconf_common="${myconf_common} --without-icu --disable-dbcs"
	fi
	if use tcl; then
		local tclinc
		for j in `seq 1 5`; do
			if has_version "=dev-lang/tcl-8.${j}*"; then
				einfo "Found TCL-8.${j}"
				tclinc="--with-tcl=8.${j}"
			fi
		done
		if [ -z "${tclinc}" ]; then
			die "USE=tcl, but cannot find dev-lang/tcl!"
		fi
		myconf_common="${myconf_common} ${tclinc}"
	else
		myconf_common="${myconf_common} --without-tcl"
	fi
	for i in ${MY_PLIST}; do
		suite3270_src_compile ${i}	"${myconf_common}"
	done
}

src_install () {
	suite3270_makelist
	for i in ${MY_PLIST}; do
		suite3270_src_install ${i}
	done
	prepalldocs

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
