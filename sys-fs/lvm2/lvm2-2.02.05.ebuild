# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lvm2/lvm2-2.02.05.ebuild,v 1.3 2006/04/25 18:48:07 gustavoz Exp $

DESCRIPTION="User-land utilities for LVM2 (device-mapper) software."
HOMEPAGE="http://sources.redhat.com/lvm2/"
SRC_URI="ftp://sources.redhat.com/pub/lvm2/${PN/lvm/LVM}.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa mips ~ppc ~ppc64 sparc ~x86"
IUSE="readline nolvmstatic clvm cman gulm nolvm1 nosnapshots nomirrors selinux"

DEPEND=">=sys-fs/device-mapper-1.02.03
		clvm? ( >=sys-cluster/dlm-1.01.00
			cman? ( >=sys-cluster/cman-1.01.00 )
			gulm? ( >=sys-cluster/gulm-1.00.00 ) )"

RDEPEND="${DEPEND}
	!sys-fs/lvm-user
	!sys-fs/clvm"

S="${WORKDIR}/${PN/lvm/LVM}.${PV}"

inherit eutils
src_unpack() {
	unpack ${A}
	cd ${S} || die
	#epatch ${FILESDIR}/lvm2-2.02.04-vgid.patch
}

src_compile() {
	# Static compile of lvm2 so that the install described in the handbook works
	# http://www.gentoo.org/doc/en/lvm2.xml
	# fixes http://bugs.gentoo.org/show_bug.cgi?id=84463
	local myconf

	if ! use nolvmstatic
	then
		myconf="${myconf} --enable-static_link"
		use nosnapshots || myconf="${myconf} --with-snapshots=internal"
		use nomirrors || myconf="${myconf} --with-mirrors=internal"
		if use nolvm1
		then
			myconf="${myconf} --with-lvm1=none"
		else
			myconf="${myconf} --with-lvm1=internal"
		fi
	else
		use nosnapshots || myconf="${myconf} --with-snapshots=shared"
		use nomirrors || myconf="${myconf} --with-mirrors=shared"
		if use nolvm1
		then
			myconf="${myconf} --with-lvm1=none"
		else
			myconf="${myconf} --with-lvm1=shared"
		fi
	fi

	# disable O_DIRECT support on hppa, breaks pv detection (#99532)
	use hppa && myconf="${myconf} --disable-o_direct"

	if use clvm; then
		if use nolvmstatic
		then
			myconf="${myconf} --with-cluster=shared"
		else
			myconf="${myconf} --with-cluster=internal"
		fi
		if useq cman && useq gulm; then
			myconf="${myconf} --with-clvmd=all"
		fi
		if useq cman && ! useq gulm; then
			myconf="${myconf} --with-clvmd=cman"
		fi
		if useq gulm && ! useq cman; then
			myconf="${myconf} --with-clvmd=gulm"
		fi
		if ! useq gulm && ! useq cman; then
			myconf="${myconf} --with-clvmd=none"
		fi
	fi

	econf $(use_enable readline) $(use_enable selinux) ${myconf} || die
	emake || die "compile problem"
}

src_install() {
	einstall sbindir="${D}/sbin" staticdir="${D}/sbin" confdir="${D}/etc/lvm"
	mv -f "${D}/sbin/lvm.static" "${D}/sbin/lvm"

	dodoc COPYING* INSTALL README VERSION WHATS_NEW doc/*.{conf,c,txt}
	insinto /lib/rcscripts/addons
	newins ${FILESDIR}/lvm2-start.sh lvm-start.sh || die
	newins ${FILESDIR}/lvm2-stop.sh lvm-stop.sh || die
	if use clvm; then
		newinitd ${FILESDIR}/clvmd.rc clvmd || die
	fi

	ewarn "use flag nocman is deprecated and replaced"
	ewarn "with cman and gulm use flags."
	ewarn ""
	ewarn "use flags clvm,cman and gulm are masked"
	ewarn "by default and need to be unmasked to use them"
	ewarn ""
	ewarn "Rebuild your genkernel initramfs if you are using lvm"
}
