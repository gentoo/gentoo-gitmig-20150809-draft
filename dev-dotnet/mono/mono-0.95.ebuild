# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/mono/mono-0.95.ebuild,v 1.3 2004/06/02 20:45:30 agriffis Exp $

inherit eutils mono flag-o-matic

strip-flags

IUSE="nptl"
DESCRIPTION="Mono runtime and class libraries, a C# compiler/interpreter"
SRC_URI="http://www.go-mono.com/archive/beta2/${P}.tar.gz"
HOMEPAGE="http://www.go-mono.com/"

LICENSE="GPL-2 | LGPL-2 | X11"
SLOT="0"

KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND="virtual/glibc
	>=dev-libs/glib-2.0
	>=dev-libs/icu-2.6.1
	!dev-dotnet/pnet"

RDEPEND="${DEPEND}
	dev-util/pkgconfig
	dev-libs/libxml2"

src_compile() {
	local myconf=""
	if use nptl && have_NPTL
	then
		myconf="${myconf} --with-nptl=yes"
	else
		myconf="${myconf} --with-nptl=no"
	fi

	econf ${myconf} || die
	MAKEOPTS="${MAKEOPTS} -j1" emake || die "MONO compilation failure"
}

src_install () {
	cd ${S}
	make DESTDIR=${D} install || die
	# einstall || die

	dodoc AUTHORS ChangeLog COPYING.LIB NEWS README
	docinto docs
	dodoc docs/*

	# install mono's logo
	insopts -m0644
	insinto /usr/share/pixmaps/mono
	doins MonoIcon.png ScalableMonoIcon.svg

	# init script
	exeinto /etc/init.d ; newexe ${FILESDIR}/dotnet.init dotnet
	insinto /etc/conf.d ; newins ${FILESDIR}/dotnet.conf dotnet
}

pkg_postinst() {
	echo
	einfo "If you want to avoid typing '<runtime> program.exe'"
	einfo "you can configure your runtime in /etc/conf.d/dotnet"
	einfo "Use /etc/init.d/dotnet to register your runtime"
	echo
}
