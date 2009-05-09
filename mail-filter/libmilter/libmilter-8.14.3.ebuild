# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/libmilter/libmilter-8.14.3.ebuild,v 1.8 2009/05/09 12:23:46 mrness Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="The Sendmail Filter API (Milter)"
HOMEPAGE="http://www.sendmail.org/"
SRC_URI="ftp://ftp.sendmail.org/pub/sendmail/sendmail.${PV}.tar.gz"

LICENSE="Sendmail"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE="ipv6 poll"

DEPEND="!mail-mta/sendmail"
RDEPEND="${DEPEND}"

S="${WORKDIR}/sendmail-${PV}"

src_prepare() {
	local ENVDEF="-DNETUNIX -DNETINET"
	use ipv6 && ENVDEF="${ENVDEF} -DNETINET6"
	use poll && ENVDEF="${ENVDEF} -DSM_CONF_POLL=1"

	sed -e "s:@@CFLAGS@@:${CFLAGS}:" -e "s:@@ENVDEF@@:${ENVDEF}:" \
		"${FILESDIR}/gentoo.config.m4" > "${S}/devtools/Site/site.config.m4" \
		|| die "failed to generate site.config.m4"
}

src_compile() {
	pushd libmilter
	emake -j1 CC="$(tc-getCC)" || die "libmilter compilation failed"
	popd
}

src_install () {
	local MY_LIBDIR=/usr/$(get_libdir)
	dodir "${MY_LIBDIR}" /usr/include/libmilter
	emake DESTDIR="${D}" LIBDIR="${MY_LIBDIR}" MANROOT=/usr/share/man/man \
		SBINOWN=root SBINGRP=root UBINOWN=root UBINGRP=root \
		LIBOWN=root LIBGRP=root GBINOWN=root GBINGRP=root \
		MANOWN=root MANGRP=root INCOWN=root INCGRP=root \
		MSPQOWN=root CFOWN=root CFGRP=root \
		install -C obj.*/libmilter \
		|| die "install failed"

	dodoc libmilter/README
	dohtml libmilter/docs/*
}
