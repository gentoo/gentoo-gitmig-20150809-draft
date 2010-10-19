# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdemud/cdemud-1.3.0.ebuild,v 1.1 2010/10/19 14:32:35 pva Exp $

EAPI="2"

DESCRIPTION="Daemon of the cdemu cd image mounting suite"
HOMEPAGE="http://www.cdemu.org"
SRC_URI="mirror://sourceforge/cdemu/cdemu-daemon-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa pulseaudio"

RDEPEND=">dev-libs/dbus-glib-0.6
	>=dev-libs/libdaemon-0.10
	>=dev-libs/libmirage-1.3.0
	media-libs/libao[alsa?,pulseaudio?]
	>=sys-fs/vhba-20101015
	>=sys-fs/sysfsutils-2.1.0"
DEPEND="${RDEPEND}"

S=${WORKDIR}/cdemu-daemon-${PV}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README || die

	newconfd "${FILESDIR}/${PN}.conf.d-1.1.0" ${PN} || die
	newinitd "${FILESDIR}/${PN}.init.d-1.1.0" ${PN} || die
}

pkg_postinst() {
	elog "Either cdemu group users can start"
	elog "their own daemons or you can start"
	elog "a systembus style daemon, adding"
	elog "${PN} to the default runlevel by"
	elog "	# rc-update add ${PN} default"
	elog "as root. Systembus style daemons can be configured"
	elog "in /etc/conf.d/{PN}"
}
