# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
#

IUSE="ssl tcltk"

S=${WORKDIR}/${P}
DESCRIPTION="The Internet News daemon, fully featured NNTP server"
SRC_URI="ftp://ftp.isc.org/isc/inn/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.tar.gz"
HOMEPAGE="http://www.isc.org/products/INN"

SLOT="0"
LICENSE="as-is BSD"
KEYWORDS="~x86"

DEPEND="app-crypt/gnupg
	virtual/mta
	tcltk? ( dev-lang/tcl )
	ssl? ( dev-libs/openssl )"

src_compile() {
	local myconf
	use tcltk && myconf="${myconf} --with-tcl"
	use ssl && myconf="${myconf} --with-openssl"

	unset CFLAGS CXXFLAGS
	./configure --prefix=/usr/lib/news \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--with-etc-dir=/etc/news \
		--with-db-dir=/var/spool/news/db \
		--with-spool-dir=/var/spool/news \
		--with-log-dir=/var/log/news \
		--with-run-dir=/var/run/news \
		--with-tmp-path=/var/spool/news/tmp \
		--host=${CHOST}  \
		--enable-libtool \
		--enable-setgid-inews \
		--enable-uucp-rnews \
		--with-gnu-ld \
		--with-python \
		--without-perl \
		${myconf} || die "configure died"

	OLD_P=${P}
	unset P
	make || die
	P=${OLD_P}
}

src_install() {
	OLD_P=${P}
	unset P
	make prefix=${D}/usr/lib/news \
		PATHETC=${D}/etc/news \
		PATHMAN=${D}/usr/share/man \
		PATHLIB=${D}/usr/lib/news/lib \
		PATHCONTROL=${D}/usr/lib/news/bin/control \
		PATHFILTER=${D}/usr/lib/news/bin/filter \
		PATHRUN=${D}/var/run/news \
		PATHLOG=${D}/var/log/news \
		PATHDB=${D}/var/spool/news/db \
		PATHSPOOL=${D}/var/spool/news \
		PATHTMP=${D}/var/spool/news/tmp \
		install || die "make died"
	P=${OLD_P}

	keepdir /var/spool/news/tmp/
	keepdir /var/spool/news/outgoing/
	keepdir /var/spool/news/overview/
	keepdir /var/spool/news/innfeed/
	keepdir /var/spool/news/articles/
	keepdir /var/spool/news/incoming/
	keepdir /var/spool/news/incoming/bad/
	keepdir /var/spool/news/archive/
	keepdir /var/run/news/
	keepdir /var/log/news/

	dodoc CONTRIBUTORS ChangeLog HACKING HISTORY INSTALL LICENSE
	dodoc MANIFEST NEWS README*
	dodoc doc/control-messages doc/sample-control

# So other programs can build against INN.  (eg. Suck)
	insinto /usr/lib/news/include
	doins include/*.h

	exeinto /etc/init.d
	newexe ${FILESDIR}/innd innd

	cd ${WORKDIR}
	doman send-uucp.pl.8.gz
	insinto /etc/news
	doins send-uucp.cf 
	exeinto /usr/lib/news/bin
	newexe send-uucp.pl send-uucp.pl
}

pkg_postinst() {
	chown news.news ${ROOT}/etc/news/send-uucp.cf
	chown news.news ${ROOT}/usr/lib/news/bin/send-uucp.pl
	chown -R news.news ${ROOT}/var/spool/news
	chown -R news.news ${ROOT}/var/log/news/

	einfo 'Do not forget to update your cron entries, and also run'
	einfo 'makedbz if you need to.  If this is a first-time installation'
	einfo 'a minimal active file has been installed.  You will need to'
	einfo 'touch history and run "makedbz -i" to initialize the history'
	einfo 'database.  See INSTALL for more information.'
}
