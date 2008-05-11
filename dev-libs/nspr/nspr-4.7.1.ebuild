# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/nspr/nspr-4.7.1.ebuild,v 1.1 2008/05/11 14:29:03 armin76 Exp $

inherit eutils multilib toolchain-funcs

DESCRIPTION="Netscape Portable Runtime"
HOMEPAGE="http://www.mozilla.org/projects/nspr/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="ipv6 debug"

DEPEND=">=dev-db/sqlite-3.5"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mkdir build inst
	epatch "${FILESDIR}"/${PN}-4.6.1-config.patch
	epatch "${FILESDIR}"/${PN}-4.6.1-config-1.patch
	epatch "${FILESDIR}"/${PN}-4.6.1-lang.patch
	epatch "${FILESDIR}"/${PN}-4.7.0-prtime.patch
}

src_compile() {
	cd "${S}"/build

	echo > "${T}"/test.c
	$(tc-getCC) -c "${T}"/test.c -o "${T}"/test.o
	case $(file "${T}"/test.o) in
	    *64-bit*) myconf="${myconf} --enable-64bit";;
	    *32-bit*) ;;
	    *) die "FAIL";;
	esac

	if use ipv6; then
		myconf="${myconf} --enable-ipv6"
	fi

	myconf="${myconf} --libdir=/usr/$(get_libdir)/nspr \
		--enable-system-sqlite"

	ECONF_SOURCE="../mozilla/nsprpub" econf \
		$(use_enable debug) \
		${myconf} || die "econf failed"
	make CC="$(tc-getCC)" CXX="$(tc-getCXX)" || die
}

src_install () {
	# Their build system is royally fucked, as usual
	MINOR_VERSION=7
	cd "${S}"/build
	emake DESTDIR="${D}" install || die "emake install failed"

	cd "${D}"/usr/$(get_libdir)/nspr
	for file in *.so; do
		mv ${file} ${file}.${MINOR_VERSION}
		ln -s ${file}.${MINOR_VERSION} ${file}
	done
	# cope with libraries being in /usr/lib/nspr
	dodir /etc/env.d
	echo "LDPATH=/usr/$(get_libdir)/nspr" > "${D}/etc/env.d/08nspr"

	# install nspr-config
	dobin "${S}"/build/config/nspr-config

	# create pkg-config file
	insinto /usr/$(get_libdir)/pkgconfig/
	doins "${S}"/build/config/nspr.pc

	# Remove stupid files in /usr/bin
	rm "${D}"/usr/bin/{prerr.properties,nspr.pc}
}

pkg_preinst() {
	preserve_old_lib /usr/$(get_libdir)/nspr/lib{nspr,plc,plds}4.so.6
}

pkg_postinst() {
	preserve_old_lib_notify /usr/$(get_libdir)/nspr/lib{nspr,plc,plds}4.so.6
}
