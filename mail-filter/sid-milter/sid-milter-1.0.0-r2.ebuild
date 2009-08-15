# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/sid-milter/sid-milter-1.0.0-r2.ebuild,v 1.4 2009/08/15 12:42:46 mrness Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="A milter-based application to provide Sender-ID verification service"
HOMEPAGE="http://sourceforge.net/projects/sid-milter/"
SRC_URI="mirror://sourceforge/sid-milter/${P}.tar.gz"

LICENSE="Sendmail-Open-Source"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="ipv6"

RDEPEND="dev-libs/openssl
	>=sys-libs/db-3.2"
DEPEND="${RDEPEND}
	|| ( mail-filter/libmilter mail-mta/sendmail )" # libmilter is a static library

pkg_setup() {
	enewgroup milter
	# mail-milter/spamass-milter creates milter user with this home directory
	# For consistency reasons, milter user must be created here with this home directory
	# even though this package doesn't need a home directory for this user (#280571)
	enewuser milter -1 -1 /var/lib/milter milter
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-nopra_on_spf1.patch
	epatch "${FILESDIR}"/${P}-as-needed.patch

	local ENVDEF=""
	use ipv6 && ENVDEF="${ENVDEF} -DNETINET6"
	sed -e "s:@@CFLAGS@@:${CFLAGS}:" \
		-e "s:@@ENVDEF@@:${ENVDEF}:" \
		"${FILESDIR}/gentoo-config.m4" > "${S}/devtools/Site/site.config.m4" \
		|| die "failed to generate site.config.m4"
}

src_compile() {
	emake -j1 CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dodir /usr/bin
	emake -j1 DESTDIR="${D}" SUBDIRS=sid-filter \
		SBINOWN=root SBINGRP=root UBINOWN=root UBINGRP=root \
		install || die "make install failed"

	newinitd "${FILESDIR}/sid-filter.init" sid-filter \
		|| die "newinitd failed"
	newconfd "${FILESDIR}/sid-filter.conf" sid-filter \
		|| die "newconfd failed"

	# man build is broken; do man page installation by hand
	doman */*.8 || die "failed to install man pages"

	# some people like docs
	dodoc RELEASE_NOTES *.txt sid-filter/README || die "failed to install docs"
}
