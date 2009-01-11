# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/s390-tools/s390-tools-1.8.0.ebuild,v 1.3 2009/01/11 08:56:20 vapier Exp $

inherit eutils

# look at zfcpdump_v2/README
E2FSPROGS_P=e2fsprogs-1.41.3
LINUX_P=linux-2.6.27

DESCRIPTION="A set of user space utilities that should be used together with the zSeries (s390) Linux kernel and device drivers"
HOMEPAGE="http://www.ibm.com/developerworks/linux/linux390/october2005_recommended.html"
SRC_URI="http://download.boulder.ibm.com/ibmdl/pub/software/dw/linux390/ht_src/${P}.tar.bz2
	zfcpdump? (
		mirror://sourceforge/e2fsprogs/${E2FSPROGS_P}.tar.gz
		mirror://kernel/linux/kernel/v2.6/${LINUX_P}.tar.bz2
	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~s390"
IUSE="snmp zfcpdump"

RDEPEND="sys-fs/sysfsutils
	snmp? ( net-analyzer/net-snmp )"
DEPEND="${RDEPEND}
	dev-util/indent
	app-admin/genromfs"
PROVIDE="virtual/bootloader"

src_unpack() {
	unpack ${P}.tar.bz2
	cd "${S}"

	epatch "${FILESDIR}"/${P}-build.patch
	sed -i -re 's:__u(8|16|32):uint\1_t:' $(find osasnmpd -name '*.h')

	use snmp || sed -i -e '/SUB_DIRS/s:osasnmpd::' Makefile

	if use zfcpdump ; then
		local x
		for x in ${E2FSPROGS_P}.tar.gz ${LINUX_P}.tar.bz2 ; do
			ln -s "${DISTDIR}"/${x} zfcpdump/${x} || die "ln ${x}"
		done
		sed -i -e '/^ZFCPDUMP_DIR/s:local/::' common.mak
		sed -i -e '/^SUB_DIRS/s:$: zfcpdump_v2:' Makefile
	fi
}

src_install() {
	emake install INSTROOT="${D}" USRBINDIR="${D}/sbin" || die
	dodoc README
	insinto /etc/udev/rules.d
	doins etc/udev/rules.d/*.rules || die
}
