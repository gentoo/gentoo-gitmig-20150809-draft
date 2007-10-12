# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lvm2/lvm2-2.02.28-r2.ebuild,v 1.3 2007/10/12 01:56:43 robbat2 Exp $

inherit eutils

DESCRIPTION="User-land utilities for LVM2 (device-mapper) software."
HOMEPAGE="http://sources.redhat.com/lvm2/"
SRC_URI="ftp://sources.redhat.com/pub/lvm2/${PN/lvm/LVM}.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"

# These no* flags are going to be removed shortly, pending a mail to -dev
# - robbat2, 2007/10/02
IUSE="readline nolvmstatic clvm cman gulm nolvm1 selinux"

DEPEND=">=sys-fs/device-mapper-1.02.22-r1
		clvm? ( >=sys-cluster/dlm-1.01.00
			cman? ( >=sys-cluster/cman-1.01.00 )
			gulm? ( >=sys-cluster/gulm-1.00.00 ) )"

RDEPEND="${DEPEND}
	!sys-fs/lvm-user
	!sys-fs/clvm"

S="${WORKDIR}/${PN/lvm/LVM}.${PV}"

src_unpack() {
	unpack ${A}
	#cd "${S}" || die
	#epatch "${FILESDIR}"/lvm2-2.02.04-vgid.patch
}

src_compile() {
	# Static compile of lvm2 so that the install described in the handbook works
	# http://www.gentoo.org/doc/en/lvm2.xml
	# fixes http://bugs.gentoo.org/show_bug.cgi?id=84463
	local myconf
	local buildmode

	# fsadm is broken, don't include it (2.02.28)
	myconf="${myconf} --enable-dmeventd --enable-cmdlib"

	# Most of this package does weird stuff.
	# The build options are tristate, and --without is NOT supported
	# options: 'none', 'internal', 'shared'
	if use nolvmstatic ; then
		buildmode="shared"
	else
		myconf="${myconf} --enable-static_link"
		buildmode="internal"
	fi

	# dmeventd requires mirrors to be internal, and snapshot available
	# so we cannot disable them
	myconf="${myconf} --with-mirrors=internal"
	myconf="${myconf} --with-snapshots=${buildmode}"

	if use nolvm1 ; then
		myconf="${myconf} --with-lvm1=none"
	else
		myconf="${myconf} --with-lvm1=${buildmode}"
	fi

	# disable O_DIRECT support on hppa, breaks pv detection (#99532)
	use hppa && myconf="${myconf} --disable-o_direct"

	if use clvm; then
		myconf="${myconf} --with-cluster=${buildmode}"
		# 4-state!
		local clvmd="none"
		use cman && clvmd="cman"
		use gulm && clvmd="${clvmd}gulm"
		clvmd="${clvmd/cmangulm/all}"
		myconf="${myconf} --with-clvmd=${clvmd}"
	else
		myconf="${myconf} --with-clvmd=none --with-cluster=none"
	fi

	myconf="${myconf} --sbindir=/sbin --with-staticdir=/sbin"
	econf $(use_enable readline) $(use_enable selinux) ${myconf} || die
	emake || die "compile problem"
}

src_install() {
	emake DESTDIR="${D}" install
	mv -f "${D}"/sbin/lvm.static "${D}"/sbin/lvm

	dodoc README VERSION WHATS_NEW doc/*.{conf,c,txt}
	insinto /lib/rcscripts/addons
	newins "${FILESDIR}"/lvm2-start.sh-2.02.28-r2 lvm-start.sh || die
	newins "${FILESDIR}"/lvm2-stop.sh lvm-stop.sh || die
	newinitd "${FILESDIR}"/lvm.rc-2.02.28-r2 lvm || die
	newconfd "${FILESDIR}"/lvm.confd-2.02.28-r2 lvm || die
	if use clvm; then
		newinitd "${FILESDIR}"/clvmd.rc clvmd || die
	fi

	ewarn "use flag nocman is deprecated and replaced"
	ewarn "with cman and gulm use flags."
	ewarn ""
	ewarn "use flags clvm,cman and gulm are masked"
	ewarn "by default and need to be unmasked to use them"
	ewarn ""
	ewarn "Rebuild your genkernel initramfs if you are using lvm"
}

pkg_postinst() {
	elog "lvm volumes are no longer automatically created for"
	elog "baselayout-2 users. If you are using baselayout-2, be sure to"
	elog "run: # rc-update add lvm boot"
}
