# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/symon/symon-2.79-r5.ebuild,v 1.1 2008/11/17 00:00:46 tcunha Exp $

EAPI=1

inherit eutils perl-module toolchain-funcs

DESCRIPTION="Performance and information monitoring tool"
HOMEPAGE="http://www.xs4all.nl/~wpd/symon/"
SRC_URI="http://www.xs4all.nl/~wpd/symon/philes/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="perl +symon symux"

RDEPEND="perl? ( dev-lang/perl )
	symux? ( net-analyzer/rrdtool )"
DEPEND="${RDEPEND}
	virtual/pmake"

S=${WORKDIR}/${PN}

build_symon() {
	[[ -n "${BUILD_SYMON}" ]] && return 0 || return 1
}

zap_subdir() {
	sed -i "/SUBDIR/s/$1//" "${S}"/Makefile || die "sed $1 failed"
}

pkg_setup() {
	if ! use perl && ! use symon && ! use symux ; then
		ewarn "You have perl, symon, and symux USE flags disabled."
		ewarn "That means I have nothing to install but, I'll emerge the"
		ewarn "system monitor as default. Please, enable at least one USE"
		ewarn "flag to avoid this message."
		BUILD_SYMON=YES
	fi
	use symon && BUILD_SYMON=YES
}

src_unpack() {
	unpack ${A}

	build_symon	&& epatch "${FILESDIR}"/${PN}-symon.conf.patch
	use symux	&& epatch "${FILESDIR}"/${PN}-symux.conf.patch

	sed -i '/${CC}.*${LIBS}/s/${CC}/& ${LDFLAGS}/' \
		"${S}"/sym{on,ux}/Makefile || die "sed ldflags failed"

	use perl && ! use symon && ! use symux	&& zap_subdir lib
	! use perl								&& zap_subdir client
	! use symux								&& zap_subdir symux
	build_symon								|| zap_subdir symon
}

src_compile() {
	MAKE=pmake MAKEOPTS= emake			\
		AR="$(tc-getAR)"				\
		CC="$(tc-getCC)"				\
		CFLAGS+="${CFLAGS}"				\
		RANLIB="$(tc-getRANLIB)"		\
		STRIP=true || die "emake failed"
}

src_install() {
	if use perl ; then
		dobin client/getsymonitem.pl || die "dobin getsymonitem.pl failed"

		perlinfo
		insinto ${SITE_LIB}
		doins client/SymuxClient.pm || die "doins SymuxClient.pm failed"
	fi

	if build_symon ; then
		insinto /etc
		doins symon/symon.conf || die "doins symon.conf failed"

		newinitd "${FILESDIR}"/${PN}-init.d ${PN} || die "newinitd symon failed"

		dodoc CHANGELOG HACKERS TODO || die "dodoc failed"

		doman symon/symon.8 || die "doman symon failed"
		dosbin symon/symon || die "dosbin symon failed"

		dodir /usr/share/symon
		insinto /usr/share/symon
		doins symon/c_config.sh || die "doins c_config.sh failed"
		fperms a+x,u-w /usr/share/symon/c_config.sh
	fi

	if use symux ; then
		insinto /etc
		doins symux/symux.conf || die "doins symux.conf failed"

		newinitd "${FILESDIR}"/symux-init.d symux || die "newinitd symux failed"

		doman symux/symux.8 || die "doman symux failed"
		dosbin symux/symux || die "dosbin symux failed"

		insinto /usr/share/symon
		doins symux/c_smrrds.sh || die "doins c_smrrds.sh failed"
		fperms u-w,u+x /usr/share/symon/c_smrrds.sh

		dodir /var/lib/symon/rrds/localhost
	fi
}

pkg_postinst() {
	use perl && perl-module_pkg_postinst

	if build_symon ; then
		elog "Before running the monitor, edit /etc/symon.conf. To test your"
		elog "configuration file, run symon -t."
		elog "NOTE that symon won't chroot by default."
	fi

	if use symux ; then
		elog "Before running the data collector, edit /etc/symux.conf."
		elog "To create the RRDs run /usr/share/symon/c_smrrds.sh all. Then,"
		elog "to test your configuration file, run symux -t."
		elog "For information about migrating RRDs from a previous symux"
		elog "version read the LEGACY FORMATS section of symux(8)."
		elog "To view the rrdtool pictures of the stored data, emerge syweb."
	fi
}
