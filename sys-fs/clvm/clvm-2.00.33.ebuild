# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/clvm/clvm-2.00.33.ebuild,v 1.4 2005/03/26 14:31:27 xmerlin Exp $

MY_P="${PN/clvm/LVM2}.${PV}"

DESCRIPTION="User-land utilities for clvm (device-mapper) software."
HOMEPAGE="http://sources.redhat.com/cluster/clvm/"
SRC_URI="ftp://sources.redhat.com/pub/lvm2/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 "
IUSE="readline nolvmstatic nocman "

DEPEND=">=sys-fs/device-mapper-1.00.17
	!nocman? ( =sys-cluster/cman-1.0_pre31 )
	nocman? ( =sys-cluster/gulm-1.0_pre25 )"

RDEPEND="${DEPEND}
	!sys-fs/lvm-user
	!sys-fs/lvm2"

S="${WORKDIR}/${MY_P}"

src_compile() {
	# Static compile of lvm2 so that the install described in the handbook works
	# http://www.gentoo.org/doc/en/lvm2.xml
	# fixes http://bugs.gentoo.org/show_bug.cgi?id=84463
	local myconf=""
	use nolvmstatic || myconf="$(use_enable static_link)"
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
	einstall sbindir="${D}/sbin" staticdir="${D}/sbin" confdir="${D}/etc/lvm"
	mv -f "${D}/sbin/lvm.static" "${D}/sbin/lvm"

	dodoc COPYING* INSTALL README VERSION WHATS_NEW doc/*.{conf,c,txt}

	newinitd ${FILESDIR}/clvmd.rc clvmd || die
}
