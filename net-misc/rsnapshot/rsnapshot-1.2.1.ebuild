# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rsnapshot/rsnapshot-1.2.1.ebuild,v 1.1 2005/04/11 20:56:42 kloeri Exp $

inherit eutils

DESCRIPTION="rsnapshot is a filesystem backup utility based on rsync."
HOMEPAGE="http://www.rsnapshot.org"
SRC_URI="http://www.rsnapshot.org/downloads/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc alpha ~amd64"
IUSE=""

RDEPEND=">=dev-lang/perl-5.8.2
		>=sys-apps/util-linux-2.12-r4
		>=sys-apps/coreutils-5.0.91-r4
		>=net-misc/openssh-3.7.1_p2-r1
		>=net-misc/rsync-2.6.0"

src_compile() {
	econf \
		--prefix=/usr \
		--sysconfdir=/etc || die

	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
}

pkg_postinst() {
	einfo
	einfo "The configuration file: /etc/rsnapshot.conf.default "
	einfo "  has been installed. "
	einfo "This is a template. "
	einfo "Copy, or move, the above file to: /etc/rsnapshot.conf "
	einfo "Note that upgrading will update the template, not real config. "
	einfo
}
