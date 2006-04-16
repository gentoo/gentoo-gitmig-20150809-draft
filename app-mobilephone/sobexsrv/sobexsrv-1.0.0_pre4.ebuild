# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/sobexsrv/sobexsrv-1.0.0_pre4.ebuild,v 1.2 2006/04/16 04:14:04 joker Exp $

inherit eutils

MY_P="${P/_pre/pre}"

IUSE="gtk"

DESCRIPTION="Scripting/Secure OBEX Server (for BlueZ Linux)"
SRC_URI="http://www.mulliner.org/bluetooth/${MY_P}.tar.gz"
HOMEPAGE="http://www.mulliner.org/bluetooth/sobexsrv.php"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 sparc ~x86"

DEPEND="dev-libs/openobex
	net-wireless/bluez-libs"

RDEPEND="${DEPEND}
	 gtk? ( >=dev-python/pygtk-2.2 )"

S="${WORKDIR}/${MY_P}"


pkg_setup() {
	enewgroup sobexsrv
	enewuser sobexsrv -1 -1 /var/spool/sobexsrv sobexsrv
}

src_unpack() {
	unpack ${A}

	cd "${S}/src"
	sed -e 's/^CFLAGS =/CFLAGS +=/' \
	    -e 's/^CC =/CC ?=/' \
	    -i Makefile
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHOR CHANGELOG CONFIG README SECURITY TODO

	use gtk || rm "${D}/usr/bin/sobexsrv_handler"

	newinitd "${FILESDIR}/init.d_sobexsrv" sobexsrv
	newconfd "${FILESDIR}/conf.d_sobexsrv" sobexsrv

	keepdir /var/spool/sobexsrv
	fowners sobexsrv:sobexsrv /var/spool/sobexsrv
}

pkg_postinst() {
	echo
	einfo "/usr/bin/sobexsrv is *NOT* installed set-uid root by"
	einfo "default. suid is required for the chroot option (-R)."
	echo
	einfo "Execute the following commands to enable suid:"
	echo
	einfo "chown root:sobexsrv /usr/bin/sobexsrv"
	einfo "chmod 2710 /usr/bin/sobexsrv"
	echo
}
