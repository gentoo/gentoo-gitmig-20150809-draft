# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/pureadmin/pureadmin-0.1.11.ebuild,v 1.1 2004/09/17 23:12:48 humpback Exp $

IUSE="debug gnome doc"

DESCRIPTION="PureAdmin is a GUI tool used to make the management of PureFTPd a little easier."
HOMEPAGE="http://purify.sourceforge.net"
SRC_URI="mirror://sourceforge/purify/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="sys-libs/glibc
	sys-libs/zlib
	>=x11-libs/gtk+-2.0"

src_compile() {
	local myconf=""

	use debug && myconf="${myconf} --enable-debug"

	econf ${myconf} || die "configure failed"

	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"

	# Move the docs to the correct location
	if use doc; then
		dodoc ${D}usr/share/doc/pureadmin/*.txt
		rm -rf ${D}usr/share/doc/pureadmin
	fi

	# Add a desktop entry for gnome if requested
	if use gnome; then
		rm ${D}/usr/share/applications
		dodir /usr/share/applications
		insinto /usr/share/applications
		insopts -m 0644
		doins ${S}/tools/pureadmin.desktop
	fi
}

pkg_postinst() {
	echo
	ewarn "PureAdmin is at an alpha-stage right now and it may break"
	ewarn "your configuration. DO NOT use it for safety critical system"
	ewarn "or production use!"
	echo
	einfo "You need root-privileges to be able to use PureAdmin as for now."
	einfo "This will probably change in the future."
	echo
}
