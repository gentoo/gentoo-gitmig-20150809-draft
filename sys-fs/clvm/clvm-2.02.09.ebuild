# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/clvm/clvm-2.02.09.ebuild,v 1.3 2006/10/18 10:41:06 xmerlin Exp $

MY_P="${PN/clvm/LVM2}.${PV}"

DESCRIPTION="User-land utilities for clvm (device-mapper) software."
HOMEPAGE="http://sources.redhat.com/cluster/clvm/"
SRC_URI="ftp://sources.redhat.com/pub/lvm2/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="readline nocman "

DEPEND=">=sys-fs/device-mapper-1.02.03
	>=sys-cluster/dlm-1.01.00
	!nocman? ( >=sys-cluster/cman-1.01.00 )"

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
		--with-pool=shared \
		--with-snapshots=shared \
		--with-mirrors=shared \
		${myconf}

	emake || die "compile problem"
}

src_install() {
	einstall sbindir="${D}/sbin" confdir="${D}/etc/lvm"

	dodoc COPYING* INSTALL README VERSION WHATS_NEW doc/*.{conf,c,txt}

	newinitd ${FILESDIR}/clvmd.rc clvmd || die

	insinto /lib/rcscripts/addons
	newins ${FILESDIR}/lvm2-start.sh lvm-start.sh || die
	newins ${FILESDIR}/lvm2-stop.sh lvm-stop.sh || die
}
