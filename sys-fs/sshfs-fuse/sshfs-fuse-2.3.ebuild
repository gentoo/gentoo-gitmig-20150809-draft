# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/sshfs-fuse/sshfs-fuse-2.3.ebuild,v 1.1 2011/07/14 18:52:34 radhermit Exp $

EAPI="4"

DESCRIPTION="Fuse-filesystem utilizing the sftp service."
SRC_URI="mirror://sourceforge/fuse/${P}.tar.gz"
HOMEPAGE="http://fuse.sourceforge.net/sshfs.html"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
SLOT="0"
IUSE=""

DEPEND=">=sys-fs/fuse-2.6.0_pre3
	>=dev-libs/glib-2.4.2"
RDEPEND="${DEPEND}
	>=net-misc/openssh-4.3"

DOCS=( README NEWS ChangeLog AUTHORS FAQ.txt )

src_configure() {
	# hack not needed with >=net-misc/openssh-4.3
	econf --disable-sshnodelay
}
