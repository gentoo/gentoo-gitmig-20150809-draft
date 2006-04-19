# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lvm2/lvm2-2.01.14-r1.ebuild,v 1.2 2006/04/19 22:01:35 rocket Exp $

DESCRIPTION="User-land utilities for LVM2 (device-mapper) software."
HOMEPAGE="http://sources.redhat.com/lvm2/"
SRC_URI="ftp://sources.redhat.com/pub/lvm2/${PN/lvm/LVM}.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="readline nolvmstatic selinux"

DEPEND="=sys-fs/device-mapper-1.01*"
RDEPEND="${DEPEND}
	!sys-fs/lvm-user"

S="${WORKDIR}/${PN/lvm/LVM}.${PV}"

inherit eutils
src_unpack() {
	unpack ${A}
	cd ${S} || die
	epatch ${FILESDIR}/lvm2-2.01.14.patch
	epatch ${FILESDIR}/lvm2-2.01.14-static.patch
}
src_compile() {
	# Static compile of lvm2 so that the install described in the handbook works
	# http://www.gentoo.org/doc/en/lvm2.xml
	# fixes http://bugs.gentoo.org/show_bug.cgi?id=84463
	local myconf
	use nolvmstatic || myconf="--enable-static_link"

	# disable O_DIRECT support on hppa, breaks pv detection (#99532)
	use hppa && myconf="${myconf} --disable-o_direct"

	econf $(use_enable readline) $(use_enable selinux) ${myconf} || die
	emake || die "compile problem"
}

src_install() {
	einstall sbindir="${D}/sbin" staticdir="${D}/sbin" confdir="${D}/etc/lvm"
	mv -f "${D}/sbin/lvm.static" "${D}/sbin/lvm"

	dodoc COPYING* INSTALL README VERSION WHATS_NEW doc/*.{conf,c,txt}
	insinto /lib/rcscripts/addons
	newins ${FILESDIR}/lvm2-start.sh lvm-start.sh
	newins ${FILESDIR}/lvm2-stop.sh lvm-stop.sh
}
