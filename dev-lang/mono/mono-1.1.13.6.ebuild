# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mono/mono-1.1.13.6.ebuild,v 1.1 2006/04/28 02:59:26 latexer Exp $

inherit eutils mono flag-o-matic multilib autotools

RESTRICT="confcache"

DESCRIPTION="Mono runtime and class libraries, a C# compiler/interpreter"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/sources/mono-${PV:0:3}/${P}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2 X11 )"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="nptl X"

DEPEND=">=dev-libs/glib-2.0
	sys-devel/bc
	!<dev-dotnet/pnet-0.6.12
	nptl? ( >=sys-devel/gcc-3.3.5-r1 )
	ppc? (
		>=sys-devel/gcc-3.2.3-r4
		>=sys-libs/glibc-2.3.3_pre20040420
	)"

RDEPEND="${DEPEND}
	X? ( >=dev-dotnet/libgdiplus-1.1.13 )
	dev-util/pkgconfig
	dev-libs/libxml2"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix munging of Unix paths
	epatch ${FILESDIR}/${PN}-1.1.13-pathfix.diff
	epatch ${FILESDIR}/${PN}-1.1.13-resource-manager.diff

	# Install all our .dlls under $(libdir), not $(prefix)/lib
	if [ $(get_libdir) != "lib" ] ; then
		sed -i -e 's:$(prefix)/lib:$(libdir):' \
			-e 's:$(exec_prefix)/lib:$(libdir):' \
			-e "s:'mono_libdir=\${exec_prefix}/lib':\"mono_libdir=\$libdir\":" \
			${S}/{scripts,mono/metadata,mono/os/unix}/Makefile.am \
			${S}/configure.in || die "sed failed"
		sed -i -e 's:^libdir.*:libdir=@libdir@:' \
			-e 's:${prefix}/lib/:${libdir}/:g' \
			${S}/{scripts,}/*.pc.in || die "sed failed"
	fi

	# Remove the dummy ltconfig and leave to libtoolize handling it
	rm -f ${S}/libgc/ltconfig

	eautoreconf
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

	# Force the use of the monolite mcs, to prevent us from trying to build
	# with old buggy classlibs/mcs versions. See bug #118062
	touch ${S}/mcs/build/deps/use-monolite
	econf ${myconf} || die
	emake -j1 || die "MONO compilation failure"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog NEWS README
	docinto docs
	dodoc docs/*
	docinto libgc
	dodoc libgc/ChangeLog
}

pkg_postinst() {
	ewarn "This version of mono has changed the assembly version for"
	ewarn "ICSharpCode.SharpZipLib, which may break some installed"
	ewarn "applications such as monodoc. Please re-emerge monodoc and any"
	ewarn "other packages you have which may make use of this library."
}
