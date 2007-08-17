# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/ies4linux/ies4linux-2.5_beta6.ebuild,v 1.3 2007/08/17 21:09:11 rbu Exp $

inherit eutils versionator

MY_PV="$(replace_version_separator 2 '')"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Installer for Microsoft Internet Explorer"
HOMEPAGE="http://www.ies4linux.org/"
SRC_URI="http://www.ies4linux.org/downloads/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk kde"

DEPEND=">=app-arch/cabextract-1.0
		>=app-emulation/wine-0.9.0"

RDEPEND="${DEPEND}
		gtk? ( dev-python/pygtk
		>=dev-lang/python-2.4 )
		kde? ( || ( kde-base/kommander kde-base/kdewebdev ) )"

S="${WORKDIR}/${MY_P}"

src_unpack() {

	unpack "${A}"
	cd "${S}"

	epatch "${FILESDIR}/${P}-Installation_directory_discovery.patch" || die "epatch failed"
}

src_install() {

	INS_BASE_PATH="/usr/lib/${PN}"

	# Main executable script

	insinto "${INS_BASE_PATH}"

	insopts -m0755
	doins "${PN}" || die "doins failed"

	dosym "${INS_BASE_PATH}/${PN}" "/usr/bin/${PN}" || die "dosym failed"

	# Main libraries

	insinto "${INS_BASE_PATH}/lib"

	insopts -m0644
	( doins "lib/files"     &&
	  doins "lib/${PN}.svg" &&
	  doins "lib/messages.txt"
	) || die "doins failed"

	insopts -m0755
	( doins "lib/"*.sh             &&
	  doins "lib/xdg-desktop-icon" &&
	  doins "lib/xdg-desktop-menu"
	) || die "doins failed"

	# Localization libraries

	insinto "${INS_BASE_PATH}/lang"

	insopts -m0644
	doins "lang/"*.sh || die "doins failed"

	# Windows registry files

	insinto "${INS_BASE_PATH}/winereg"

	insopts -m0644
	doins "winereg/"*.reg || die "doins failed"

	# Graphical installers

	insopts -m0644

	insinto "${INS_BASE_PATH}/ui/kommander"
	( doins "ui/kommander/"*.kmdr &&
	  doins "ui/kommander/"*.sh
	) || die "doins failed"

	insinto "${INS_BASE_PATH}/ui/pygtk"
	( doins "ui/pygtk/"*.py &&
	  doins "ui/pygtk/"*.sh
	) || die "doins failed"

	# Documentation

	dodoc "README" || die "dodoc failed"
}

pkg_postinst() {

	elog
	elog "IEs4Linux is an installer for Microsoft Internet Explorer."
	elog "You just emerged the installer, you now have to run \`${PN}\`,"
	elog "as a normal user, to actually install Microsoft Internet Explorer."
	elog

	use gtk && (
		elog "To use the PyGTK installer interface, start IEs4Linux"
		elog "with the \"--gui gtk\" option."
		elog
	)

	use kde && (
		elog "To use the KDE Kommander installer interface, start IEs4Linux"
		elog "with the \"--gui kommander\" option."
		elog
	)

	elog "Do note that, while IEs4Linux itself, is licensed under the GPL-2,"
	elog "it is only an installer for Microsoft Internet Explorer. You must own"
	elog "a Microsoft Windows license, and agree to the Internet Explorer license,"
	elog "to install any version of Microsoft Internet Explorer."
	elog
}
