# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/cpufrequtils/cpufrequtils-0.2.ebuild,v 1.2 2005/04/01 03:39:42 josejx Exp $

# The following works for both releases and pre-releases
MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Userspace utilities and library for the Linux kernel cpufreq subsystem"

HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/cpufreq/cpufrequtils.html"
SRC_URI="http://www.kernel.org/pub/linux/utils/kernel/cpufreq/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

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
	emake DESTDIR=${D} install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README
}
