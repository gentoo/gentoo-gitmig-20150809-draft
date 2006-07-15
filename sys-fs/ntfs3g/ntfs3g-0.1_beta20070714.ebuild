# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ntfs3g/ntfs3g-0.1_beta20070714.ebuild,v 1.2 2006/07/15 19:06:50 chutzpah Exp $

DESCRIPTION="Open source read-write NTFS driver that runs under FUSE"
HOMEPAGE="http://sourceforge.net/mailarchive/forum.php?thread_id=23836054&forum_id=2697"
SRC_URI="http://mlf.linux.rulez.org/mlf/ezaz/ntfs-3g-20070714-BETA.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=sys-fs/fuse-2.5.0
	!sys-fs/ntfsprogs"
RDEPEND="${DEPEND}"

MY_P="${PN/3g/-3g}"
MY_PV="${PV#0.1_beta}"
MY_PV="${MY_PV}-BETA"

S="${WORKDIR}/${MY_P}-${MY_PV}"

src_compile() {
	econf
	emake
}

src_install() {
	make DESTDIR="${D}" install
}
