# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udftools/udftools-1.0.0b-r7.ebuild,v 1.4 2007/06/11 13:37:44 gustavoz Exp $

inherit eutils

MY_P="${P}3"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Ben Fennema's tools for packet writing and the UDF filesystem"
HOMEPAGE="http://sourceforge.net/projects/linux-udf/"
SRC_URI="mirror://sourceforge/linux-udf/${MY_P}.tar.gz
	http://w1.894.telia.com/~u89404340/patches/packet/${MY_P}.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# For new kernel packet writing driver
	epatch "${WORKDIR}"/${MY_P}.patch

	# Fix CD blanking for 2.6.8 and newer
	epatch "${FILESDIR}"/cdrwtool-linux2.6-fix-v2.patch

	# gcc4 compat, bug #112122
	epatch "${FILESDIR}"/${P}-gcc4.patch

	# BE fix, bug #120245
	epatch "${FILESDIR}"/${P}-bigendian.patch
}


src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog
	newinitd "${FILESDIR}"/pktcdvd.init pktcdvd
	dosym /usr/bin/udffsck /usr/sbin/fsck.udf
}
