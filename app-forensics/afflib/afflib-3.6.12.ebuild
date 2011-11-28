# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/afflib/afflib-3.6.12.ebuild,v 1.8 2011/11/28 10:25:08 radhermit Exp $

EAPI="4"
PYTHON_DEPEND="python? 2"

inherit autotools-utils python

DESCRIPTION="Library that implements the AFF image standard"
HOMEPAGE="http://www.afflib.org/"
SRC_URI="http://www.afflib.org/downloads/${P}.tar.gz"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc ~x86"
IUSE="fuse ncurses python qemu readline s3 static-libs threads"

RDEPEND="dev-libs/expat
	dev-libs/openssl
	sys-libs/zlib
	fuse? ( sys-fs/fuse )
	ncurses? ( sys-libs/ncurses )
	readline? ( sys-libs/readline )
	s3? ( net-misc/curl )"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-python-module.patch
	"${FILESDIR}"/${P}-pyaff-header.patch
)

pkg_setup() {
	if use python ; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	sed -i -e "/FLAGS/s: -g::" configure.ac || die
	sed -i -e "/-static/d" tools/Makefile.am || die

	autotools-utils_src_prepare
	eautoreconf
}

src_configure() {
	# Hacks for automagic dependencies
	use ncurses || export ac_cv_lib_ncurses_initscr=no
	use readline || export ac_cv_lib_readline_readline=no

	local myeconfargs=(
		$(use_enable fuse)
		$(use_enable python)
		$(use_enable qemu)
		$(use_enable s3)
		$(use_enable threads threading)
	)
	autotools-utils_src_configure
}
