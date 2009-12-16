# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/apcupsd/apcupsd-3.14.7.ebuild,v 1.5 2009/12/16 12:55:41 maekke Exp $

WEBAPP_MANUAL_SLOT="yes"
WEBAPP_OPTIONAL="yes"
inherit eutils webapp linux-info

DESCRIPTION="APC UPS daemon with integrated tcp/ip remote shutdown"
HOMEPAGE="http://www.apcupsd.org/"
SRC_URI="mirror://sourceforge/apcupsd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ~sparc x86 ~x86-fbsd"
IUSE="snmp usb cgi nls gnome kernel_linux"

DEPEND="
	cgi? ( >=media-libs/gd-1.8.4
		${WEBAPP_DEPEND} )
	nls? ( sys-devel/gettext )
	snmp? ( net-analyzer/net-snmp )
	gnome? ( >=x11-libs/gtk+-2.4.0
		>=dev-libs/glib-2.0
		>=gnome-base/gconf-2.0 )"
RDEPEND="${DEPEND}
	virtual/mailx"

pkg_setup() {
	use cgi && webapp_pkg_setup

	if use kernel_linux &&
		use usb &&
		linux_config_exists &&
		!linux_chkconfig_present USB_HIDDEV; then
		ewarn "Note: to be able to use the USB support for ${PN} you're going to need"
		ewarn "the CONFIG_USB_HIDDEV option enabled in your kernel."
		ewarn "The option hasn't been found enabled, do so before trying to use"
		ewarn "${PN} with USB UPSes."
	fi
}

src_compile() {
	local myconf
	use cgi && myconf="${myconf} --enable-cgi --with-cgi-bin=${MY_CGIBINDIR}"
	if use usb; then
		myconf="${myconf} --with-upstype=usb --with-upscable=usb --enable-usb --with-dev= "
	else
		myconf="${myconf} --with-upstype=apcsmart --with-upscable=smart --disable-usb"
	fi

	# We force the DISTNAME to gentoo so it will use gentoo's layout also
	# when installed on non-linux systems.
	econf \
		--sbindir=/sbin \
		--sysconfdir=/etc/apcupsd \
		--with-pwrfail-dir=/etc/apcupsd \
		--with-lock-dir=/var/lock \
		--with-pid-dir=/var/run \
		--with-log-dir=/var/log \
		--with-nis-port=3551 \
		--enable-net --enable-pcnet \
		--with-distname=gentoo \
		$(use_enable snmp net-snmp) \
		$(use_enable gnome gapcmon) \
		${myconf} \
		APCUPSD_MAIL=/bin/mail \
		|| die "econf failed"

	# Workaround for bug #280674; upstream should really just provide
	# the text files in the distribution, but I wouldn't count on them
	# doing that anytime soon.
	MANPAGER=$(type -p cat) \
		emake || die "emake failed"
}

src_install() {
	use cgi && webapp_src_preinst

	emake DESTDIR="${D}" install || die "installed failed"
	rm -f "${D}"/etc/init.d/halt

	insinto /etc/apcupsd
	newins examples/safe.apccontrol safe.apccontrol

	dodoc ChangeLog* ReleaseNotes
	doman doc/*.8 doc/*.5 || die "doman failed"

	dohtml -r doc/manual/* || die "dodoc failed"

	use cgi && webapp_src_install

	rm "${D}"/etc/init.d/apcupsd
	newinitd "${FILESDIR}/${PN}.init.2" "${PN}" || die "newinitd failed"

	if has_version sys-apps/openrc; then
		newinitd "${FILESDIR}/${PN}.powerfail.init" "${PN}".powerfail || die "newinitd failed"
	fi

	# Without this it'll crash at startup. When merging in ROOT= this
	# won't be created by default, so we want to make sure we got it!
	keepdir /var/lock
	fowners root:uucp /var/lock
	fperms 0775 /var/lock
}

pkg_postinst() {
	if use cgi; then
		elog "If you are upgrading from a previous version, please note"
		elog "that the CGI interface is now installed using webapp-config."
		elog "/var/www/apcupsd is no longer present."
		webapp_pkg_postinst
	fi

	elog ""
	elog "Since version 3.14.0 you can use multiple apcupsd instances to"
	elog "control more than one UPS in a single box."
	elog "To do this, create a link between /etc/init.d/apcupsd to a new"
	elog "/etc/init.d/apcupsd.something, and it will then load the"
	elog "configuration file at /etc/apcupsd/something.conf."
	elog ""

	if [ -d "${ROOT}"/etc/runlevels/shutdown -a \
			! -e "${ROOT}"/etc/runlevels/shutdown/"${PN}".powerfail ] ; then
		elog 'If you want apcupsd to power off your UPS when it'
		elog 'shuts down your system in a power failure, you must'
		elog 'add apcupsd.powerfail to your shutdown runlevel:'
		elog ''
		elog ' \e[01m rc-update add apcupsd.powerfail shutdown \e[0m'
		elog ''
	fi
}

pkg_prerm() {
	use cgi && webapp_pkg_prerm
}
