# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/cpufrequtils/cpufrequtils-005.ebuild,v 1.1 2008/10/20 16:05:14 vapier Exp $

inherit eutils toolchain-funcs multilib

DESCRIPTION="Userspace utilities for the Linux kernel cpufreq subsystem"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/cpufreq/cpufrequtils.html"
SRC_URI="mirror://kernel/linux/utils/kernel/cpufreq/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug nls"

DEPEND="sys-fs/sysfsutils"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/CFLAGDEF/s:-O1 -g::' \
		-e '/CFLAGDEF/s:-fomit-frame-pointer::' \
		Makefile
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
