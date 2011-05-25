# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/xorriso/xorriso-1.0.8.ebuild,v 1.1 2011/05/25 19:54:14 scarabeus Exp $

EAPI=4

DESCRIPTION="ISO 9660 Rock Ridge Filesystem Manipulator"
HOMEPAGE="http://scdbackup.sourceforge.net/xorriso_eng.html"
SRC_URI="http://scdbackup.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="acl bzip2 debug readline threads"

RDEPEND="
	sys-libs/zlib
	acl? ( virtual/acl )
	bzip2? ( app-arch/bzip2 )
"
DEPEND="${RDEPEND}"

src_configure() {
	econf \
		--enable-zlib \
		--enable-xattr \
		$(use_enable acl libacl) \
		$(use_enable bzip2 libbz2) \
		$(use_enable debug) \
		$(use_enable readline libreadline) \
		$(use_enable threads jtethreads)
}
