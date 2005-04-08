# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mono/mono-1.1.4.ebuild,v 1.3 2005/04/08 00:08:09 latexer Exp $

inherit eutils mono flag-o-matic

DESCRIPTION="Mono runtime and class libraries, a C# compiler/interpreter"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/archive/${PV}/${P}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2 X11)"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="nptl icu"

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
	>=dev-dotnet/libgdiplus-${PV}
	dev-util/pkgconfig
	dev-libs/libxml2"

PDEPEND=">=dev-dotnet/libgdiplus-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s: -fexceptions::" ${S}/libgc/configure.host
}

src_compile() {
	strip-flags
	local myconf="--with-sigaltstack=yes --with-preview=yes"

	if use nptl && have_NPTL
	then
		myconf="${myconf} --with-tls=__thread"
	else
		myconf="${myconf} --with-tls=pthread"
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

	# prj2make sources missing from mono-1.1.4 tarball, so we remove the wrapper
	# script
	rm ${D}/usr/bin/prj2make ${D}/usr/share/man/man1/prj2make.1

	dodoc AUTHORS ChangeLog NEWS README
	docinto docs
	dodoc docs/*
	docinto libgc
	dodoc libgc/ChangeLog
}
