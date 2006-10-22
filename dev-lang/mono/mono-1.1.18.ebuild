# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mono/mono-1.1.18.ebuild,v 1.2 2006/10/22 18:42:50 jurek Exp $

inherit eutils flag-o-matic multilib autotools

DESCRIPTION="Mono runtime and class libraries, a C# compiler/interpreter"
HOMEPAGE="http://www.go-mono.com"
SRC_URI="http://www.go-mono.com/sources/mono-${PV:0:3}/${P}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2 X11 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="X nptl"

RDEPEND="!<dev-dotnet/pnet-0.6.12
		 >=dev-libs/glib-2.6
		 nptl? ( >=sys-devel/gcc-3.3.5-r1 )
		 ppc?	(
					>=sys-devel/gcc-3.2.3-r4
					>=sys-libs/glibc-2.3.3_pre20040420
				)
		 X? ( >=dev-dotnet/libgdiplus-1.1.18 )"
DEPEND="${RDEPEND}
		  sys-devel/bc
		>=dev-util/pkgconfig-0.19"

# Parallel build unfriendly
MAKEOPTS="${MAKEOPTS} -j1"

# confcache causes build errors
RESTRICT="confcache"

function get-memory-total() {
	cat /proc/meminfo | grep MemTotal | sed -r "s/[^0-9]*([[0-9]+).*/\1/"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix the install path, install into $(libdir)
	sed -i -e 's:$(prefix)/lib:$(libdir):'                                    \
		-i -e 's:$(exec_prefix)/lib:$(libdir):'                               \
		-i -e "s:'mono_libdir=\${exec_prefix}/lib':\"mono_libdir=\$libdir\":" \
		${S}/{scripts,mono/metadata}/Makefile.am ${S}/configure.in            \
	|| die "sed failed"

	sed -i -e 's:^libdir.*:libdir=@libdir@:'                                  \
		-i -e 's:${prefix}/lib/:${libdir}/:g'                                 \
		${S}/{scripts,}/*.pc.in                                               \
	|| die "sed failed"

	# Remove dummy ltconfig and let libtool handle it
	rm -f ${S}/libgc/ltconfig

	eautoreconf
}

src_compile() {
	# mono's build system is finiky, strip the flags
	strip-flags

	# Enable the 2.0 FX, use the system glib and the gc
	local myconf="--with-preview=yes --with-glib=system --with-gc=included"

	# Threading support
	if use amd64 ; then
		# force __thread on amd64 (bug #83770)
		myconf="${myconf} --with-tls=__thread"
	else
		if use nptl ; then
			myconf="${myconf} --with-tls=__thread"
		else
			myconf="${myconf} --with-tls=pthread"
		fi
	fi

	# Enable large heaps if memory is more than >=3GB
	if [[ $(get-memory-total) -ge 3145728 ]] ; then
		myconf="${myconf} --with-large-heap=yes"
	fi

	# Force the use of monolite mcs to prevent issues with classlibs (bug #118062)
	touch ${S}/mcs/build/deps/use-monolite

	econf ${myconf} || die "configure failed"
	emake || die "compile failed"
}

src_install() {
	emake DESTDIR=${D} install || die "install failed"

	dodoc AUTHORS ChangeLog NEWS README

	docinto docs
	dodoc docs/*

	docinto libgc
	dodoc libgc/ChangeLog
}
