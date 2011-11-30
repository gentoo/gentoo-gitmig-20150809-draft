# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pypy/pypy-1.7.ebuild,v 1.2 2011/11/30 11:42:55 djc Exp $

EAPI="3"

inherit eutils toolchain-funcs check-reqs python versionator

DESCRIPTION="PyPy is a fast, compliant alternative implementation of the Python language"
HOMEPAGE="http://pypy.org/"
SRC_URI="https://bitbucket.org/pypy/pypy/get/release-${PV}.tar.bz2"
SLOTVER=$(get_version_component_range 1-2 ${PV})

LICENSE="MIT"
SLOT="${SLOTVER}"
PYTHON_ABI="2.7-pypy-${SLOTVER}"
KEYWORDS="~amd64"
IUSE="doc examples +jit sandbox stackless test bzip2 ncurses xml ssl"

RDEPEND=">=sys-libs/zlib-1.1.3
		virtual/libffi
		virtual/libintl
		bzip2? ( app-arch/bzip2 )
		ncurses? ( sys-libs/ncurses )
		xml? ( dev-libs/expat )
		ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}"
PDEPEND="app-admin/python-updater"

S="${WORKDIR}/${PN}-pypy-release-${PV}"
DOC="README LICENSE"

CHECKREQS_MEMORY="1250M"
use amd64 && CHECKREQS_MEMORY="2500M"

src_prepare() {
	epatch "${FILESDIR}/${PV}-patches.patch"
	epatch "${FILESDIR}/${PV}-scripts-location.patch"
}

src_compile() {

	if use jit; then
		conf="-Ojit"
	else
		conf="-O2"
	fi
	if use sandbox; then
		conf+=" --sandbox"
	fi
	if use stackless; then
		conf+=" --stackless"
	fi

	conf+=" ./pypy/translator/goal/targetpypystandalone.py"
	# Avoid linking against libraries disabled by use flags
	optional_use=("bzip2" "ncurses" "xml" "ssl")
	optional_mod=("bz2" "_minimal_curses" "pyexpat" "_ssl")
	for ((i = 0; i < ${#optional_use[*]}; i++)); do
		if use ${optional_use[$i]};	then
			conf+=" --withmod-${optional_mod[$i]}"
		else
			conf+=" --withoutmod-${optional_mod[$i]}"
		fi
	done

	translate_cmd="$(PYTHON -2) ./pypy/translator/goal/translate.py $conf"
	echo ${_BOLD}"${translate_cmd}"${_NORMAL}
	${translate_cmd} || die "compile error"
}

src_install() {
	INSPATH="/usr/$(get_libdir)/pypy${SLOT}"
	insinto ${INSPATH}
	doins -r include lib_pypy lib-python pypy-c || die "failed"
	fperms a+x ${INSPATH}/pypy-c || die "failed"
	dosym ../$(get_libdir)/pypy${SLOT}/pypy-c /usr/bin/pypy-c${SLOT}
}

src_test() {
	$(PYTHON -2) ./pypy/test_all.py --pypy=./pypy-c lib-python
}
