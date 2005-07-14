# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/clvm/clvm-2.01.09.ebuild,v 1.3 2005/07/14 16:54:14 xmerlin Exp $

MY_P="${PN/clvm/LVM2}.${PV}"

DESCRIPTION="User-land utilities for clvm (device-mapper) software."
HOMEPAGE="http://sources.redhat.com/cluster/clvm/"
SRC_URI="ftp://sources.redhat.com/pub/lvm2/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 "
IUSE="readline nocman "

DEPEND=">=sys-fs/device-mapper-1.00.17
	!nocman? ( =sys-cluster/cman-1.00.00 )"

#	nocman? ( =sys-cluster/gulm-1.00.00 )"

RDEPEND="${DEPEND}
	!sys-fs/lvm-user
	!sys-fs/lvm2"

S="${WORKDIR}/${MY_P}"

src_compile() {
	local myconf=""
	if use nocman; then
		myconf="${myconf} --with-clvmd=gulm"
	else
		myconf="${myconf} --with-clvmd=cman"
	fi

	econf \
		$(use_enable readline) \
		--with-cluster=shared \
		${myconf}

	emake || die "compile problem"
}

src_install() {
	einstall sbindir="${D}/sbin" confdir="${D}/etc/lvm"

	dodoc COPYING* INSTALL README VERSION WHATS_NEW doc/*.{conf,c,txt}

	newinitd ${FILESDIR}/clvmd.rc clvmd || die
}
