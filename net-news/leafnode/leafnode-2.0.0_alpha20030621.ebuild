# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/leafnode/leafnode-2.0.0_alpha20030621.ebuild,v 1.7 2004/03/20 07:32:10 mr_bones_ Exp $

S="${WORKDIR}/leafnode-2.0.0.alpha20030621b"
DESCRIPTION="A USENET software package designed for small sites"
SRC_URI="http://www-dt.e-technik.uni-dortmund.de/~ma/leafnode/beta/leafnode-2.0.0.alpha20030621b.tar.bz2"
HOMEPAGE="http://www-dt.e-technik.uni-dortmund.de/~ma/leafnode/beta/"
DEPEND=">=dev-libs/libpcre-3.9
	virtual/inetd"
LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="~x86 ~ppc"
IUSE="ipv6"

src_compile() {
	local myconf

	# ------------------------------------------------------
	# Enabling IPv6.
	# ------------------------------------------------------
	# If this was misdetected, then run either
	#   env cf_cv_ipv6=no /bin/sh ./configure YOUR_OPTIONS
	# or
	#   env cf_cv_ipv6=yes /bin/sh ./configure YOUR_OPTIONS
	# (of course, you need to replace YOUR_OPTIONS)
	# ------------------------------------------------------

	use ipv6 && myconf="--with-ipv6" ||	export cf_cv_ipv6=no

	econf \
		--with-runas-user=news \
		${myconf} || die "./configure failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	# remove the spool dirs -- put them back in during pkg_postinst, so that
	# they don't get removed during an unmerge or upgrade
	rm -rf ${D}/var/spool

	# add .keep file to /var/lock/news to avoid ebuild to ignore the empty dir
	keepdir /var/lock/news/
	# ... and keep texpire from complaining about missing dir
	keepdir /etc/leafnode/local.groups

	insinto /etc/xinetd.d
	newins ${FILESDIR}/leafnode.xinetd leafnode-nntp

	exeinto /etc/cron.hourly
	doexe ${FILESDIR}/fetchnews.cron
	exeinto /etc/cron.daily
	doexe ${FILESDIR}/texpire.cron

	dodoc AUTHORS COPYING* CREDITS ChangeLog DEBUGGING ENVIRONMENT FAQ \
	INSTALL NEWS TODO README README_FIRST UPDATING
	dohtml README.html
}

pkg_postinst() {
	mkdir -p /var/spool/news/{leaf.node,failed.postings,interesting.groups,out.going}
	mkdir -p /var/spool/news/message.id/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}
	chown -R news:news /var/spool/news

	mkdir -p /var/lib/news
	chown -R news:news /var/lib/news

	cat ${S}/README_FIRST | while read line ;
	do
		einfo $line
	done

	einfo
	einfo "DO MAKE SURE THAT YOU RUN texpire -r IF YOU HAVE ARTICLES IN THE SPOOL"
}
