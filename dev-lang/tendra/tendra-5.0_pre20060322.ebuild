# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tendra/tendra-5.0_pre20060322.ebuild,v 1.1 2006/09/06 15:22:54 truedfx Exp $

inherit eutils toolchain-funcs bsdmk

MY_PV=${PV#*_pre}

DESCRIPTION="A C/C++ compiler initially developed by DERA"
HOMEPAGE="http://www.ten15.org/"
SRC_URI="ftp://ftp.ten15.org/pub/snapshot/tendra-${MY_PV}.tar.bz2
	mirror://gentoo/${P}-misc.patch.bz2
	http://dev.gentoo.org/~truedfx/${P}-misc.patch.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
# Both tendra and tinycc install /usr/bin/tcc
RDEPEND="!dev-lang/tcc"

S=${WORKDIR}/${PN}

pkg_setup() {
	export MAKE=$(get_bmake)
}

src_unpack() {
	unpack tendra-${MY_PV}.tar.bz2
	cd "${S}"
	epatch "${DISTDIR}"/${P}-misc.patch.bz2
}

src_compile() {
	rm -f config.mk

	export MAKE

	# Note: despite the below code block, only x86 linux
	# is supported or even known to work for now
	case $(tc-arch) in
	*-macos) emake darwin  || die ;;
	*-fbsd)  emake freebsd || die ;;
	*-nbsd)  emake netbsd  || die ;;
	*-obsd)  emake openbsd || die ;;
	*)       emake linux   || die ;;
	esac

	for program in CC AS LD
	do
		set -- $(tc-get${program})
		local path=$(type -P $1)
		shift
		export BIN_${program}="${path} $*"
	done

	PREFIX=/usr emake || die "compilation failed"
}

src_install() {
	export MAKE

	PREFIX=${D}usr emake install || die "installation failed"
}
