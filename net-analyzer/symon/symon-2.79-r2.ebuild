# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/symon/symon-2.79-r2.ebuild,v 1.1 2008/08/19 06:59:50 pva Exp $

inherit eutils perl-module toolchain-funcs

DESCRIPTION="Performance and information monitoring tool"
HOMEPAGE="http://www.xs4all.nl/~wpd/symon/"
SRC_URI="http://www.xs4all.nl/~wpd/symon/philes/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="perl symux"

RDEPEND="perl? ( dev-lang/perl )
	symux? ( net-analyzer/rrdtool )"
DEPEND="${RDEPEND}
	virtual/pmake"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/${PN}-symon.conf.patch
	use symux && epatch "${FILESDIR}"/${PN}-symux.conf.patch
	sed -i -e 's:/${CC}.*${LIBS}/s/${CC}/& ${LDFLAGS}/' \
			"${S}"/sy{mon,mux}/Makefile || die "seding for LDFLAGS failed"

	if ! use perl ; then
		sed -i "/SUBDIR/s/client//" "${S}"/Makefile || die "sed client failed"
	fi
	if ! use symux ; then
		sed -i "/SUBDIR/s/symux//" "${S}"/Makefile || die "sed symux failed"
	fi
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

	if use perl ; then
		dobin client/getsymonitem.pl || die "dobin getsymonitem.pl failed"

		perlinfo
		insinto ${SITE_LIB}
		doins client/SymuxClient.pm || die "doins SymuxClient.pm failed"
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
	elog "Before running the monitor, edit /etc/symon.conf. To test your"
	elog "configuration file, run symon -t."
	elog "NOTE that symon won't chroot by default."

	use perl && perl-module_pkg_postinst

	if use symux ; then
		elog "Before running the data collector, edit /etc/symux.conf."
		elog "To create the RRDs run /usr/share/symon/c_smrrds.sh all. Then,"
		elog "to test your configuration file, run symux -t."
		elog "For information about migrating RRDs from a previous symux"
		elog "version read the LEGACY FORMATS section of symux(8)."
		elog "To view the rrdtool pictures of the stored data, emerge syweb."
	fi
}
