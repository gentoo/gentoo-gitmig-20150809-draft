# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/nspr/nspr-4.6.1.ebuild,v 1.1 2006/01/26 21:41:50 vanquirius Exp $

inherit eutils gnuconfig

DESCRIPTION="Netscape Portable Runtime"
HOMEPAGE="http://www.mozilla.org/projects/nspr/"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla.org/nspr/releases/v${PV}/src/${P}.tar.gz
	mirror://gentoo/nspr-4.6.1-amd64.patch.bz2"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	mkdir build inst
	epatch "${DISTDIR}"/${PN}-4.6.1-amd64.patch.bz2
	gnuconfig_update
}

src_compile() {
	cd build

	if use amd64; then
		myconf="--enable-64bit"
	else
		myconf=""
	fi

	../mozilla/nsprpub/configure \
		--build=${CBUILD:-${CHOST}} \
		--host=${CHOST} \
		--prefix=${S}/inst \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "./configure failed"
	make || die
}

src_install () {
	# Their build system is royally fucked, as usual
	cd "${S}"/build
	make install
	dodir /usr
	cp -RfL dist/* "${D}"/usr
	rm -rf "${D}"/usr/bin/lib*.so

	# there have been /usr/lib/nspr changes (like the ldpath below), but never
	# have I seen any libraries end up in this directory. lets fix that.
	# note: I tried doing this fix via the build system. It wont work.
	if [ ! -e "${D}"/usr/lib/nspr ] ; then
		mkdir -p "${D}"/usr/lib/nspr
		mv "${D}"/usr/lib/*so* "${D}"/usr/lib/nspr
		mv "${D}"/usr/lib/*\.a "${D}"/usr/lib/nspr
	fi
	# and while we're at it, lets make it actually use the arch's libdir damnit
	if [ "lib" != "$(get_libdir)" ] ; then
		mv "${D}"/usr/lib "${D}"/usr/$(get_libdir)
	fi

	# cope with libraries being in /usr/lib/nspr
	dodir /etc/env.d
	echo "LDPATH=/usr/$(get_libdir)/nspr" > "${D}"/etc/env.d/50nspr

	# create pkg-config file
	mkdir -p "${D}"/usr/$(get_libdir)/pkgconfig/
	sed -e "s:@NSPR_VER@:${PV}:g" \
		-e "s:^libdir=.*:libdir=/usr/$(get_libdir)/nspr:" \
		< "${FILESDIR}"/${PN}.pc.in \
		> "${D}"/usr/$(get_libdir)/pkgconfig/${PN}.pc \
		|| die "pkg-config file creation failed!"
}
