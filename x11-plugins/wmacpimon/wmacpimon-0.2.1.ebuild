# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmacpimon/wmacpimon-0.2.1.ebuild,v 1.8 2008/12/02 11:29:52 s4t4n Exp $

inherit eutils

DESCRIPTION="WMaker DockApp that monitors the temperature and Speedstep features in new ACPI-based systems."
HOMEPAGE="http://www.vrlteam.org/wmacpimon/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto"

src_unpack() {
	unpack ${A}

	# patch wmacpimon.c file to set default path for
	# wmacpimon.prc to /var/tmp/
	cd "${S}"
	epatch "${FILESDIR}"/wmacpimon.c.patch

	# fix LDFLAGS ordering. See bug #248618.
	epatch "${FILESDIR}"/Makefile.patch
}

src_compile() {
	emake CFLAGS="${CFLAGS} -DACPI -Wall" \
		LDFLAGS="${CFLAGS} -DACPI -lX11 -lXpm -lXext" \
		|| die "emake failed."
}

src_install() {
	dobin wmacpimond wmacpimon || die "dobin failed."
	dodoc AUTHORS ChangeLog README
	newinitd "${FILESDIR}"/wmacpimon.initscript wmacpimon
}

pkg_postinst() {
	elog "Remember to start the wmacpimond daemon"
	elog "(by issuing the \"/etc/init.d/wmacpimon start\" command)"
	elog "before you attempt to run wmacpimon..."
}
