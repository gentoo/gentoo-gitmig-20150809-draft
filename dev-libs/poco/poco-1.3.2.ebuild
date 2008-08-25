# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/poco/poco-1.3.2.ebuild,v 1.4 2008/08/25 17:07:33 maekke Exp $

EAPI="1"

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="C++ class libraries that simplify and accelerate the development of network-centric, portable applications."
HOMEPAGE="http://pocoproject.org/"
SRC_URI="mirror://sourceforge/poco/${P}-data.tar.bz2
	doc? ( mirror://sourceforge/poco/${P}-doc.tar.gz )"
LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples iodbc odbc sqlite ssl"

DEPEND="dev-libs/libpcre
	dev-libs/expat
	odbc? ( iodbc? ( dev-db/libiodbc )
		!iodbc? ( dev-db/unixODBC ) )
	ssl? ( dev-libs/openssl )
	sqlite? ( dev-db/sqlite:3 )"
RDEPEND="${DEPEND}"

# Upstream has three editions: "economic", "with NetSSL" and "with NetSSL and Data"
# We take the last one and provide useflags for ssl, odbc, sqlite
S="${WORKDIR}/${P}-data"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch \
		"${FILESDIR}/${PV}-missing_includes.patch" \
		"${FILESDIR}/${PV}-gentoo.patch"

}

src_compile() {
	local targets="all"
	local odbc="unixodbc"

	if use ssl; then
		targets="${targets} NetSSL_OpenSSL-libexec"
		echo NetSSL_OpenSSL >> components
	fi
	if use odbc; then
		targets="${targets} Data/ODBC-libexec"
		echo Data/ODBC >> components
		if use iodbc; then
			append-flags "-I/usr/include/iodbc"
			odbc="iodbc"
		fi
	fi
	if use sqlite; then
		targets="${targets} Data/SQLite-libexec"
		echo Data/SQLite >> components
	fi

	if has test ${FEATURES}; then
		targets="${targets} cppunit tests"
		echo CppUnit >> components
		use ssl && targets="${targets} NetSSL_OpenSSL-tests"
		use odbc && targets="${targets} Data/ODBC-tests"
		use sqlite && targets="${targets} Data/SQLite-tests"
	fi

	# not autoconf
	./configure \
		--no-samples \
		--prefix=/usr \
		|| die "configure failed"

	sed -i \
		-e "s|CC      = .*|CC      = $(tc-getCC)|" \
		-e "s|CXX     = .*|CXX     = $(tc-getCXX)|" \
		-e "s|RANLIB  = .*|RANLIB  = $(tc-getRANLIB)|" \
		-e "s|LIB     = ar|LIB     = $(tc-getAR)|" \
		-e "s|STRIP   = .*|STRIP   = /bin/true|" \
		-e "s|CFLAGS          = |CFLAGS          = ${CFLAGS}|" \
		-e "s|CXXFLAGS        = |CXXFLAGS        = ${CXXFLAGS} |" \
		-e "s|LINKFLAGS       = |LINKFLAGS       = ${LDFLAG} |" \
		-e 's|-O2||g' \
		build/config/Linux build/config/FreeBSD || die "sed failed"

	emake POCO_PREFIX=/usr GENTOO_ODBC="${odbc}" LIBDIR="$(get_libdir)" ${targets} || die "emake failed"
}

src_install() {
	emake POCO_PREFIX=/usr LIBDIR="$(get_libdir)" DESTDIR="${D}" install || die "emake install failed"

	dodoc CHANGELOG CONTRIBUTORS NEWS README

	use doc && dohtml -r "${WORKDIR}/${P}-doc"/*

	if use examples ; then
		for d in Net XML Data Util NetSSL_OpenSSL Foundation ; do
			insinto /usr/share/doc/${PF}/examples/${d}
			doins -r ${d}/samples
		done
		find "${D}/usr/share/doc/${PF}/examples" \
			-iname "*.sln" -or -iname "*.vcproj" -or \
			-iname "*.vmsbuild" -or -iname "*.properties" \
			| xargs rm
	fi
}
