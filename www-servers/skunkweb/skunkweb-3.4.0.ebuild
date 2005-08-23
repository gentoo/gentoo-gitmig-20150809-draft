# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/skunkweb/skunkweb-3.4.0.ebuild,v 1.5 2005/08/23 13:58:53 satya Exp $

inherit eutils

DESCRIPTION="robust Python web application server"
HOMEPAGE="http://skunkweb.sourceforge.net/"
MY_P=${P/_beta/b}
S=${WORKDIR}/${MY_P}
SRC_URI="mirror://sourceforge/skunkweb/${MY_P}.tar.gz"
LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="apache1 apache2 doc"
DEPEND=">=dev-lang/python-2.2
		>=dev-python/egenix-mx-base-2.0.4
		apache2? ( >=net-www/apache-2.0.47 )
		!apache2? ( apache1? ( <=net-www/apache-2 ) )"

pkg_setup() {
	enewgroup skunkweb
	enewuser skunkweb -1 -1 /usr/share/skunkweb skunkweb
}

src_compile() {
	local myconf
	if use apache2; then
		myconf="${myconf} --with-apxs=/usr/sbin/apxs2"
	else
		if use apache1; then
			myconf="${myconf} --with-apxs=/usr/sbin/apxs"
		else
			myconf="${myconf} --without-mod_skunkweb"
		fi
	fi
	econf \
		--with-user=skunkweb \
		--with-group=skunkweb \
		--localstatedir=/var/lib/skunkweb \
		--bindir=/usr/bin \
		--libdir=/usr/lib/skunkweb \
		--sysconfdir=/etc/skunkweb \
		--prefix=/usr/share/skunkweb \
		--with-cache=/var/lib/skunkweb/cache \
		--with-docdir=/usr/share/doc/${P} \
		--with-logdir=/var/log/skunkweb \
		--with-python=/usr/bin/python \
		${myconf} || die "configure failed"

	emake || die
}

src_install() {
	INSTALLING="yes"
	make DESTDIR=${D} APXSFLAGS="-c" install || die
	if use apache2; then
		exeinto /usr/lib/apache2-extramodules
		doexe SkunkWeb/mod_skunkweb/.libs/mod_skunkweb.so
		insinto /etc/apache2/conf/modules.d
		newins SkunkWeb/mod_skunkweb/httpd_conf.stub mod_skunkweb.conf
	else
		if use apache1; then
			exeinto /usr/lib/apache-extramodules
			doexe SkunkWeb/mod_skunkweb/mod_skunkweb.so
			insinto /etc/apache/conf/addon-modules
			newins SkunkWeb/mod_skunkweb/httpd_conf.stub mod_skunkweb.conf
		fi
	fi
	# dirs --------------------------------------------------------------
	mkdir -p ${D}/var/{lib,log}/${PN}
	chown skunkweb:skunkweb ${D}/var/{lib,log}/${PN}
	mkdir -p ${D}/var/lib/${PN}/run
	# scripts------------------------------------------------------------
	exeinto /etc/init.d; newexe ${FILESDIR}/skunkweb-init skunkweb
	exeinto /etc/cron.daily
		newexe ${FILESDIR}/skunkweb-cron-cache_cleaner skunkweb-cache_cleaner
	# docs --------------------------------------------------------------
	dodoc README ChangeLog NEWS HACKING ACKS INSTALL
	if use doc; then
		dodir /usr/share/doc/${PF}
		cp docs/paper-letter/*.pdf ${D}/usr/share/doc/${PF}
		ewarn "Some docs are still in upstream cvs (i.e.: formlib, pydo2)"
	fi
}
