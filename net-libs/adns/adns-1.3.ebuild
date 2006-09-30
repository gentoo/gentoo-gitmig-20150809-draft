# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/adns/adns-1.3.ebuild,v 1.1 2006/09/30 01:46:50 sbriesen Exp $

inherit eutils multilib

DESCRIPTION="Advanced, easy to use, asynchronous-capable DNS client library and utilities"
HOMEPAGE="http://www.chiark.greenend.org.uk/~ian/adns/"
SRC_URI="ftp://ftp.chiark.greenend.org.uk/users/ian/adns/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~ia64 ~amd64 ~ppc64"
IUSE=""

DEPEND="virtual/libc"
RDEPEND=""

src_install () {
	dodir /usr/{include,bin,$(get_libdir)}
	make prefix=${D}/usr lib_dir=${D}/usr/$(get_libdir) install || die
	dodoc README TODO changelog
	dohtml *.html
}
