# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/thinkfinger/thinkfinger-0.3-r3.ebuild,v 1.2 2011/08/26 18:25:53 flameeyes Exp $

EAPI=2

inherit eutils linux-info multilib pam

DESCRIPTION="Support for the UPEK/SGS Thomson Microelectronics fingerprint reader, often seen in Thinkpads"
HOMEPAGE="http://thinkfinger.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug pam"

RDEPEND=">=dev-libs/libusb-0.1.12
	pam? ( virtual/pam )"
DEPEND="${RDEPEND}
	sys-devel/libtool
	>=dev-util/pkgconfig-0.9.0"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-direct_set_config_usb_hello.patch || die
	epatch "${FILESDIR}"/${PV}-carriagereturn.patch || die
	epatch "${FILESDIR}"/${PV}-send-sync-event.patch || die
	epatch "${FILESDIR}"/${PV}-tftoolgroup.patch || die
}

pkg_preinst() {
	enewgroup fingerprint
}

pkg_setup() {
	if use pam ; then
		CONFIG_CHECK="~INPUT_UINPUT"
		ERROR_CFG="Your kernel needs uinput for the pam module to work"
		check_extra_config
	fi
}

src_configure() {
	econf \
		$(use_enable pam) \
		$(use_enable debug usb-debug) \
		"--with-securedir=$(getpam_mod_dir)" \
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die
	keepdir /etc/pam_thinkfinger
	dodoc AUTHORS ChangeLog NEWS README || die
	insinto /$(get_libdir)/udev/rules.d
	doins "${FILESDIR}"/60-thinkfinger.rules || die
}

pkg_postinst() {
	fowners root:fingerprint /etc/pam_thinkfinger
	fperms 710 /etc/pam_thinkfinger
	elog "Use tf-tool --acquire to take a finger print"
	elog "tf-tool will write the finger print file to /tmp/test.bir"
	elog ""
	if use pam ; then
		elog "To add a fingerprint to PAM, use tf-tool --add-user USERNAME"
		elog ""
		elog "Add the following to /etc/pam.d/system-auth after pam_env.so"
		elog "auth     sufficient     pam_thinkfinger.so"
		elog ""
		elog "Your system-auth should look similar to:"
		elog "auth     required     pam_env.so"
		elog "auth     sufficient   pam_thinkfinger.so"
		elog "auth     sufficient   pam_unix.so try_first_pass likeauth nullok"
		elog ""
	fi
}
