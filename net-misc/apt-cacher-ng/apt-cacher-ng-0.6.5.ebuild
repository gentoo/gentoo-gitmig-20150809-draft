# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/apt-cacher-ng/apt-cacher-ng-0.6.5.ebuild,v 1.1 2011/08/16 21:00:31 jer Exp $

EAPI="4"

inherit eutils cmake-utils

DESCRIPTION="Yet another implementation of an HTTP proxy for Debian/Ubuntu software packages written in C++"
HOMEPAGE="http://www.unix-ag.uni-kl.de/~bloch/acng/"
LICENSE="as-is"
SLOT="0"
SRC_URI="mirror://debian/pool/main/a/${PN}/${PN}_${PV}.orig.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE="doc fuse"

COMMON_DEPEND="
	app-arch/bzip2
	sys-libs/zlib
"
DEPEND="
	${COMMON_DEPEND}
	dev-util/cmake
"
RDEPEND="
	${COMMON_DEPEND}
	dev-lang/perl
	fuse? ( sys-fs/fuse )
"

pkg_setup() {
	# add new user & group for daemon
	enewgroup ${PN}
	enewuser ${PN} -1 -1 -1 ${PN}
}

src_configure(){
	mycmakeargs="-DCMAKE_INSTALL_PREFIX=/usr"
	if use fuse; then
		mycmakeargs="-DHAVE_FUSE_26=yes ${mycmakeargs}"
	else
		mycmakeargs="-DHAVE_FUSE_26=no ${mycmakeargs}"
	fi

	cmake-utils_src_configure
}

src_install() {
	pushd ${CMAKE_BUILD_DIR}
	dosbin ${PN}
	if use fuse; then
		dobin acngfs
	fi
	popd

	newinitd "${FILESDIR}"/initd ${PN}
	newconfd "${FILESDIR}"/confd ${PN}

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/logrotate ${PN}

	doman doc/man/${PN}*
	if use fuse; then
		doman doc/man/acngfs*
	fi

	# Documentation
	dodoc README TODO VERSION INSTALL ChangeLog
	if use doc; then
		dodoc doc/*.pdf
		dohtml doc/html/*
		docinto examples/conf
		dodoc conf/*
	fi

	# perl daily cron script
	dosbin expire-caller.pl
	exeinto /etc/cron.daily
	newexe "${FILESDIR}"/cron.daily ${PN}

	# default configuration
	insinto /etc/${PN}
	newins conf/acng.conf ${PN}.conf
	newins conf/report.html report.html
	newins conf/deb_mirrors.gz deb_mirrors.gz
	newins conf/debvol_mirrors.gz debvol_mirrors.gz
	newins conf/ubuntu_mirrors ubuntu_mirrors
	newins conf/archlx_mirrors archlx_mirrors
	newins conf/sfnet_mirrors sfnet_mirrors
	newins conf/cygwin_mirrors cygwin_mirrors
	newins conf/security.conf security.conf
	newins conf/maint.html maint.html
	newins conf/userinfo.html userinfo.html
	newins conf/style.css style.css

	dodir /var/cache/${PN}
	dodir /var/log/${PN}
	# Some directories must exists
	keepdir /var/log/${PN}
	keepdir /var/run/${PN}
	fowners -R ${PN}:${PN} \
		/etc/${PN} \
		/var/log/${PN} \
		/var/cache/${PN} \
		/var/run/${PN}
}
