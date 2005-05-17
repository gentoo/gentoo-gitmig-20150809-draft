# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mono/mono-1.1.7.ebuild,v 1.5 2005/05/17 19:00:55 latexer Exp $

inherit eutils mono flag-o-matic

DESCRIPTION="Mono runtime and class libraries, a C# compiler/interpreter"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/sources/mono-${PV:0:3}/${P}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2 X11)"
SLOT="0"
KEYWORDS="~x86 -ppc ~amd64"
IUSE="nptl icu X"

DEPEND="virtual/libc
	>=dev-libs/glib-2.0
	!<dev-dotnet/pnet-0.6.12
	nptl? ( >=sys-devel/gcc-3.3.5-r1 )
	icu? ( >=dev-libs/icu-2.6.2 )
	ppc? (
		>=sys-devel/gcc-3.2.3-r4
		>=sys-libs/glibc-2.3.3_pre20040420
	)"

RDEPEND="${DEPEND}
	X? ( >=dev-dotnet/libgdiplus-1.1.4 )
	dev-util/pkgconfig
	dev-libs/libxml2"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s: -fexceptions::" ${S}/libgc/configure.host || die

	# Fix munging of Unix paths
	epatch ${FILESDIR}/${PN}-1.1.5-pathfix.diff || die

	# Fix for linking to ICU
	epatch ${FILESDIR}/${PN}-1.1.5-icu-linking.diff || die

	# Fix MONO_CFG_DIR for signing
	sed -i \
		"s:^\t\(MONO_PATH.*)\):\tMONO_CFG_DIR='${D}/etc/' \1:" \
		${S}/mcs/build/library.make || die

	libtoolize --copy --force || die "libtoolize failed"
	aclocal || die "aclocal failed"
	autoconf || die "autoconf failed"
	automake || die "automake failed"
}

src_compile() {
	strip-flags
	local myconf="--with-preview=yes"

	# Force __thread on amd64. See bug #83770
	if use amd64
	then
		myconf="${myconf} --with-tls=__thread"
	else
		if use nptl
		then
			myconf="${myconf} --with-tls=__thread"
		else
			myconf="${myconf} --with-tls=pthread"
		fi
	fi

	econf ${myconf} $(use_with icu) || die
	emake -j1 || die "MONO compilation failure"
}

src_install() {
	make DESTDIR=${D} install || die

	# Fix incorrect path to makecert EXE file
	sed -i "s:makecert.exe:MakeCert.exe:" ${D}/usr/bin/makecert || die

	# monoresgen script is broken. It should be symlink to /usr/bin/resgen
	rm ${D}/usr/bin/monoresgen || die
	dosym /usr/bin/resgen /usr/bin/monoresgen

	dodoc AUTHORS ChangeLog NEWS README
	docinto docs
	dodoc docs/*
	docinto libgc
	dodoc libgc/ChangeLog
}
