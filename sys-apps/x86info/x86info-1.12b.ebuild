# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/x86info/x86info-1.12b.ebuild,v 1.5 2004/07/15 02:47:51 agriffis Exp $

inherit eutils

DESCRIPTION="Dave Jones' handy, informative x86 CPU diagnostic utility"
HOMEPAGE="http://www.codemonkey.org.uk/projects/${PN}/"
SRC_URI="${HOMEPAGE}/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -amd64 -ppc -sparc -mips -alpha -hppa"
DEPEND="virtual/kernel"
RDEPEND=""
IUSE=""

src_compile() {
	emake x86info CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	# binaries first
	into /usr
	dobin x86info
	# modules stuff next
	insinto /etc/modules.d
	newins ${FILESDIR}/x86info-modules.conf-rc x86info
	# now we all all the docs
	dodoc TODO README COPYING ChangeLog
	doman x86info.1
	cp -a results ${D}/usr/share/doc/${PF}
	# prepalldocs rocks! I saw it in net-fs/samba/samba-2.2.8
	prepalldocs
}

pkg_postinst() {
	ewarn "Your kernel must be built with the following options"
	ewarn "set to Y or M"
	ewarn "     Processor type and features ->"
	ewarn "         [*] /dev/cpu/*/msr - Model-specific register support"
	ewarn "         [*] /dev/cpu/*/cpuid - CPU information support"
	# copied from media-libs/svgalib/svgalib-1.9.17
	if [ "${ROOT}" = "/" ]; then
		/sbin/modules-update &> /dev/null

		# create device nodes for x86info
		# based off the scripts/makenode
		# there isn't any proper devfs support in cpuid/msr
		einfo "Creating device nodes for x86info"
		mkdir -p ${ROOT}/dev/cpu
		local numprocs
		#subtract one because we are using a 0-based count
		numprocs=$((`grep -c '^processor' /proc/cpuinfo`-1))
		for i in `seq 0 $numprocs`; do
			mkdir ${ROOT}/dev/cpu/$i
			mknod ${ROOT}/dev/cpu/$i/cpuid c 203 $i 2>/dev/null
			mknod ${ROOT}/dev/cpu/$i/msr c 202 $i 2>/dev/null
		done
	fi
}
