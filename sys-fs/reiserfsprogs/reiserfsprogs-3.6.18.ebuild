# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/reiserfsprogs/reiserfsprogs-3.6.18.ebuild,v 1.3 2004/09/04 02:37:51 tgall Exp $

inherit flag-o-matic eutils gnuconfig

DESCRIPTION="Reiserfs Utilities"
HOMEPAGE="http://www.namesys.com/"
SRC_URI="http://www.namesys.com/pub/reiserfsprogs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ppc64"
IUSE=""

src_unpack() {
	unpack ${A}
	gnuconfig_update ${S}
}

src_compile() {
	filter-flags -fPIC
	econf --prefix=/ || die "Failed to configure"
	emake || die "Failed to compile"
}

src_install() {
	make DESTDIR="${D}" install || die "Failed to install"
	dosym reiserfsck /sbin/fsck.reiserfs
	dodoc ChangeLog INSTALL README
}
