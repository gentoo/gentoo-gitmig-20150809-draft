# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/swl/swl-0.4.0_rc5-r2.ebuild,v 1.1 2005/08/03 01:30:54 trapni Exp $

inherit flag-o-matic multilib

DESCRIPTION="SWL is a C++ cross platform library."
HOMEPAGE="http://swl.trapni-akane.org/"
SRC_URI="http://upstream.trapni-akane.org/swl/${P/_/-}.tar.gz
		 http://upstream.trapni-akane.org/swl/patches/0.4-rc5-post-20050803.diff"
LICENSE="LGPL-2.1"
SLOT="0.4"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="acl crypt debug doc ipv6"

DEPEND="acl? ( >=sys-apps/acl-2.2.27 )
		>=sys-libs/glibc-2.3.4
		>=sys-devel/gcc-3.4.3
		crypt? ( >=dev-libs/libgcrypt-1.2.0 )
		doc? ( >=app-doc/doxygen-1.3.9.1 )"

S="${WORKDIR}/${P/_/-}"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	epatch "${DISTDIR}/0.4-rc5-post-20050729.diff" || die
}

src_compile() {
	use debug && append-flags -g3
	use debug || append-flags -DNDEBUG=1

	./configure \
		--prefix="/usr" \
		--host="${CHOST}" \
		--libdir="/usr/$(get_libdir)" \
		`use_enable acl` \
		`use_enable crypt crypto` \
		`use_enable ipv6` \
		--without-tests \
		--without-examples \
		|| die "./configure for ABI ${ABI} failed"

	emake || die "make for ABI ${ABI} failed"

	if use doc; then
		ewarn "TODO: generate docs {html,man} via doxygen"
		#make -C doc api-docs
		# XXX: install example/test files?
	fi
}

src_install() {
	make install DESTDIR="${D}" || die

	if use doc; then
		ewarn "TODO: install man-pages and html version via doxygen"
		#dodoc -r doc/html
	fi

	dodoc AUTHORS ChangeLog* NEWS README* TODO
}

# vim:ai:noet:ts=4:nowrap
