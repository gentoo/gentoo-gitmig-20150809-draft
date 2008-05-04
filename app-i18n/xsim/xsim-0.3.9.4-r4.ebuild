# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/xsim/xsim-0.3.9.4-r4.ebuild,v 1.2 2008/05/04 15:06:48 matsuu Exp $

inherit db-use eutils flag-o-matic kde-functions multilib

DESCRIPTION="A simple and fast GB and BIG5 Chinese XIM server"
HOMEPAGE="http://developer.berlios.de/projects/xsim/"
SRC_URI="mirror://berlios/xsim/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug kde"

DEPEND=">=sys-libs/db-4.1
	>=sys-apps/sed-4
	kde? ( >=kde-base/kdelibs-3 )"

src_unpack() {
	local dbver

	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-compile-fix.patch
	epatch "${FILESDIR}"/${P}-gcc-3.4.patch
	epatch "${FILESDIR}"/${P}-64bit.patch

	append-flags -DPIC -fPIC -fno-strict-aliasing

	dbver="$(db_findver sys-libs/db)"
	sed -i -e "s/\(CFLAGS.*\)-O2/\1${CFLAGS}/" \
		-e "s/libdb_cxx.so/libdb_cxx-${dbver}.so/" \
		-e "s/bdblib=\"db_cxx\"/bdblib=\"db_cxx-${dbver}\"/" configure* || die

	find . -name '*.in' | xargs sed -i \
		-e "s#\(@prefix@/\)\(dat\|plugins\)#\1$(get_libdir)/xsim/\2#" \
		-e "s#@prefix@/etc#/etc#" || die
}

src_compile() {
	local myconf

	if use kde; then
		set-qtdir 3
		set-kdedir 3
		myconf="${myconf}
			--with-kde3=${KDEDIR} \
			--with-qt3=${QTDIR} \
			--enable-status-kde3"
	fi

	myconf="${myconf} --with-bdb-includes=$(db_includedir)"

	use debug && myconf="${myconf} --enable-debug"

	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake \
		xsim_datp="${D}"/usr/$(get_libdir)/xsim/dat \
		xsim_libp="${D}"usr/$(get_libdir)/xsim/plugins \
		xsim_binp="${D}"/usr/bin \
		xsim_etcp="${D}"/etc \
		install-data install || die "install failed"

	dodoc ChangeLog KNOWNBUG README* TODO
}

pkg_postinst() {
	elog "XSIM needs write access to /usr/$(get_libdir)/xsim/dat/chardb, so if you"
	elog "not running it as root, you need to do the following:"
	elog
	elog "	cp -r /usr/$(get_libdir)/xsim/dat \${HOME}/.xsim"
	elog "	sed -i \"s#DICT_LOCAL.*#DICT_LOCAL \${HOME}/.xsim#\" > \${HOME}/.xsim/xsimrc"
	echo
}
