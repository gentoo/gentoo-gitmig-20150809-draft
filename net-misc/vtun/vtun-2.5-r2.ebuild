# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vtun/vtun-2.5-r2.ebuild,v 1.9 2004/01/22 23:39:00 zul Exp $

IUSE="ssl"

DESCRIPTION="Tunneling software to use the universal tunnel"
HOMEPAGE="http://vtun.sourceforge.net"
KEYWORDS="x86 sparc alpha"
LICENSE="GPL-2"
SLOT="0"
DEPEND=">=sys-libs/zlib-1.1.4
	>=dev-libs/lzo-1.07
	ssl? ( >=dev-libs/openssl-0.9.6c-r1 )
	>=sys-kernel/linux-headers-2.4.18"
#RDEPEND=""
SRC_URI="mirror://sourceforge/vtun/${P}.tar.gz"
S=${WORKDIR}/vtun

src_compile() {
	if [ -z "`use ssl`" ]
	then
		use_opts="--disable-ssl"
	fi

	cat ${FILESDIR}/vtun-2.5-r2-gentoo-gcc3.1.patch | patch -p1 || die "couldn't patch for gcc3.1";

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		$use_opts || die "./configure failed"
	mv config.h config.h.orig
	mv cfg_file.y cfg_file.y.orig
	sed "s,/* #undef HAVE_LINUX_IF_TUN_H */,#define HAVE_LINUX_IF_TUN_H 1," \
		config.h.orig >config.h
	sed "s,expect 18,expect 20," \
		cfg_file.y.orig >cfg_file.y

	# Rename this, because its from cyrus, we want the openssl one.
	if [ -f /usr/include/md5.h ]; then
	    mv /usr/include/md5.h /usr/include/md5.h.vtun_compile
	fi

	# If this doesnt work, we only remember that we failed, so
	# we always rename the /etc/include/md5.h file back.
	emake \
		ETC_DIR=/etc \
		VAR_DIR=/var || FAILED=1

	# OK, we're done, rename the cyrus one back to what it was.
	if [ -f /usr/include/md5.h.vtun_compile -a
		! -f /usr/include/md5.h ]; then
	    mv /usr/include/md5.h.vtun_compile /usr/include/md5.h
	fi
	if [ 0$FAILED -ne 0 ]; then
	    die
	fi
}

src_install () {
	make \
		prefix=${D}/usr \
		ETC_DIR=${D}/etc \
		VAR_DIR=${D}/var \
		INFO_DIR=${D}/usr/share/info \
		MAN_DIR=${D}/usr/share/man install || die

	dodoc ChangeLog Credits FAQ README* TODO vtund.conf

	exeinto etc/init.d;
	newexe ${FILESDIR}/vtun.rc vtun

	insinto etc
	doins ${FILESDIR}/vtund-start.conf
}
