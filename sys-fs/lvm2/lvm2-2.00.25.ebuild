# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lvm2/lvm2-2.00.25.ebuild,v 1.1 2004/11/14 17:26:58 max Exp $

DESCRIPTION="User-land utilities for LVM2 (device-mapper) software."
HOMEPAGE="http://sources.redhat.com/lvm2/"
SRC_URI="ftp://sources.redhat.com/pub/lvm2/${PN/lvm/LVM}.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~ppc64 ~alpha"
IUSE="readline static"

DEPEND=">=sys-libs/device-mapper-1.00.17"
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
}
