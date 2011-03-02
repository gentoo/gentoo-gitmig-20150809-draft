# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/grun/grun-0.9.3-r1.ebuild,v 1.3 2011/03/02 17:07:49 signals Exp $

EAPI=2
inherit eutils

DESCRIPTION="a GTK+ application launcher with nice features such as a history"
HOMEPAGE="http://code.google.com/p/grun/"
SRC_URI="http://grun.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="nls"

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-no_nls.patch
}

src_configure() {
	[[ -z ${TERM} ]] && TERM=xterm

	econf \
		$(use_enable nls) \
		--disable-gtktest \
		--enable-testfile \
		--enable-associations \
		--with-default-xterm=${TERM}
}

src_install() {
	einstall || die
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
}

pkg_postinst() {
	elog "It is recommended to bind grun to a keychain. Fluxbox users can"
	elog "do this by appending e.g. the following line to ~/.fluxbox/keys:"
	elog
	elog "Mod4 r :ExecCommand grun"
	elog
	elog "Then reconfigure Fluxbox (using the menu) and hit <WinKey>-<r>"
	elog
	elog "The default system-wide definition file for associating file"
	elog "extensions with applications is /etc/gassoc, the default"
	elog "system-wide definition file for recognized console"
	elog "applications is /etc/consfile. They can be overridden"
	elog "on a per user basis by ~/.gassoc and ~/.consfile respectively."
	elog
	elog "To change the default terminal application grun uses, adjust the"
	elog "TERM environment variable accordingly and remerge grun, e.g."
	elog
	elog "TERM=Eterm emerge grun"
}
