# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/leafnode/leafnode-2.0.0_alpha20041007.ebuild,v 1.1 2004/10/17 01:58:34 swegener Exp $

MY_P=${P/_/.}a

DESCRIPTION="A USENET software package designed for small sites"
SRC_URI="http://www-dt.e-technik.uni-dortmund.de/~ma/leafnode/beta/${MY_P}.tar.bz2"
HOMEPAGE="http://www-dt.e-technik.uni-dortmund.de/~ma/leafnode/beta/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="ipv6"

DEPEND=">=dev-libs/libpcre-3.9"
RDEPEND="${DEPEND}
	virtual/inetd"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf \
		--sysconfdir=/etc/leafnode \
		--with-runas-user=news \
		--localstatedir=/var \
		--with-spooldir=/var/spool/news \
		$(use_with ipv6) \
		|| die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	# remove the spool dirs -- put them back in during pkg_postinst, so that
	# they don't get removed during an unmerge or upgrade
	rm -rf ${D}/var/spool

	# add .keep file to /var/lock/news to avoid ebuild to ignore the empty dir
	keepdir /var/lock/news
	# ... and keep texpire from complaining about missing dir
	keepdir /etc/leafnode/local.groups

	insinto /etc/xinetd.d
	newins ${FILESDIR}/leafnode.xinetd leafnode-nntp

	exeinto /etc/cron.hourly
	doexe ${FILESDIR}/fetchnews.cron
	exeinto /etc/cron.daily
	doexe ${FILESDIR}/texpire.cron

	dodoc \
		AUTHORS COPYING* CREDITS ChangeLog DEBUGGING ENVIRONMENT FAQ \
		INSTALL NEWS TODO README README_FIRST UPDATING
	dohtml README.html
}

pkg_postinst() {
	dodir ${ROOT}/var/spool/news/{leaf.node,failed.postings,interesting.groups,out.going}
	dodir ${ROOT}/var/spool/news/message.id/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}
	chown -R news:news ${ROOT}/var/spool/news

	zcat ${ROOT}/usr/share/doc/${PF}/README_FIRST.gz | while read line ;
	do
		einfo $line
	done

	einfo
	einfo "DO MAKE SURE THAT YOU RUN texpire -r IF YOU HAVE ARTICLES IN THE SPOOL"
}
