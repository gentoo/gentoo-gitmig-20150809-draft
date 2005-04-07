# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lvm2/lvm2-2.00.33-r1.ebuild,v 1.5 2005/04/07 17:00:11 blubb Exp $

DESCRIPTION="User-land utilities for LVM2 (device-mapper) software."
HOMEPAGE="http://sources.redhat.com/lvm2/"
SRC_URI="ftp://sources.redhat.com/pub/lvm2/${PN/lvm/LVM}.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc amd64 ~ppc64 ~alpha hppa"
IUSE="readline static"

DEPEND=">=sys-fs/device-mapper-1.00.17"
RDEPEND="${DEPEND}
	!sys-fs/lvm-user"

S="${WORKDIR}/${PN/lvm/LVM}.${PV}"

src_compile() {
	econf $(use_enable readline) $(use_enable static static_link)
	emake || die "compile problem"
}

src_install() {
	einstall sbindir="${D}/sbin" staticdir="${D}/sbin" confdir="${D}/etc/lvm"
	use static && mv -f "${D}/sbin/lvm.static" "${D}/sbin/lvm"

	dodoc COPYING* INSTALL README VERSION WHATS_NEW doc/*.{conf,c,txt}
	insinto /lib/rcscripts/addons
	newins ${FILESDIR}/lvm2-start.sh lvm-start.sh
	newins ${FILESDIR}/lvm2-stop.sh lvm-stop.sh
}
