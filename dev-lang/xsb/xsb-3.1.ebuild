# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/xsb/xsb-3.1.ebuild,v 1.4 2009/01/27 05:22:14 keri Exp $

MY_PN="XSB"
MY_P="${MY_PN}-unix"

PATCHSET_VER="0"

inherit eutils autotools java-pkg-opt-2

DESCRIPTION="XSB is a logic programming and deductive database system"
HOMEPAGE="http://xsb.sourceforge.net"
SRC_URI="mirror://sourceforge/xsb/${MY_P}.tar.gz
	mirror://gentoo/${P}-gentoo-patchset-${PATCHSET_VER}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug iodbc java libwww mysql odbc perl threads xml"

DEPEND="iodbc? ( dev-db/libiodbc )
	java? ( >=virtual/jdk-1.4 )
	libwww? ( net-libs/libwww )
	mysql? ( virtual/mysql )
	odbc? ( dev-db/unixODBC )
	perl? ( dev-lang/perl )
	xml? ( dev-libs/libxml2 )"

S="${WORKDIR}"/${MY_PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	EPATCH_FORCE=yes
	EPATCH_SUFFIX=patch
	epatch "${WORKDIR}"/${PV}

#	epatch "${FILESDIR}"/${P}-configure.patch
#	epatch "${FILESDIR}"/${P}-portage.patch
#	epatch "${FILESDIR}"/${P}-varstring.patch
#	epatch "${FILESDIR}"/${P}-orient.patch
#	epatch "${FILESDIR}"/${P}-xsb-script.patch
#	epatch "${FILESDIR}"/${P}-nostrip.patch
#	epatch "${FILESDIR}"/${P}-packages.patch
#	epatch "${FILESDIR}"/${P}-chr_d.patch
#	epatch "${FILESDIR}"/${P}-dbdrivers.patch
#	epatch "${FILESDIR}"/${P}-gap.patch
#	epatch "${FILESDIR}"/${P}-justify.patch
#	epatch "${FILESDIR}"/${P}-libwww.patch
#	epatch "${FILESDIR}"/${P}-mysql.patch
#	epatch "${FILESDIR}"/${P}-odbc.patch
#	epatch "${FILESDIR}"/${P}-perlmatch.patch
#	epatch "${FILESDIR}"/${P}-sgml.patch
#	epatch "${FILESDIR}"/${P}-xpath.patch

	cd "${S}"/build
	eautoconf
}

src_compile() {
	cd "${S}"/build

	einfo "Building xsb compiler"
	econf \
		--disable-optimization \
		--without-smodels \
		--with-config-tag="" \
		$(use_with java interprolog) \
		$(use_with odbc) \
		$(use_with iodbc) \
		$(use_enable threads mt) \
		$(use_enable debug) \
		$(use_enable debug debug-verbose) \
		$(use_enable debug profile) \
		|| die "econf failed"
	emake -j1 || die "emake failed"

	einfo "Building xsb packages"

	if use libwww ; then
		cd "${S}"/packages/libwww
		econf --with-libwww=/usr || die "econf libwww package failed"
	fi

	if use mysql ; then
		cd "${S}"/packages/dbdrivers/mysql
		econf || die "econf mysql package failed"
	fi

	if use odbc ; then
		cd "${S}"/packages/dbdrivers/odbc
		econf || die "econf odbc package failed"
	fi

	if use xml ; then
		cd "${S}"/packages/xpath
		econf || die "econf xpath package failed"
	fi

	cd "${S}"/packages
	rm -rf *.xwam
	emake -j1 || die "emake packages failed"

	if use libwww ; then
		emake -j1 libwww || die "emake libwww package failed"
	fi

	if use mysql ; then
		emake -j1 mysql || die "emake mysql package failed"
	fi

	if use odbc ; then
		emake -j1 odbc || die "emake odbc package failed"
	fi

	if use perl ; then
		emake -j1 perlmatch || die "emake perlmatch package failed"
	fi

	if use xml ; then
		emake -j1 xpath || die "emake xpath package failed"
	fi
}

src_install() {
	cd "${S}"/build
	make DESTDIR="${D}" install || die

	dosym /usr/lib/xsb/bin/xsb /usr/bin/xsb

	cd "${S}"/packages
	local PACKAGES=/usr/lib/xsb/packages
	insinto ${PACKAGES}
	doins *.xwam

	insinto ${PACKAGES}/chr
	doins chr/*.xwam

	insinto ${PACKAGES}/chr_d
	doins chr_d/*.xwam

	insinto ${PACKAGES}/gap
	doins gap/*.xwam

	insinto ${PACKAGES}/justify
	doins justify/*.xwam
	doins justify/*.H

	insinto ${PACKAGES}/regmatch
	doins regmatch/*.xwam
	insinto ${PACKAGES}/regmatch/cc
	doins regmatch/cc/*.H

	insinto ${PACKAGES}/sgml
	doins sgml/*.xwam
	insinto ${PACKAGES}/sgml/cc
	doins sgml/cc/*.H
	insinto ${PACKAGES}/sgml/cc/dtd
	doins sgml/cc/dtd/*

	insinto ${PACKAGES}/slx
	doins slx/*.xwam

	insinto ${PACKAGES}/wildmatch
	doins wildmatch/*.xwam
	insinto ${PACKAGES}/wildmatch/cc
	doins wildmatch/cc/*.H

	if use libwww ; then
		insinto ${PACKAGES}/libwww
		doins libwww/*.xwam
		insinto ${PACKAGES}/libwww/cc
		doins libwww/cc/*.H
	fi

	if use mysql || use odbc ; then
		insinto ${PACKAGES}/dbdrivers
		doins dbdrivers/*.xwam
		doins dbdrivers/*.H
		insinto ${PACKAGES}/dbdrivers/cc
		doins dbdrivers/cc/*.H
		if use mysql ; then
			insinto ${PACKAGES}/dbdrivers/mysql
			doins dbdrivers/mysql/*.xwam
			insinto ${PACKAGES}/dbdrivers/mysql/cc
			doins dbdrivers/mysql/cc/*.H
		fi
		if use odbc ; then
			insinto ${PACKAGES}/dbdrivers/odbc
			doins dbdrivers/odbc/*.xwam
			insinto ${PACKAGES}/dbdrivers/odbc/cc
			doins dbdrivers/odbc/cc/*.H
		fi
	fi

	if use perl ; then
		insinto ${PACKAGES}/perlmatch
		doins perlmatch/*.xwam
		insinto ${PACKAGES}/perlmatch/cc
		doins perlmatch/cc/*.H
	fi

	if use xml ; then
		insinto ${PACKAGES}/xpath
		doins xpath/*xwam
		insinto ${PACKAGES}/xpath/cc
		doins xpath/cc/*.H
	fi

	cd "${S}"
	dodoc FAQ README
}
