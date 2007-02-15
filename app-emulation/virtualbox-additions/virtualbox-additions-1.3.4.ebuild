# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

inherit eutils

MY_P=VirtualBox_${PV}_Linux_x86

DESCRIPTION="Guest additions for VirtualBox"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://virtualbox.org/download/${PV}/${MY_P}.run"

LICENSE="PUEL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="!app-emulation/virtualbox-bin"

RESTRICT="primaryuri"

pkg_setup() {
	check_license
}

src_unpack() {
	unpack_makeself ${A}
	unpack ./VirtualBox.tar.bz2
}

src_install() {
	insinto /opt/VirtualBox/additions
	doins "${WORKDIR}"/additions/VBoxGuestAdditions.iso
}
