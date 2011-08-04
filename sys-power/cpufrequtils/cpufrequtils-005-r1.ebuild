# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/cpufrequtils/cpufrequtils-005-r1.ebuild,v 1.7 2011/08/04 15:26:01 mattst88 Exp $

inherit eutils toolchain-funcs multilib

DESCRIPTION="Userspace utilities for the Linux kernel cpufreq subsystem"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/cpufreq/cpufrequtils.html"
SRC_URI="mirror://kernel/linux/utils/kernel/cpufreq/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm ia64 ppc ppc64 sparc x86"
IUSE="debug nls"

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/${P}-nls.patch #205576
}

ft() { use $1 && echo true || echo false ; }

src_compile() {
	emake \
		OPTIMIZATION= V=true \
		DEBUG=$(ft debug) \
		NLS=$(ft nls) \
		CC=$(tc-getCC) LD=$(tc-getCC) AR=$(tc-getAR) STRIP=echo RANLIB=$(tc-getRANLIB) \
		|| die "emake failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		NLS=$(ft nls) \
		mandir=/usr/share/man \
		libdir=/usr/$(get_libdir) \
		install || die "make install failed"

	newconfd "${FILESDIR}"/${PN}-conf.d-005 ${PN}
	newinitd "${FILESDIR}"/${PN}-init.d-005 ${PN}

	dodoc AUTHORS README
}
