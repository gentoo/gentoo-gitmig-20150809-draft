# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/speedfreq/speedfreq-0.7.2-r1.ebuild,v 1.1 2004/03/28 08:33:34 vapier Exp $

inherit eutils

DESCRIPTION="daemon to control the CPU speed in 2.6 kernels"
HOMEPAGE="http://www.goop.org/~jeremy/speedfreq/"
SRC_URI="http://www.goop.org/~jeremy/speedfreq/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="acpi"

DEPEND="!ppc? ( acpi? ( sys-apps/acpid ) )"

is_2_6_kernel() {
	local KV_major="$(echo "${KV}" | cut -d. -f1)"
	local KV_minor="$(echo "${KV}" | cut -d. -f2)"
	[ "${KV_major}" -eq 2 -a "${KV_minor}" -eq 6 ] \
		&& return 0 \
		|| return 1
}

pkg_setup() {
	check_KV
	if [ ! is_2_6_kernel ] ; then
		eerror "This only works with 2.6.x kernels"
		die "Only works with 2.6.x kernels, not ${KV}"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-python-ver.patch
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "compile of speedfreq failed"
}

src_install() {
	make \
		PREFIX=${D}/usr \
		INITD=${T} \
		install \
		|| die "make install failed"
	exeinto /etc/init.d ; newexe ${FILESDIR}/speedfreq.rc speedfreq
	insinto /etc/conf.d ; newins ${FILESDIR}/speedfreq.conf speedfreq
	dodoc README
	if use acpi ; then
		exeinto /etc/acpi
		doexe ${FILESDIR}/battery.sh
	fi
}

pkg_postinst() {
	if use acpi ; then
		echo
		einfo "A sample script for powercontrol has been placed in /etc/acpi/battery.sh"
		einfo "To use it add the following lines to your /etc/acpi/default/events"
		einfo " event=battery.*"
		einfo " action=/etc/acpi/battery.sh %e"
		einfo "Note that this only supports one battery at the time"
		echo
		einfo "Configuration should be done in /etc/conf.d/speedfreq"
		einfo "Make sure that you have sysfs mounted on /sys"
		echo
	fi
}
