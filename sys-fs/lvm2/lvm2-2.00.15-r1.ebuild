# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lvm2/lvm2-2.00.15-r1.ebuild,v 1.3 2004/11/14 16:32:05 max Exp $

DESCRIPTION="User-land utilities for LVM2 (device-mapper) software."
HOMEPAGE="http://sources.redhat.com/lvm2/"
SRC_URI="ftp://sources.redhat.com/pub/lvm2/old/${PN/lvm/LVM}.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~ppc64 ~alpha"
IUSE="static"

DEPEND=">=sys-libs/device-mapper-1.00.17"
RDEPEND="${DEPEND}
	!sys-fs/lvm-user"

S="${WORKDIR}/${PN/lvm/LVM}.${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}

	use static && ( sed -i -e 's/TARGETS += lvm.static/TARGETS = .commands lvm-static/' \
	-e 's/^install_tools_static:/install_tools_unused:/' \
	-e 's/^install_tools_dynamic: lvm/install_tools_static: lvm.static/' \
	-e 's/lvm \\$/lvm.static \\/' tools/Makefile.in || die "sed failed" )
}


src_compile() {
	econf $(use_enable static static_link) || die "econf failed"

	emake || die "compile problem"
}

src_install() {
	einstall sbindir="${D}/sbin" confdir="${D}/etc/lvm"
	dodoc COPYING* INSTALL README VERSION WHATS_NEW doc/*.{conf,c,txt}
}
