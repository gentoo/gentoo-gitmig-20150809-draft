# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/silc-toolkit/silc-toolkit-0.9.12-r3.ebuild,v 1.15 2004/11/15 19:47:24 corsair Exp $

inherit eutils flag-o-matic

DESCRIPTION="SDK for the SILC protocol"
HOMEPAGE="http://silcnet.org/"
SRC_URI="http://silcnet.org/download/toolkit/sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc sparc x86 ~ppc64"
IUSE="debug ipv6"

DEPEND="!<=net-im/silc-client-1.0.1
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}

	# also modify Makefile.am, since the build process seems to recreate
	# Makefile.in and start over (see bug 63089)
	sed -i \
		-e "s:\$(srcdir)/tutorial \$(prefix):\$(srcdir)/tutorial \$(docdir):" \
		Makefile.am

	sed -i \
		-e "s:\$(srcdir)/tutorial \$(prefix):\$(srcdir)/tutorial \$(docdir):" \
		Makefile.in

	sed -i \
		-e "s:-g -O2:${CFLAGS}:g" \
		configure

	# Fix for amd64
	[ "${ARCH}" = "amd64" ] && epatch ${FILESDIR}/${P}-64bit_goodness.patch
}

src_compile() {
	# Fix for amd64
	[ "${ARCH}" = "amd64" ] && append-flags -fPIC

	econf \
		--datadir=/usr/share/${PN} \
		--mandir=/usr/share/man \
		--includedir=/usr/include/${PN} \
		--with-etcdir=/etc/${PN} \
		--with-helpdir=/usr/share/${PN}/help \
		--with-simdir=/usr/$(get_libdir)/${PN} \
		--with-docdir=/usr/share/doc/${PF} \
		--with-logsdir=/var/log/${PN} \
		--enable-shared \
		--enable-static \
		--without-irssi \
		--without-silcd \
		`use_enable debug` \
		`use_enable ipv6` \
		|| die "econf failed"
	emake || die "emake failed"
	emake -C lib || die "emake -C lib failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"

	rm -rf \
		${D}/usr/share/man \
		${D}/etc/${PN}/silcd.conf \
		${D}/usr/share/doc/${PF}/{tutorial,examples}

	dodir /usr/$(get_libdir)/pkgconfig
	cat >${D}/usr/$(get_libdir)/pkgconfig/silc.pc <<EOF
prefix=/usr
exec_prefix=\${prefix}
libdir=\${prefix}/$(get_libdir)
includedir=\${prefix}/include

Name: silc
Version: ${PV}
Description: SILC Library.
Libs: -L\${libdir} -lsilcclient -lsilc
Cflags: -I\${includedir}/${PN}
EOF
}
