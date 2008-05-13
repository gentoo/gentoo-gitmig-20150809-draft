# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/swl/swl-0.5.0_pre20070202.ebuild,v 1.2 2008/05/13 08:36:16 trapni Exp $

inherit flag-o-matic multilib

DESCRIPTION="SWL is a C++ cross platform library."
HOMEPAGE="http://battousai.mylair.de/swl/"
SRC_URI="http://battousai.mylair.de/dist/swl/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0.5"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug doc"

RDEPEND=">=sys-devel/gcc-3.4.3
		>=sys-libs/glibc-2.3.4"

DEPEND="${RDEPEND}
		>=sys-devel/libtool-1.5.22
		>=sys-devel/automake-1.9.6
		>=sys-devel/autoconf-2.59
		doc? ( >=app-doc/doxygen-1.3.9.1 )"

SWL_MODULES=(Core System System.Xml)

src_unpack() {
	unpack ${A} || die
	cd "${S}" || die
}

src_compile() {
	use debug && append-flags -O0 -g3
	use debug || append-flags -DNDEBUG=1

	for module in ${SWL_MODULES[@]}; do
		pushd ${module} || die

		./autogen.sh || die "autogen.sh failed"

		./configure \
			--prefix="/usr" \
			--host="${CHOST}" \
			--libdir="/usr/$(get_libdir)" \
			--without-tests \
			--without-examples \
			|| die "./configure for ABI ${ABI} failed"

		emake || die "make for ABI ${ABI} failed"

		if use doc; then
			#ewarn "TODO: generate docs {html,man} via doxygen"
			#make -C doc api-docs
			# XXX: install example/test files?
			true
		fi
		popd
	done
}

src_install() {
	for module in ${SWL_MODULES[@]}; do
		pushd ${module} || die

		make install DESTDIR="${D}" || die

		if use doc; then
			#ewarn "TODO: install man-pages and html version via doxygen"
			#dodoc -r doc/html
			true
		fi

		for doc in AUTHORS ChangeLog* NEWS README* TODO; do
			[[ -f $doc ]] || continue

			mv ${doc}{,.${module}}

			dodoc $doc.$module
		done

		popd
	done
}

# vim:ai:noet:ts=4:nowrap
