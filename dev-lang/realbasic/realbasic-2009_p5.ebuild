# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/realbasic/realbasic-2009_p5.ebuild,v 1.1 2010/01/04 19:09:35 patrick Exp $

EAPI=2
inherit eutils portability

MY_P=${PN/real/REAL}${PV/_p/r}

DESCRIPTION="REALbasic is a powerful development tool for Mac, Windows and Linux"
HOMEPAGE="http://www.realsoftware.com/realbasic/"
SRC_URI="http://realsoftware.cachefly.net/${MY_P}/${MY_P}.tgz"

LICENSE="REALbasic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="mirror"

RDEPEND="x86? ( dev-libs/glib:2
	x11-libs/gtk+:2
	x11-libs/cairo
	x11-libs/pango
	x11-libs/libXi
	x11-libs/libXext
	x11-libs/libX11 )
	amd64? ( app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-gtklibs
		app-emulation/emul-linux-x86-xlibs )"
DEPEND=""

QA_PRESTRIPPED="opt/${MY_P}/Resources/Frameworks/LinuxX86Runtime
	opt/${MY_P}/Resources/Frameworks/LinuxX86ConsoleRuntime
	opt/${MY_P}/REALbasic2009
	opt/${MY_P}/Extras/Lingua/Lingua"

QA_DT_HASH="opt/${MY_P}/Resources/Frameworks/LinuxX86Runtime
	opt/${MY_P}/Resources/Frameworks/LinuxX86ConsoleRuntime
	opt/${MY_P}/REALbasic2009
	opt/${MY_P}/Extras/Lingua/Lingua"

S=${WORKDIR}/${MY_P}

src_install() {
	treecopy . "${D}"/opt/${MY_P} || die
	dosym /opt/${MY_P}/REALbasic2009 /opt/bin/realbasic || die
	make_desktop_entry realbasic REALbasic /opt/${MY_P}/realbasic.xpm Development
}
