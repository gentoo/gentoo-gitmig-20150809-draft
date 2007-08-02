# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/grun/grun-0.9.2.ebuild,v 1.31 2007/08/02 12:50:51 uberlord Exp $

inherit eutils

PATCH_LEVEL="14"
RESTRICT="mirror"

DESCRIPTION="a GTK+ application launcher with nice features such as a history"
HOMEPAGE="http://packages.debian.org/unstable/x11/grun.html"
SRC_URI="mirror://debian/pool/main/g/grun/${PN}_${PV}.orig.tar.gz
		mirror://debian/pool/main/g/grun/${PN}_${PV}-${PATCH_LEVEL}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86 ~x86-fbsd"
IUSE="nls"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	sys-devel/gnuconfig
	sys-devel/automake"

src_unpack() {
	unpack ${A}
	epatch ${WORKDIR}/${PN}_${PV}-${PATCH_LEVEL}.diff
}

src_compile() {
	local myconf

	use nls && myconf="--enable-nls" || myconf="--disable-nls"

	if [ -z ${TERM} ] ; then
		TERM=xterm
	fi

	ebegin "Running automake"
		automake --add-missing &>/dev/null
	eend $?

	econf \
		--enable-testfile \
		--with-default-xterm=${TERM} \
		--enable-associations \
		${myconf}
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
	elog "export TERM=Eterm && emerge grun"
}
