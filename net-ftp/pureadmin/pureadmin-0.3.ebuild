# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/pureadmin/pureadmin-0.3.ebuild,v 1.2 2006/10/23 15:58:20 chtekk Exp $

inherit eutils

KEYWORDS="~amd64 ~ppc ~x86"

DESCRIPTION="PureAdmin is a GUI tool used to make the management of Pure-FTPd a little easier."
HOMEPAGE="http://purify.sourceforge.net/"
SRC_URI="mirror://sourceforge/purify/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

IUSE="debug doc"

RDEPEND=">=gnome-base/libglade-2.0
		sys-libs/zlib
		virtual/fam
		>=x11-libs/gtk+-2.0"

DEPEND="${RDEPEND}
		dev-util/pkgconfig"

src_compile() {
	local myconf=""

	use debug && myconf="${myconf} --enable-debug"

	econf ${myconf} || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# Move the docs to the correct location, if we want the docs
	if use doc ; then
		dodoc "${D}/usr/share/doc/pureadmin/*.txt"
	fi
	rm -Rf "${D}/usr/share/doc/pureadmin"

	make_desktop_entry pureadmin "Pure-FTPd menu config" pureadmin
}

pkg_postinst() {
	einfo
	ewarn "PureAdmin is at a beta-stage right now and it may break your"
	ewarn "configuration. DO NOT use it for safety critical system"
	ewarn "or production use!"
	einfo
	einfo "You need root-privileges to be able to use PureAdmin."
	einfo "This will probably change in the future."
	einfo
}
