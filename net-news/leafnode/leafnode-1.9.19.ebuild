# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-news/leafnode/leafnode-1.9.19.ebuild,v 1.1 2002/02/25 03:25:03 chouser Exp $

S=${WORKDIR}/${P}
DESCRIPTION="leafnode - A USENET software package designed for small sites"
SRC_URI="ftp://wpxx02.toxi.uni-wuerzburg.de/pub/${P}.tar.gz"
HOMEPAGE="http://www.leafnode.org"

# leafnode uses pcre
DEPEND=">=dev-libs/libpcre-3.5"
#RDEPEND=""

src_compile() {
	use ipv6 && myconf=--with-ipv6

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--sysconfdir=/etc \
		$myconf || die "./configure failed"

	emake DEBUG="$CFLAGS" || die "emake failed"
}

src_install() {
	make INSTALLROOT=${D} install || die "make install failed"

	# remove the spool dirs -- put them back in during pkg_postinst, so that
	# they don't get removed during an unmerge or upgrade
	rm -rf ${D}/var/spool

	insinto /etc/xinetd.d
	newins ${FILESDIR}/leafnode.xinetd leafnode-nntp
	dodoc COPYING CREDITS ChangeLog FAQ INSTALL README TODO
	docinto doc_german
	dodoc doc_german/*
}

pkg_postinst() {
	mkdir -p /var/spool/news/{leaf.node,failed.postings,interesting.groups,out.going}
	mkdir -p /var/spool/news/message.id/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}
	chown -R news:news /var/spool/news
}
