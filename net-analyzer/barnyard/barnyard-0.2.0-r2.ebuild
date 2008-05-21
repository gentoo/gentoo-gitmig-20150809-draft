# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/barnyard/barnyard-0.2.0-r2.ebuild,v 1.7 2008/05/21 18:46:22 dev-zero Exp $

WANT_AUTOMAKE="1.4"
inherit eutils autotools

DESCRIPTION="Fast output system for Snort"
HOMEPAGE="http://www.snort.org/dl/barnyard/"
SRC_URI="mirror://sourceforge/barnyard/barnyard-${PV/_/-}.tar.gz
	mirror://gentoo/${P}-patches.tar.bz2"

SLOT="0"
LICENSE="QPL"
KEYWORDS="~x86 -sparc"
IUSE="mysql postgres sguil"

DEPEND="net-libs/libpcap
	postgres? ( >=virtual/postgresql-server-7.2 )
	mysql? ( virtual/mysql )
	sguil? ( dev-lang/tcl )"

RDEPEND="${DEPEND}
	net-analyzer/snort"

S="${WORKDIR}/${P/_/-}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	if use sguil ; then
		epatch "${WORKDIR}/${PV}-sguil_files.patch"
		epatch "${WORKDIR}/${PV}-configure-in.patch"
		cd "${S}/src/output-plugins"
		epatch "${WORKDIR}/${PV}-op_plugbase.c.patch"
		cd "${S}"
		eautoreconf
	fi
}

src_compile() {
	local myconf
	if use sguil ; then
		myconf="--enable-tcl"
	fi

	econf \
		${myconf} \
		--sysconfdir=/etc/snort \
		$(use_enable postgres) \
		$(use_enable mysql)
	emake || die "compile problem"
}

src_install () {

	make DESTDIR="${D}" install || die

	dodoc docs/*
	dodoc AUTHORS README

	keepdir /var/log/snort
	keepdir /var/log/snort/archive

	insinto /etc/snort
	newins etc/barnyard.conf barnyard.conf
	if use sguil ; then
		sed -i -e "/config hostname:/s%snorthost%$(hostname)%" \
		-e "/config interface/s:fxp0:eth0:" \
		-e "s:output alert_fast:#output alert_fast:" \
		-e "s:output log_dump:#output log_dump:" \
			"${D}/etc/snort/barnyard.conf" || die "sed failed"
	fi

	newconfd "${FILESDIR}"/barnyard.confd barnyard
	if use sguil ; then
		sed -i -e s:/var/log/snort:/var/lib/sguil/$(hostname): \
		-e s:/var/run/barnyard.pid:/var/run/sguil/barnyard.pid: \
			"${D}/etc/conf.d/barnyard" || die "sed failed"
	fi

	newinitd "${FILESDIR}"/barnyard.rc6 barnyard
	if use sguil ; then
		sed -i -e "/start-stop-daemon --start/s:--exec:-c sguil --exec:" \
			"${D}/etc/init.d/barnyard" || die "sed failed"
	fi
}

pkg_postinst() {
	if use sguil ; then
		elog
		elog "Make sure to edit /etc/snort/barnyard.conf and uncomment the"
		elog "sguil section along with supplying the appropriate database"
		elog "information."
		elog
	fi
}
