# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/leafnode/leafnode-2.0.0_alpha20050215.ebuild,v 1.1 2005/02/17 03:44:43 swegener Exp $

inherit flag-o-matic

MY_P=${P/_/.}a

DESCRIPTION="A USENET software package designed for small sites"
SRC_URI="http://www-dt.e-technik.uni-dortmund.de/~ma/leafnode/beta/${MY_P}.tar.bz2"
HOMEPAGE="http://www-dt.e-technik.uni-dortmund.de/~ma/leafnode/beta/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="ipv6 pam"
RESTRICT="nomirror"

DEPEND=">=dev-libs/libpcre-3.9
	pam? ( sys-libs/pam )"
RDEPEND="${DEPEND}
	virtual/inetd"

S="${WORKDIR}/${MY_P}"

src_compile() {
	append-ldflags -Wl,-z,now

	econf \
		--sysconfdir=/etc/leafnode \
		--with-runas-user=news \
		--localstatedir=/var \
		--with-spooldir=/var/spool/news \
		$(use_with ipv6) \
		$(use_with pam) \
		|| die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	rm -rf ${D}/var/spool
	keepdir /var/lock/news

	insinto /etc/leafnode
	doins ${FILESDIR}/{local.groups,moderators} || die "doins failed"

	insinto /etc/xinetd.d
	newins ${FILESDIR}/leafnode.xinetd leafnode-nntp || die "newins failed"

	exeinto /etc/cron.hourly
	doexe ${FILESDIR}/fetchnews.cron || die "doexe failed"
	exeinto /etc/cron.daily
	doexe ${FILESDIR}/texpire.cron || die "doexe failed"

	dodoc \
		AUTHORS COPYING* CREDITS ChangeLog DEBUGGING ENVIRONMENT FAQ \
		INSTALL NEWS TODO README README_FIRST UPDATING || die "dodoc failed"
	dohtml README.html || die "dohtml failed"
}

pkg_postinst() {
	mkdir -p ${ROOT}/var/spool/news/{leaf.node,failed.postings,interesting.groups,out.going}
	mkdir -p ${ROOT}/var/spool/news/message.id/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}

	chown -R news:news ${ROOT}/var/spool/news
	find ${ROOT}/var/spool/news -type d -exec chmod 02775 {} \;

	zcat ${ROOT}/usr/share/doc/${PF}/README_FIRST.gz | while read line
	do
		einfo $line
	done

	einfo
	einfo "DO MAKE SURE THAT YOU RUN texpire -r IF YOU HAVE ARTICLES IN THE SPOOL"
}
