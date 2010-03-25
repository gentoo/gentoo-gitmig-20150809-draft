# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-connector-c++/mysql-connector-c++-1.1.0_pre814.ebuild,v 1.3 2010/03/25 18:59:39 robbat2 Exp $

EAPI="2"

inherit base cmake-utils flag-o-matic

DESCRIPTION="MySQL database connector for C++ (mimics JDBC 4.0 API)"
HOMEPAGE="http://forge.mysql.com/wiki/Connector_C++"

DEBIAN_PV=1
MY_PV="${PV/_pre/~r}"
MY_P="${PN}_${MY_PV}"
DEBIAN_URI="mirror://debian/pool/main/${PN:0:1}/${PN}"
DEBIAN_PATCH="${MY_P}-${DEBIAN_PV}.diff.gz"
DEBIAN_SRC="${MY_P}.orig.tar.gz"
SRC_URI="${DEBIAN_URI}/${DEBIAN_SRC} ${DEBIAN_URI}/${DEBIAN_PATCH}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug examples gcov static"

DEPEND=">=virtual/mysql-5.1
	dev-libs/boost
	dev-libs/openssl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/_pre/~r}"

# cmake config that works ...
CMAKE_IN_SOURCE_BUILD="1"

src_unpack() {
	unpack "${DEBIAN_SRC}"
}

src_prepare() {
	EPATCH_OPTS="-p1" epatch "${DISTDIR}"/"${DEBIAN_PATCH}"
	for i in $(<"${S}"/debian/patches/00list) ; do
		epatch "${S}"/debian/patches/${i}*
	done
	epatch "${FILESDIR}"/${PN}-1.1.0_pre814-libdir.patch
}

src_configure() {
	# native lib/wrapper needs this!
	append-flags "-fno-strict-aliasing"

	mycmakeargs=(
		"-DMYSQLCPPCONN_BUILD_EXAMPLES=OFF"
		"-DMYSQLCPPCONN_ICU_ENABLE=OFF"
		$(cmake-utils_use debug MYSQLCPPCONN_TRACE_ENABLE)
		$(cmake-utils_use gconv MYSQLCPPCONN_GCOV_ENABLE)
	)

	cmake-utils_src_configure
}

src_compile() {
	# make
	cmake-utils_src_compile mysqlcppconn

	# make static
	use static && cmake-utils_src_compile mysqlcppconn-static
}

src_install() {
	# install - ignore failure for now ...
	emake DESTDIR="${D}" install/fast

	# fast install fails on useflag [-static-libs]
	# http://bugs.mysql.com/bug.php?id=52281
	insinto /usr/include
	doins driver/mysql_{connection,driver}.h || die

	dodoc ANNOUNCE* CHANGES* README || die

	# examples
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins "${S}"/examples/* || die
	fi
}
