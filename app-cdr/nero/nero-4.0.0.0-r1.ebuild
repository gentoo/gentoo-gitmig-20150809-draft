# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/nero/nero-4.0.0.0-r1.ebuild,v 1.1 2010/03/23 21:35:07 beandog Exp $

EAPI=2
inherit eutils fdo-mime rpm multilib gnome2-utils linux-mod

DESCRIPTION="Nero Burning ROM for Linux"
HOMEPAGE="http://nerolinux.nero.com"
SRC_URI="x86? ( mirror://${PN}/${PN}linux-${PV}-x86.rpm )
	amd64? ( mirror://${PN}/${PN}linux-${PV}-x86_64.rpm )"

LICENSE="Nero-EULA-US"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="x11-libs/libXinerama
	x11-libs/libX11
	x11-libs/pango[X]
	>=x11-libs/gtk+-2:2"
DEPEND=""

PROPERTIES="interactive"
RESTRICT="strip mirror test"
CONFIG_CHECK="~CHR_DEV_SG"
QA_TEXTRELS="opt/nero/$(get_libdir)/nero/*"
QA_EXECSTACK="opt/nero/$(get_libdir)/nero/*"
S="${WORKDIR}"

pkg_setup() {
	check_license
}

src_install() {
	insinto /etc
	doins -r etc/nero || die "doins failed"

	insinto /opt/nero
	doins -r usr/$(get_libdir) || die "doins failed"
	dosym /opt/nero/$(get_libdir)/nero /usr/$(get_libdir)/nero || die "dosym failed"

	exeinto /opt/nero
	doexe usr/bin/nero* || die "doexe failed"

	insinto /usr/share
	doins -r usr/share/nero usr/share/locale usr/share/icons || die "doins failed"

	domenu usr/share/applications/nerolinux.desktop
	doicon usr/share/pixmaps/nerolinux.xpm
	dodoc usr/share/doc/nero/NEWS
	doman usr/share/man/man1/*
	use doc && dodoc usr/share/doc/nero/*.pdf

	make_wrapper nero ./nero /opt/nero /opt/${PN}/$(get_libdir)
	make_wrapper nerocmd ./nerocmd /opt/nero /opt/nero/$(get_libdir)
	make_wrapper neroexpress ./neroexpress /opt/nero /opt/nero/$(get_libdir)

	# This is a ugly hack to fix burning in x86_64.
	# http://club.cdfreaks.com/showthread.php?t=218041
	use amd64 && cp usr/share/nero/Nero*.txt "${D}"/opt/nero/$(get_libdir)/nero
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	nero --perform-post-installation

	elog "Technical support for NeroLINUX is provided by CDFreaks"
	elog "Linux forum at http://club.cdfreaks.com/forumdisplay.php?f=104"
	elog
	elog "You also need to setup your user to cdrom group."
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
