# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/ies4linux/ies4linux-2.0.5.ebuild,v 1.1 2007/06/21 18:34:07 jurek Exp $

inherit eutils

DESCRIPTION="Script to install Microsoft Internet Explorer under Linux using Wine"
HOMEPAGE="http://www.tatanka.com.br/ies4linux/"
SRC_URI="http://www.tatanka.com.br/${PN}/downloads/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=app-arch/cabextract-1.0 \
		>=app-emulation/wine-0.9.0"

RDEPEND="${DEPEND}"

src_unpack() {

	unpack ${A} || die "unpack failed"

	cd ${S}

	# The upstream maintainer was informed of this patch,
	# so it might be integrated in future versions
	epatch ${FILESDIR}/${P}-Adapt_paths.patch || die "epatch failed"
}

src_install() {

	INS_BASE_PATH="/usr/lib/${PN}"

	#
	# Main executable script
	#

	insinto $INS_BASE_PATH

	insopts -m0755
	doins ${PN} || die "doins failed"
	dosym $INS_BASE_PATH/${PN} /usr/bin/${PN} || die "dosym failed"

	#
	# Main libraries
	#

	insinto $INS_BASE_PATH/lib

	insopts -m0644
	doins lib/*.sh || die "doins failed"

	insopts -m0644
	doins lib/${PN}.svg || die "doins failed"

	#
	# Localization libraries
	#

	insinto $INS_BASE_PATH/lang

	insopts -m0644
	doins lang/*.sh || die "doins failed"

	#
	# Windows registry files
	#

	insinto $INS_BASE_PATH/winereg

	insopts -m0644
	doins winereg/*.reg || die "doins failed"

	#
	# Documentation
	#

	dodoc ${S}/README || die "dodoc failed"
}

pkg_postinst() {

	elog
	elog "IEs 4 Linux is a script to install versions of"
	elog "Microsoft Internet Explorer. You just emerged"
	elog "the script, you now have to run \`${PN}\`,"
	elog "to install IEs interactively."
	elog
	elog "Note that IEs are installed, by default, in your"
	elog "home directory, and that Wine needs write"
	elog "permissions to the installation directory,"
	elog "to be able to run them (meaning you should"
	elog "probably just run \`${PN}\` as the user"
	elog "who will use the IE installations)."
	elog
}

