# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/inputd/inputd-0.0.1.ebuild,v 1.1 2006/08/11 22:30:51 killerfox Exp $

DESCRIPTION="inputd is a user-space daemon to emulate key presses trough other
key combinations"
HOMEPAGE="http://hansmi.ch/software/inputd"
SRC_URI="http://hansmi.ch/download/inputd/inputd-0.0.1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"
IUSE=""

DEPEND=">=dev-libs/glib-2.6
	>=sys-kernel/linux-headers-2.6.16"
RDEPEND="sys-fs/udev"

src_compile() {
	econf || die 'configure failed.'

	emake || die 'make failed'
}

src_install() {
	einstall || die 'installation failed.'

	newinitd ${FILESDIR}/inputd.init inputd
}

