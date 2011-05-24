# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/apt-cacher-ng/apt-cacher-ng-0.6.2.ebuild,v 1.1 2011/05/24 21:48:33 jer Exp $

EAPI="3"

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
	dosbin ${PN} || die
	if use fuse
		then dobin acngfs || die
	fi
	popd

	newinitd "${FILESDIR}"/initd ${PN} || die "Can't add new init.d ${PN}"
	newconfd "${FILESDIR}"/confd ${PN} || die "Can't add new conf.d ${PN}"

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/logrotate ${PN} || die "Can't install new file ${PN} into '/etc/logrotate.d'"

	doman doc/man/${PN}* || die "Can't install mans"
	if use fuse; then doman doc/man/acngfs* || die "Can't install man pages for fusefs"; fi

	# Documentation
	dodoc README TODO VERSION INSTALL ChangeLog || die "Can't install common docs"
	if use doc; then
		dodoc doc/*.pdf || die "Can't install docs"
		dohtml doc/html/* || die "Can't install html docs"
		docinto examples/conf
		dodoc conf/* || die "Can't install config examples"
	fi

	# perl daily cron script
	dosbin expire-caller.pl || die
	exeinto /etc/cron.daily
	newexe "${FILESDIR}"/cron.daily ${PN} || die

	# default configuration
	insinto /etc/${PN}
	newins conf/acng.conf ${PN}.conf || die
	newins conf/report.html report.html || die
	newins conf/deb_mirrors.gz deb_mirrors.gz || die
	newins conf/debvol_mirrors.gz debvol_mirrors.gz || die
	newins conf/ubuntu_mirrors ubuntu_mirrors || die
	newins conf/archlx_mirrors archlx_mirrors || die
	newins conf/sfnet_mirrors sfnet_mirrors || die
	newins conf/cygwin_mirrors cygwin_mirrors || die
	newins conf/security.conf security.conf || die
	newins conf/maint.html maint.html || die
	newins conf/userinfo.html userinfo.html || die
	newins conf/style.css style.css || die

	dodir /var/cache/${PN} || die
	dodir /var/log/${PN} || die
	# Some directories must exists
	keepdir /var/log/${PN}
	keepdir /var/run/${PN}
	fowners -R ${PN}:${PN} \
		/etc/${PN} \
		/var/log/${PN} \
		/var/cache/${PN} \
		/var/run/${PN} || die
}
