# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/adns/adns-1.3.ebuild,v 1.4 2006/12/10 01:29:52 drizzt Exp $

inherit eutils multilib

DESCRIPTION="Advanced, easy to use, asynchronous-capable DNS client library and utilities"
HOMEPAGE="http://www.chiark.greenend.org.uk/~ian/adns/"
SRC_URI="ftp://ftp.chiark.greenend.org.uk/users/ian/adns/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="virtual/libc"
RDEPEND=""

src_install () {
	dodir /usr/{include,bin,$(get_libdir)}
	make prefix="${D}"/usr libdir="${D}"/usr/$(get_libdir) install || die
	dodoc README TODO changelog
	dohtml *.html
}
