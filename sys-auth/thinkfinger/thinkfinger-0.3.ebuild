# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/thinkfinger/thinkfinger-0.3.ebuild,v 1.1 2007/04/11 16:59:35 chainsaw Exp $

inherit pam linux-info

DESCRIPTION="Support for the UPEK/SGS Thomson Microelectronics fingerprint reader, often seen in Thinkpads"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://thinkfinger.sourceforge.net/"

RDEPEND=">=dev-libs/libusb-0.1.12
	pam? ( virtual/pam )"
DEPEND="${RDEPEND}
	sys-devel/libtool
	>=dev-util/pkgconfig-0.9.0"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug pam"

src_compile() {
	if useq pam; then
		CONFIG_CHECK="INPUT_UINPUT"
		ERROR_CFG="Your kernel needs uinput for the pam module to work"
		check_extra_config
	fi
	econf \
		$(use_enable pam) \
		$(use_enable debug usb-debug) \
		"--with-securedir=$(getpam_mod_dir)" \
		|| die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	keepdir /etc/pam_thinkfinger
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	elog "Use tf-tool --acquire to take a finger print"
	elog "tf-tool will write the finger print file to /tmp/test.bir"
	elog ""
	if useq pam ; then
		elog "To add a fingerprint to PAM, use tf-tool --add-user USERNAME"
		elog ""
		elog "Add the following to /etc/pam.d/system-auth after pam_env.so"
		elog "auth     sufficient     pam_thinkfinger.so"
		elog ""
		elog "Your system-auth should look similar to:"
		elog "auth     required     pam_env.so"
		elog "auth     sufficient   pam_thinkfinger.so"
		elog "auth     sufficient   pam_unix.so try_first_pass likeauth nullok"
	fi
}
