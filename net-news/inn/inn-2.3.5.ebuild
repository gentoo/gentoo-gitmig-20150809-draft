# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/inn/inn-2.3.5.ebuild,v 1.9 2004/03/15 09:37:46 mr_bones_ Exp $

DESCRIPTION="The Internet News daemon, fully featured NNTP server"
HOMEPAGE="http://www.isc.org/products/INN"
SRC_URI="ftp://ftp.isc.org/isc/inn/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.tar.gz"

LICENSE="as-is BSD"
SLOT="0"
KEYWORDS="x86"
IUSE="ssl tcltk"

RDEPEND="app-crypt/gnupg
	virtual/mta
	tcltk? ( dev-lang/tcl )
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's/\$(P) //' site/Makefile storage/Makefile \
			|| die "sed failed"
}

src_compile() {
	./configure \
		--prefix=/usr/lib/news \
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
		--with-python \
		--without-perl \
		`use_with tcltk tcl` \
		`use_with ssl openssl` \
			|| die "configure died"

	emake -j1 || die "emake failed"
}

src_install() {
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
		MAN1=${D}/usr/share/man/man1 \
		MAN3=${D}/usr/share/man/man3 \
		MAN5=${D}/usr/share/man/man5 \
		MAN8=${D}/usr/share/man/man8 \
			install || die "make install failed"

	keepdir \
		/var/spool/news/tmp/ \
		/var/spool/news/outgoing/ \
		/var/spool/news/overview/ \
		/var/spool/news/innfeed/ \
		/var/spool/news/articles/ \
		/var/spool/news/incoming/bad/ \
		/var/spool/news/archive/ \
		/var/run/news/ \
		/var/log/news/

	dodoc CONTRIBUTORS ChangeLog HACKING HISTORY INSTALL LICENSE \
		MANIFEST NEWS README* doc/control-messages doc/sample-control

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
	chown news:news ${ROOT}/etc/news/send-uucp.cf
	chown news:news ${ROOT}/usr/lib/news/bin/send-uucp.pl
	chown -R news:news ${ROOT}/var/spool/news
	chown -R news:news ${ROOT}/var/log/news/

	einfo 'Do not forget to update your cron entries, and also run'
	einfo 'makedbz if you need to.  If this is a first-time installation'
	einfo 'a minimal active file has been installed.  You will need to'
	einfo 'touch history and run "makedbz -i" to initialize the history'
	einfo 'database.  See INSTALL for more information.'
	einfo ''
	einfo 'You need to assign a real shell to the news user, or else'
	einfo 'starting inn will fail. You can use "usermod -s /bin/bash news"'
	einfo 'for this.'
}
