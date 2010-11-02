# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/xsb/xsb-3.2-r1.ebuild,v 1.5 2010/11/02 05:59:46 keri Exp $

MY_P="XSB"

PATCHSET_VER="3"

inherit eutils autotools java-pkg-opt-2

DESCRIPTION="XSB is a logic programming and deductive database system"
HOMEPAGE="http://xsb.sourceforge.net"
SRC_URI="http://xsb.sourceforge.net/downloads/${MY_P}.tar.gz
	mirror://gentoo/${P}-gentoo-patchset-${PATCHSET_VER}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug examples iodbc java libwww mysql odbc perl threads xml"

RDEPEND="iodbc? ( dev-db/libiodbc )
	java? ( >=virtual/jdk-1.4 )
	libwww? ( net-libs/libwww )
	mysql? ( virtual/mysql )
	odbc? ( dev-db/unixODBC )
	perl? ( dev-lang/perl )
	xml? ( dev-libs/libxml2 )"

DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	EPATCH_FORCE=yes
	EPATCH_SUFFIX=patch
	epatch "${WORKDIR}"/${PV}

	cd "${S}"/build
	eautoconf
}

src_compile() {
	cd "${S}"/build

	econf \
		--libdir=/usr/$(get_libdir) \
		--disable-optimization \
		--without-smodels \
		--with-config-tag="" \
		$(use_with java interprolog) \
		$(use_with odbc) \
		$(use_with iodbc) \
		$(use_enable threads mt) \
		$(use_enable debug)

	emake || die "emake failed"

	if use libwww ; then
		cd "${S}"/packages/libwww
		econf --with-libwww=/usr
	fi

	if use mysql ; then
		cd "${S}"/packages/dbdrivers/mysql
		econf
	fi

	if use odbc ; then
		cd "${S}"/packages/dbdrivers/odbc
		econf
	fi

	if use xml ; then
		cd "${S}"/packages/xpath
		econf
	fi

	# All XSB Packages are compiled using a single Prolog engine.
	# Consequently they must all be compiled using a single make job.

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
	emake DESTDIR="${D}" install || die "make install failed"

	local XSB_INSTALL_DIR=/usr/$(get_libdir)/xsb-${PV}
	dosym ${XSB_INSTALL_DIR}/bin/xsb /usr/bin/xsb || die

	cd "${S}"/packages
	local PACKAGES=${XSB_INSTALL_DIR}/packages
	insinto ${PACKAGES}
	doins *.xwam || die

	insinto ${PACKAGES}/chr
	doins chr/*.xwam || die

	insinto ${PACKAGES}/chr_d
	doins chr_d/*.xwam || die

	insinto ${PACKAGES}/gap
	doins gap/*.xwam || die

	insinto ${PACKAGES}/justify
	doins justify/*.xwam || die
	doins justify/*.H || die

	insinto ${PACKAGES}/regmatch
	doins regmatch/*.xwam || die
	insinto ${PACKAGES}/regmatch/cc
	doins regmatch/cc/*.H || die

	insinto ${PACKAGES}/sgml
	doins sgml/*.xwam || die
	insinto ${PACKAGES}/sgml/cc
	doins sgml/cc/*.H || die
	insinto ${PACKAGES}/sgml/cc/dtd
	doins sgml/cc/dtd/* || die

	insinto ${PACKAGES}/slx
	doins slx/*.xwam || die

	insinto ${PACKAGES}/wildmatch
	doins wildmatch/*.xwam || die
	insinto ${PACKAGES}/wildmatch/cc
	doins wildmatch/cc/*.H || die

	if use libwww ; then
		insinto ${PACKAGES}/libwww
		doins libwww/*.xwam || die
		insinto ${PACKAGES}/libwww/cc
		doins libwww/cc/*.H || die
	fi

	if use mysql || use odbc ; then
		insinto ${PACKAGES}/dbdrivers
		doins dbdrivers/*.xwam || die
		doins dbdrivers/*.H || die
		insinto ${PACKAGES}/dbdrivers/cc
		doins dbdrivers/cc/*.H || die
		if use mysql ; then
			insinto ${PACKAGES}/dbdrivers/mysql
			doins dbdrivers/mysql/*.xwam || die
			insinto ${PACKAGES}/dbdrivers/mysql/cc
			doins dbdrivers/mysql/cc/*.H || die
		fi
		if use odbc ; then
			insinto ${PACKAGES}/dbdrivers/odbc
			doins dbdrivers/odbc/*.xwam || die
			insinto ${PACKAGES}/dbdrivers/odbc/cc
			doins dbdrivers/odbc/cc/*.H || die
		fi
	fi

	if use perl ; then
		insinto ${PACKAGES}/perlmatch
		doins perlmatch/*.xwam || die
		insinto ${PACKAGES}/perlmatch/cc
		doins perlmatch/cc/*.H || die
	fi

	if use xml ; then
		insinto ${PACKAGES}/xpath
		doins xpath/*xwam || die
		insinto ${PACKAGES}/xpath/cc
		doins xpath/cc/*.H || die
	fi

	if use examples ; then
		cd "${S}"/build
		emake \
			DESTDIR="${D}" \
			install_examples="${D}"/usr/share/doc/${PF}/examples \
			install_examples || die "make install_examples failed"
	fi

	cd "${S}"
	dodoc FAQ README || die
}
