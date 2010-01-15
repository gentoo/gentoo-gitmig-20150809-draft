# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/cpufrequtils/cpufrequtils-006.ebuild,v 1.1 2010/01/15 07:41:50 vapier Exp $

inherit eutils toolchain-funcs multilib

DESCRIPTION="Userspace utilities for the Linux kernel cpufreq subsystem"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/cpufreq/cpufrequtils.html"
SRC_URI="mirror://kernel/linux/utils/kernel/cpufreq/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug nls"

DEPEND="sys-fs/sysfsutils"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-005-build.patch
	epatch "${FILESDIR}"/${PN}-006-nls.patch #205576 #292246
	epatch "${FILESDIR}"/${PN}-006-modprobe-gov.patch #204069
}

ft() { use $1 && echo true || echo false ; }

src_compile() {
	emake \
		OPTIMIZATION= V=true \
		DEBUG=$(ft debug) \
		NLS=$(ft nls) \
		CC=$(tc-getCC) LD=$(tc-getCC) AR=$(tc-getAR) STRIP=: RANLIB=$(tc-getRANLIB) \
		|| die "emake failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		NLS=$(ft nls) \
		mandir=/usr/share/man \
		libdir=/usr/$(get_libdir) \
		install || die "make install failed"

	newinitd "${FILESDIR}"/${PN}-init.d-006 ${PN}
	newconfd "${FILESDIR}"/${PN}-conf.d-006 ${PN}

	dodoc AUTHORS README
}
