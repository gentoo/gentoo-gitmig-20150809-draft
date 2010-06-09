# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lessfs/lessfs-1.0.8.ebuild,v 1.1 2010/06/09 21:01:49 hwoarang Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A high performance inline data deduplicating filesystem"
HOMEPAGE="http://www.lessfs.com"
SRC_URI="http://downloads.sourceforge.net/project/${PN}/${PN}/${P}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lzo crypt"

DEPEND=">=dev-db/tokyocabinet-1.4.42
		>=sys-fs/fuse-2.8.0
		crypt? ( dev-libs/openssl )
		lzo? ( dev-libs/lzo )"

RDEPEND=""

src_configure() {
	use crypt && myconf="--with-crypto"
	use lzo && myconf="${myconf} --with-lzo"
	econf ${myconf}
}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog NEWS README || die "dodpc failed"
	insinto /etc
	doins etc/lessfs.cfg

}

pkg_postinst() {
	elog
	elog "Default configuration file: /etc/${PN}.cfg"
	elog
}
