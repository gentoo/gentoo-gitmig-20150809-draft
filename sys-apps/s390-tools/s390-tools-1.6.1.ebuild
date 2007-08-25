# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/s390-tools/s390-tools-1.6.1.ebuild,v 1.1 2007/08/25 14:41:47 vapier Exp $

inherit eutils

E2FSPROGS_P=e2fsprogs-1.37
LINUX_P=linux-2.6.12

DESCRIPTION="A set of user space utilities that should be used together with the zSeries (s390) Linux kernel and device drivers"
HOMEPAGE="http://www.ibm.com/developerworks/linux/linux390/october2005_recommended.html"
SRC_URI="mirror://gentoo/${P}.tar.gz
	mirror://sourceforge/e2fsprogs/${E2FSPROGS_P}.tar.gz
	mirror://kernel/linux/kernel/v2.6/${LINUX_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~s390"
IUSE=""

RDEPEND="sys-fs/sysfsutils"
DEPEND="${RDEPEND}
	dev-util/indent
	app-admin/genromfs"
PROVIDE="virtual/bootloader"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	local x
	for x in ${E2FSPROGS_P}.tar.gz ${LINUX_P}.tar.bz2 ; do
		ln -s "${DISTDIR}"/${x} zfcpdump/extern/${x} || die "ln ${x}"
	done
	sed -i -e "s:-lrpm[iodb]*::g" osasnmpd/Makefile.rules
	sed -i -e '/^ZFCPDUMP_DIR/s:local/::' common.mak
}

src_install() {
	emake install INSTROOT="${D}" USRBINDIR="${D}/sbin" || die
	dodoc README
	insinto /etc/udev/rules.d
	doins etc/udev/rules.d/*.rules || die
}
