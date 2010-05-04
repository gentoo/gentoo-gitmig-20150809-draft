# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/laptop-mode-tools/laptop-mode-tools-1.54.ebuild,v 1.1 2010/05/04 00:25:33 ssuominen Exp $

EAPI=2
inherit eutils

MY_P=${PN}_${PV}

DESCRIPTION="Linux kernel laptop_mode user-space utilities"
HOMEPAGE="http://www.samwel.tk/laptop_mode/"
SRC_URI="http://www.samwel.tk/laptop_mode/tools/downloads/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="acpi apm bluetooth scsi"

DEPEND=""

RDEPEND="sys-apps/ethtool
		acpi? ( >=sys-power/acpid-2.0.4-r2 )
		apm? ( sys-apps/apmd )
		bluetooth? (
			|| (
				net-wireless/bluez
				net-wireless/bluez-utils
			)
		)
		scsi? ( sys-apps/sdparm )
		sys-apps/hdparm"

S=${WORKDIR}/${MY_P}

src_compile() { :; }

src_install() {
	dodir /etc/pm/sleep.d
	DESTDIR="${D}" \
		MAN_D="/usr/share/man" \
		INIT_D="none" \
		APM="$(use apm && echo force || echo disabled)" \
		ACPI="$(use acpi && echo force || echo disabled)" \
		PMU="$(false && echo force || echo disabled)" \
		./install.sh || die

	dodoc Documentation/laptop-mode.txt README || die
	newinitd "${FILESDIR}"/laptop_mode.init-1.4 laptop_mode

	exeinto /etc/pm/power.d
	newexe "${FILESDIR}"/laptop_mode_tools.pmutils laptop_mode_tools

	keepdir /var/run/laptop-mode-tools
}

pkg_postinst() {
	if ! use acpi && ! use apm; then
		ewarn
		ewarn "Without USE=\"acpi\" or USE=\"apm\" ${PN} can not"
		ewarn "automatically disable laptop_mode on low battery."
		ewarn
		ewarn "This means you can lose up to 10 minutes of work if running"
		ewarn "out of battery while laptop_mode is enabled."
		ewarn
		ewarn "Please see /usr/share/doc/${PF}/laptop-mode.txt.gz for further"
		ewarn "information."
		ewarn
	fi
}
