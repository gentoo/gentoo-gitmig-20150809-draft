# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/cpufrequtils/cpufrequtils-001.ebuild,v 1.3 2006/04/26 15:07:57 brix Exp $

inherit toolchain-funcs multilib

DESCRIPTION="Userspace utilities for the Linux kernel cpufreq subsystem"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/cpufreq/cpufrequtils.html"
SRC_URI="mirror://kernel/linux/utils/kernel/cpufreq/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"

IUSE="debug nls"
RDEPEND="sys-fs/sysfsutils"
DEPEND="sys-apps/sed
		${RDEPEND}"

src_compile() {
	local debug=false nls=false

	use debug && debug=true
	use nls && nls=true

	sed -i \
		-e "s:^\(CFLAGS \:=.*\):\1 ${CFLAGS}:" \
		-e "s:/usr/lib:/usr/$(get_libdir):" \
		${S}/Makefile

	emake -j1 V=true DEBUG=${debug} NLS=${nls} \
		CC=$(tc-getCC) LD=$(tc-getCC) AR=$(tc-getAR) STRIP=echo RANLIB=$(tc-getRANLIB) \
		|| die "emake failed"
}

src_install() {
	local nls=false

	use nls && nls=true

	make DESTDIR="${D}" NLS=${nls} mandir=/usr/share/man install \
		|| die "make install failed"

	newconfd ${FILESDIR}/${P}-conf.d ${PN}
	newinitd ${FILESDIR}/${P}-init.d ${PN}

	dodoc AUTHORS README
}
