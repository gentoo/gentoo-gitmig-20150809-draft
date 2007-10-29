# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/ncpufreqd/ncpufreqd-2.4.ebuild,v 1.1 2007/10/29 19:06:38 nelchael Exp $

DESCRIPTION="Daemon controlling CPU speed and temperature"
HOMEPAGE="http://projects.simpledesigns.com.pl/project/ncpufreqd/"
SRC_URI="http://projects.simpledesigns.com.pl/get/${P}.tar.bz2"
LICENSE="ZLIB"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="dev-util/cmake
	virtual/logger"

src_compile() {

	mkdir "${T}/build"
	cd "${T}/build"

	cmake \
		-DCMAKE_INSTALL_PREFIX=/usr/ \
		-DCMAKE_C_FLAGS="${CFLAGS}" \
		"${S}" || die "cmake failed"

	emake || die "emake failed"

}

src_install() {

	cd "${T}/build"

	make DESTDIR="${D}" install || die "emake install failed"

	cd "${S}"

	doinitd gentoo-init.d/ncpufreqd
	dodoc AUTHORS ChangeLog README

}
