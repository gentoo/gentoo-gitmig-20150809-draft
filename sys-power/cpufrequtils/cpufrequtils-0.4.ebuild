# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/cpufrequtils/cpufrequtils-0.4.ebuild,v 1.3 2006/01/23 02:59:39 tsunam Exp $

# The following works for both releases and pre-releases
MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Userspace utilities for the Linux kernel cpufreq subsystem"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/cpufreq/cpufrequtils.html"
SRC_URI="mirror://kernel/linux/utils/kernel/cpufreq/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"

IUSE="nls"
DEPEND="sys-fs/sysfsutils"

src_compile() {
	econf \
		--enable-proc \
		--enable-sysfs=/sys \
		$(use_enable nls) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	newconfd ${FILESDIR}/${P}-conf.d ${PN}
	newinitd ${FILESDIR}/${P}-init.d ${PN}

	dodoc AUTHORS ChangeLog NEWS README
}
