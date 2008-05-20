# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdemud/cdemud-1.0.0.ebuild,v 1.1 2008/05/20 02:24:03 vanquirius Exp $

inherit eutils

DESCRIPTION="Daemon of the cdemu cd image mounting suite"
HOMEPAGE="http://www.cdemu.org"
SRC_URI="mirror://sourceforge/cdemu/cdemu-daemon-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="alsa"

S="${WORKDIR}/cdemu-daemon-${PV}"

DEPEND=">dev-libs/dbus-glib-0.6
	>=dev-libs/libdaemon-0.10
	>=dev-libs/libmirage-1.0.0
	alsa? ( >=media-libs/alsa-lib-1.0.0
	>=media-libs/libsndfile-1.0.0 )
	dev-util/unifdef"
RDEPEND=">dev-libs/dbus-glib-0.6
	>=dev-libs/libdaemon-0.10
	>=dev-libs/libmirage-1.0.0
	alsa? ( >=media-libs/alsa-lib-1.0.0
	>=media-libs/libsndfile-1.0.0 )
	>=sys-fs/vhba-1.0.0"

src_compile() {
	local myconf

	myconf="--sysconfdir=/etc $(use_enable alsa)"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog README TODO
	unifdef "${FILESDIR}/${PN}.conf.d" \
		-$(use alsa && echo D || echo U)ALSA \
		>"${T}/${PN}"
	doconfd "${T}/${PN}"
	unifdef "${FILESDIR}/${PN}.init.d" \
		-$(use alsa && echo D || echo U)ALSA \
		>"${T}/${PN}"
	doinitd "${T}/${PN}"
}

pkg_postinst() {
	elog "Either cdemu group users can start"
	elog "their own daemons or you can start"
	elog "a systembus style daemon, adding"
	elog "${PN} to the default runlevel by"
	elog "	# rc-update add ${PN} default"
	elog "as root. Systembus style daemons can be configured"
	elog "in /etc/conf.d/{PN}.conf"
	echo
}
