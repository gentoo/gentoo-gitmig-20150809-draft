# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/nero/nero-3.0.1.3.ebuild,v 1.2 2007/08/12 18:33:43 drac Exp $

inherit eutils fdo-mime rpm multilib

DESCRIPTION="Nero Burning ROM for Linux"
HOMEPAGE="http://nerolinux.nero.com"
SRC_URI="x86? ( mirror://${PN}/${PN}linux-${PV}-x86.rpm )
	amd64? ( mirror://${PN}/${PN}linux-${PV}-x86_64.rpm )"

LICENSE="Nero"
SLOT="0"
# This package can never enter stable, it can't be mirrored and upstream
# can remove the distfiles from their mirror anytime. -drac
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="x11-libs/libX11
	>=x11-libs/gtk+-2"
DEPEND=""

RESTRICT="strip mirror test"

# Attempt to shut up QA notices for binary package.
QA_TEXTRELS="opt/nero/$(get_libdir)/nero/plug-ins/libOggVorbis.so
	opt/nero/$(get_libdir)/nero/plug-ins/libMP3.so
	opt/nero/$(get_libdir)/nero/plug-ins/libDefConvertor.so
	opt/nero/$(get_libdir)/nero/plug-ins/libFLAC.so"
QA_EXECSTACK="opt/nero/$(get_libdir)/nero/plug-ins/libFLAC.so
	opt/nero/$(get_libdir)/nero/plug-ins/libMP3.so"

S="${WORKDIR}"

src_compile() {
	echo "Nothing to compile."
}

src_install() {
	insinto /etc
	doins -r etc/${PN}

	insinto /opt/${PN}
	doins -r usr/$(get_libdir)
	dosym /opt/nero/$(get_libdir)/nero /usr/$(get_libdir)/nero

	exeinto /opt/${PN}
	doexe usr/bin/${PN}

	insinto /usr/share
	doins -r usr/share/${PN} usr/share/locale

	domenu usr/share/applications/${PN}linux.desktop
	dodoc usr/share/doc/${PN}/NEWS
	use doc && dodoc usr/share/doc/${PN}/*.pdf

	make_wrapper ${PN} ./${PN} /opt/${PN} /opt/${PN}/$(get_libdir) || die "make_wrapper failed."

	# This is a ugly hack to fix burning in x86_64 which can be removed in future releases.
	# Update: It should have been fixed allready, upstream failed to keep their word.
	# http://club.cdfreaks.com/showthread.php?t=218041
	use amd64 && cp usr/share/${PN}/Nero*.txt "${D}"/opt/${PN}/$(get_libdir)/${PN}
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	elog "NOTE: This is demo software, it will run for a trial"
	elog "period only until unlocked with a serial number."
	elog "See ${HOMEPAGE} for details."
	elog
	elog "Technical support for NeroLINUX is provided by CDFreaks"
	elog "Linux forum at http://club.cdfreaks.com/forumdisplay.php?f=104"
	elog
	elog "Please make sure that no hdX=ide-scsi option is passed to your kernel command line."
	elog
	elog "You also need to setup your user to cdrom group."
	elog
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
