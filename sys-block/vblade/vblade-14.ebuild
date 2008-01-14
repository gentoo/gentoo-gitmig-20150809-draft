# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/vblade/vblade-14.ebuild,v 1.6 2008/01/14 02:14:49 robbat2 Exp $

inherit eutils

DESCRIPTION="vblade exports a block device using AoE"
HOMEPAGE="http://sf.net/projects/aoetools/"
#SRC_URI="mirror://sourceforge/aoetools/${P}.tar.gz"
SRC_URI="mirror://sourceforge/aoetools/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""
DEPEND="virtual/libc"
RDEPEND="${DEPEND}
		sys-apps/util-linux"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# messy tarball
	make clean  || die "Failed to clean up source"
	sed -i 's,^CFLAGS.*,CFLAGS += -Wall,' makefile || die "Failed to clean up makefile"
}
src_compile() {
	emake || die "emake failed"
}

src_install() {
	into /usr
	doman vblade.8
	dodoc HACKING NEWS README
	dosbin vblade
	dosbin "${FILESDIR}"/vbladed
	newconfd "${FILESDIR}"/conf.d-vblade vblade
	newinitd "${FILESDIR}"/init.d-vblade.vblade0-14 vblade.vblade0
}

pkg_postinst() {
	einfo "We do now include an init.d script, please look in your init.d and"
	einfo "conf.d directories for it."
}
