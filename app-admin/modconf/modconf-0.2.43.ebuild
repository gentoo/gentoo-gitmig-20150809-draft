# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/modconf/modconf-0.2.43.ebuild,v 1.1 2003/03/09 20:43:50 azarah Exp $

# Some notes:  This should rather depend on dev-libs/newt, and use whiptail,
#              not dev-util/dialog.
#
#              I could not get it to edit module options, but mostly because I
#              have 2.5 on this box, and a limited 2.4 on my gateway, so it
#              "should" work, but is not really tested.

inherit eutils

IUSE=""

S="${WORKDIR}/${P}"
DESCRIPTION="Modconf provides a GUI for installing and configuring device driver modules."
SRC_URI="http://ftp.debian.org/debian/pool/main/m/modconf/${P/-/_}.tar.gz"
HOMEPAGE="http://packages.debian.org/stable/base/modconf.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="dev-util/dialog
	sys-apps/modutils"
#	dev-libs/newt

pkg_setup() {
	check_KV
}

src_unpack() {
	unpack ${A}

	cd ${S}; epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}

