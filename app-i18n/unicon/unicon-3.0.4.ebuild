# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/unicon/unicon-3.0.4.ebuild,v 1.1 2003/05/25 15:10:52 liquidx Exp $

inherit eutils

# This release was taken from debian sources. For some reason I can't
# find this release on turbolinux's site. Even Mandrake is using the
# older 3.0.3.

# TODO: Figure out how to build the kernel-modules.

DESCRIPTION="CJK (Chinese/Japanese/Korean) console input, display system and input modules."
HOMEPAGE="http://www.gnu.org/directory/UNICON.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/kernel
	dev-libs/newt
	dev-libs/pth"

S=${WORKDIR}/${P}

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd ${S}
	einfo "Applying unicon-3.0.4-debian.patch"
	patch -p1 < ${FILESDIR}/unicon-3.0.4-debian.patch || die "Failed applying debian patch"
	epatch ${FILESDIR}/unicon-3.0.4-gentoo.patch
}

src_compile() {
	econf
	
	make || die "make failed"
	make data || die "make data failed"
	
	cd ${S}/tools
	make || die "make tools failed"
	
	# still has gcc-3.2 issues
	# make -C sfonts/tools || die "make tools failed"
}

src_install() {
	make prefix=${D}/usr install || die "install failed"
	
	# still has gcc-3.2 issues
	# dobin sfonts/tools/sfont
	dobin tools/uniconcfg
	dobin tools/uniconctrl
	
	make prefix=${D}/usr data-install || die "install data failed"
	
	dobin scripts/unicon-start
	
}
