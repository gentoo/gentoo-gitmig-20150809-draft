# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/leafnode/leafnode-1.9.24.ebuild,v 1.1 2002/08/04 01:55:21 blocke Exp $

S=${WORKDIR}/${P}.rel
DESCRIPTION="leafnode - A USENET software package designed for small sites"
SRC_URI="ftp://wpxx02.toxi.uni-wuerzburg.de/pub/${P}.rel.tar.gz"
HOMEPAGE="http://www.leafnode.org"
DEPEND=">=dev-libs/libpcre-3.9"
RDEPEND="$DEPEND"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

src_compile() {
	use ipv6 && myconf="--with-ipv6"

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--sysconfdir=/etc/leafnode \
		--localstatedir=/var \
		${myconf} || die "./configure failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	# remove the spool dirs -- put them back in during pkg_postinst, so that
	# they don't get removed during an unmerge or upgrade
	rm -rf ${D}/var/spool

	# add .keep file to /var/lock/news to avoid ebuild to ignore the empty dir
	touch ${D}/var/lock/news/.keep

	insinto /etc/xinetd.d
	newins ${FILESDIR}/leafnode.xinetd leafnode-nntp

	exeinto /etc/cron.hourly
	doexe ${FILESDIR}/fetchnews.cron
	exeinto /etc/cron.daily
	doexe ${FILESDIR}/texpire.cron

	dodoc COPYING CREDITS ChangeLog FAQ INSTALL README TODO README.FIRST \
		README-MAINTAINER README.FQDN PCRE_README
}

pkg_postinst() {
	mkdir -p /var/spool/news/{leaf.node,failed.postings,interesting.groups,out.going}
	mkdir -p /var/spool/news/message.id/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}
	chown -R news:news /var/spool/news
	cat ${S}/README.FIRST
}
