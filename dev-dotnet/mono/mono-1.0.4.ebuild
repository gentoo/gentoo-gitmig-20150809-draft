# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/mono/mono-1.0.4.ebuild,v 1.1 2004/11/04 01:53:55 latexer Exp $

inherit eutils mono flag-o-matic debug

DESCRIPTION="Mono runtime and class libraries, a C# compiler/interpreter"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/archive/${PV}/${P}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2 X11)"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="virtual/libc
	>=dev-libs/glib-2.0
	>=dev-libs/icu-2.6.1
	!dev-dotnet/pnet
	ppc? (
		>=sys-devel/gcc-3.2.3-r4
		>=sys-libs/glibc-2.3.3_pre20040420
	)"
RDEPEND="${DEPEND}
	dev-util/pkgconfig
	dev-libs/libxml2"

src_compile() {
	strip-flags

	if have_NPTL
	then
		eerror "To use mono with an NPTL enabled glibc, please emerge"
		eerror "mono-${PV}-r1."
		die "NPTL glibc not support by this release"
	fi

	econf --with-tls=pthread || die
	emake -j1 || die "MONO compilation failure"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog NEWS README
	docinto docs
	dodoc docs/*
	docinto libgc
	dodoc libgc/ChangeLog

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
