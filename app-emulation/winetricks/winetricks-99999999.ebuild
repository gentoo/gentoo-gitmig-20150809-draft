# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/winetricks/winetricks-99999999.ebuild,v 1.1 2011/07/05 21:29:44 vapier Exp $

EAPI="2"

if [[ ${PV} == "99999999" ]] ; then
	ESVN_REPO_URI="http://winetricks.googlecode.com/svn/trunk"
	inherit subversion
else
	SRC_URI="http://winetricks.googlecode.com/svn-history/r${PV}/trunk/src/winetricks -> ${P}
		http://winetricks.googlecode.com/svn-history/r${PV}/trunk/src/winetricks.1 -> ${P}.1"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="easy way to install DLLs needed to work around problems in Wine"
HOMEPAGE="http://code.google.com/p/winetricks/ http://wiki.winehq.org/winetricks"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="gtk kde"

DEPEND=""
RDEPEND="app-emulation/wine
	gtk? ( gnome-extra/zenity )
	kde? ( kde-base/kdialog )"

src_unpack() {
	if [[ ${PV} == "99999999" ]] ; then
		subversion_src_unpack
	else
		mkdir src
		cp "${DISTDIR}"/${P} src/${PN} || die
		cp "${DISTDIR}"/${P}.1 src/${PN}.1 || die
	fi
}

src_install() {
	cd src
	dobin ${PN} || die
	doman ${PN}.1 || die
}
