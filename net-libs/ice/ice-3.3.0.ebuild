# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/ice/ice-3.3.0.ebuild,v 1.1 2009/01/07 15:19:18 b33fc0d3 Exp $

inherit eutils mono multilib toolchain-funcs flag-o-matic

DESCRIPTION="The Internet Communications Engine (Ice) is a modern object-oriented middleware with support for C++, .NET, Java, Python, Ruby, and PHP"
HOMEPAGE="http://www.zeroc.com/ice.html"
SRC_URI="http://www.zeroc.com/download/Ice/3.3/Ice-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~arm"
IUSE="mono"

DEPEND=">=sys-libs/db-4.6.21
		>=dev-libs/expat-1.95.7
		>=dev-libs/openssl-0.9.7
		>=app-arch/bzip2-1.0.0
		>=dev-cpp/libmcpp-2.7
		mono? (
			>=dev-lang/mono-1.1.10
		)"
RDEPEND="${DEPEND}"

S=${WORKDIR}/Ice-${PV}

src_unpack() {
	unpack ${A}

	#epatch "${FILESDIR}/ice-3.3.0-gentoo-db-include.patch" # can be done better
	epatch "${FILESDIR}/ice-3.3.0-destdir.patch"
	epatch "${FILESDIR}/ice-3.3.0-makefile.patch"
	#epatch "${FILESDIR}/ice-3.3.0-thread-fix.patch"

	if tc-is-cross-compiler ; then
		epatch "${FILESDIR}/ice-3.3.0-cross-compile.patch"
	fi
}

src_compile() {
	if tc-is-cross-compiler ; then
		# uncomment for kernel with no epoll support
		# append-flags -DICE_NO_EPOLL
		export CXX="${CHOST}-g++"
	fi

	cd "${S}"/cpp;
	emake || die 'emake [cpp module] failed'

	if use mono; then
		cd "${S}"/cs;
		emake || die 'emake [mono module] failed'
	fi
}

src_install() {
	dodir /usr/share/"${PN}"

	cd "${S}"/cpp;
	sed -i "s/DESTDIR_PLACE_HOLDER/${D//\//\\/}\/usr/" config/Make.rules
	emake install || die 'emake install failed'

	if use mono; then
		cd "${S}"/cs/bin;
		for dll in *.dll; do
			gacutil -i ${dll} -root "${D}"/usr/$(get_libdir) \
				-gacdir /usr/$(get_libdir) -package ${P} || die 'gacutil failed'
		done
	fi

	cd "${D}"/usr
	rm -rf LICENSE ICE_LICENSE

	mv "${D}"/usr/config "${D}"/usr/share/"${PN}"
	mv "${D}"/usr/slice "${D}"/usr/share/"${PN}"
}
