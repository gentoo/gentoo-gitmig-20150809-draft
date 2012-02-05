# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/grun/grun-0.9.2-r1.ebuild,v 1.9 2012/02/05 17:53:48 armin76 Exp $

EAPI=2

WANT_AUTOMAKE="1.9"

PATCH_LEVEL=14.1

inherit autotools eutils

DESCRIPTION="a GTK+ application launcher with nice features such as a history"
HOMEPAGE="http://packages.qa.debian.org/g/grun.html"
SRC_URI="mirror://debian/pool/main/g/grun/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/g/grun/${PN}_${PV}-${PATCH_LEVEL}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE="nls"

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${WORKDIR}"/${PN}_${PV}-${PATCH_LEVEL}.diff
	eautoreconf
}

src_configure() {
	[[ -z ${TERM} ]] && TERM=xterm

	econf $(use_enable nls) --disable-gtktest --enable-testfile \
		--enable-associations --with-default-xterm=${TERM}
}

src_compile() {
	emake || die "emake failed."
}

src_install() {
	einstall || die "einstall failed."
	dodoc AUTHORS BUGS ChangeLog LANGUAGES NEWS README TODO
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
	elog "extensions with applications is /usr/share/grun/gassoc, the"
	elog "default system-wide definition file for recognized console"
	elog "applications is /usr/share/grun/consfile. They can be overridden"
	elog "on a per user basis by ~/.gassoc and ~/.consfile respectively."
	elog
	elog "To change the default terminal application grun uses, adjust the"
	elog "TERM environment variable accordingly and remerge grun, e.g."
	elog
	elog "TERM=Eterm emerge grun"
}
