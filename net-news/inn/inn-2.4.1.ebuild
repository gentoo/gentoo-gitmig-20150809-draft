# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/inn/inn-2.4.1.ebuild,v 1.7 2004/10/17 20:56:51 dholm Exp $

inherit fixheadtails ssl-cert eutils libtool flag-o-matic

DESCRIPTION="The Internet News daemon, fully featured NNTP server"
HOMEPAGE="http://www.isc.org/products/INN"
SRC_URI="ftp://ftp.isc.org/isc/inn/${P}.tar.gz
	http://mauricem.com/inn_db4.tar.gz"
SLOT="0"
LICENSE="as-is BSD GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="ipv6 kerberos sasl ssl perl python tcltk berkdb inntaggedhash innkeywords"

RDEPEND="virtual/mta
	kerberos? ( virtual/krb5 )
	sasl? ( >=dev-libs/cyrus-sasl-2 )
	ssl? ( dev-libs/openssl )
	perl? ( dev-lang/perl )
	python? ( dev-lang/python )
	tcltk? ( dev-lang/tcl )
	berkdb? ( sys-libs/db )
	virtual/gzip"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.13
	sys-devel/libtool
	>=sys-apps/sed-4"

append-ldflags -Wl,-z,now

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/2.4.1-berkdb.patch
	epatch ${WORKDIR}/db_patch.patch

	ht_fix_file configure.in support/fixscript.in

	export WANT_AUTOCONF="2.1"
	autoconf || die "autoconf failed"

	sed -i \
		-e "s/ -B .OLD//" \
		Makefile.global.in \
		control/Makefile \
		doc/man/Makefile

	elibtoolize || die "elibtoolize failed"
}

src_compile() {
	econf \
		--prefix=/usr/lib/news \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--with-control-dir=/usr/lib/news/bin/control \
		--with-etc-dir=/etc/news \
		--with-filter-dir=/usr/lib/news/bin/filter \
		--with-db-dir=/var/spool/news/db \
		--with-doc-dir=/usr/share/doc/${PF} \
		--with-spool-dir=/var/spool/news \
		--with-log-dir=/var/log/news \
		--with-run-dir=/var/run/news \
		--with-tmp-path=/var/spool/news/tmp \
		--enable-libtool \
		--enable-setgid-inews \
		--enable-uucp-rnews \
		--with-gnu-ld \
		$(use_with perl) \
		$(use_with python) \
		$(use_with tcltk tcl) \
		$(use_with kerberos kerberos /usr) \
		$(use_with sasl) \
		$(use_with ssl openssl) \
		$(use_with berkdb berkeleydb) \
		$(use_enable ipv6) \
		$(use_enable !inntaggedhash largefiles) \
		$(use_enable inntaggedhash tagged-hash) \
		$(use_enable innkeywords keywords) \
		|| die "econf failed"
	emake -j1 P="" || die "emake failed"
}

src_install() {
	make DESTDIR=${D} P="" install || die "make install failed"

	chown -R root.root ${D}/usr/{lib/news/{lib,include},share/{doc,man}}
	chmod 644 ${D}/etc/news/*
	for file in control.ctl expire.ctl incoming.conf nntpsend.ctl passwd.nntp readers.conf
	do
		chmod 640 ${D}/etc/news/${file}
	done

	# Prevent old db/* files from being overwritten
	dodir /usr/share/doc/${PF}/dbexamples
	for db_file in active active.times distributions history newsgroups
	do
		if [ -f ${D}/var/spool/news/db/${db_file} ]
		then
			mv ${D}/var/spool/news/db/${db_file} ${D}/usr/share/doc/${PF}/dbexamples
		fi
	done

	keepdir \
		/var/{log,run}/news \
		/var/spool/news/{,archive,articles,db,incoming{,/bad},innfeed,outgoing,overview,tmp}

	dodoc ChangeLog MANIFEST README* doc/checklist
	use ipv6 && dodoc doc/IPv6-info

	# So other programs can build against INN. (eg. Suck)
	insinto /usr/lib/news/include
	doins include/*.h

	exeinto /etc/init.d
	doexe ${FILESDIR}/innd innd

	if use ssl
	then
		insinto /etc/news/cert

		docert cert
		fowners news:news /etc/news/cert/cert.{crt,csr,key,pem}

		for cert in cert.{crt,csr,key,pem}
		do
			dosym "/etc/news/cert/${cert}" "/usr/lib/news/lib/${cert}"
		done
	fi
}

pkg_postinst() {
	for db_file in active active.times distributions history newsgroups
	do
		if [ -f ${ROOT}/usr/share/doc/${PF}/dbexamples/${db_file} \
			-a ! -f ${ROOT}/var/spool/news/db/${db_file} ]
		then
			cp -p ${ROOT}/usr/share/doc/${PF}/dbexamples/${db_file} \
				${ROOT}/var/spool/news/db/${db_file}
			chmod 664 ${ROOT}/var/spool/news/db/${db_file}
		fi
	done

	chown -R news:news ${ROOT}/var/{log,spool}/news

	einfo "Do not forget to update your cron entries, and also run"
	einfo "makedbz if you need to.  If this is a first-time installation"
	einfo "a minimal active file has been installed.  You will need to"
	einfo "touch history and run 'makedbz -i' to initialize the history"
	einfo "database.  See INSTALL for more information."
	einfo
	einfo "You need to assign a real shell to the news user, or else"
	einfo "starting inn will fail. You can use 'usermod -s /bin/bash news'"
	einfo "for this."

	if use ssl
	then
		einfo
		einfo "You may want to start nnrpd manually for native ssl support."
		einfo "If you choose to do so, automating this with a bootscript might"
		einfo "also be a good choice."
		einfo "Have a look at man nnrpd for valid parameters."
	fi
}

pkg_postrm() {
	einfo
	einfo "If you want your newsspool or altered configuration files"
	einfo "to be removed, please do so now manually."
	einfo
}

pkg_config() {
	NEWSSPOOL_DIR="${ROOT}/var/spool/news"
	NEWS_SHELL="`awk -F':' '/^news:/ {print $7;}' ${ROOT}/etc/passwd`"
	NEWS_ERRFLAG="0"

	if [ "${NEWS_SHELL}" == "/bin/false" -o "${NEWS_SHELL}" == "/dev/null" ]
	then
		if [ ${UID} -eq 0 ]
		then
			einfo 'Changing shell to /bin/bash for user news...'
			usermod -s /bin/bash news
		else
			NEWS_ERRFLAG=1
			eerror ''
			eerror 'Could not change shell for user news.'
			eerror 'Please run "usermod -s /bin/bash news" as root.'
		fi
	else
		einfo "Shell for user news unchanged ('${NEWS_SHELL}')."
		if [ "${NEWS_SHELL}" != "/bin/sh" -a "${NEWS_SHELL}" != "/bin/bash" ]
		then
			ewarn "You might want to change it to '/bin/bash', though."
		fi
	fi

	if [ ! -e "${NEWSSPOOL_DIR}/db/history}" ]
	then
		if [ ! -f "${NEWSSPOOL_DIR}/db/history.dir" \
			-a ! -f "${NEWSSPOOL_DIR}/db/history.pag" \
			-a ! -f "${NEWSSPOOL_DIR}/db/history.hash" \
			-a ! -f "${NEWSSPOOL_DIR}/db/history.index" ]
		then
			einfo 'Building history database...'
			touch "${NEWSSPOOL_DIR}/db/history"
			chown news:news "${NEWSSPOOL_DIR}/db/history"
			chmod 644 "${NEWSSPOOL_DIR}/db/history"
			su - news -c "/usr/lib/news/bin/makedbz -i"
			mv -f "${NEWSSPOOL_DIR}/db/history.n.dir" "${NEWSSPOOL_DIR}/db/history.dir"
			[ -f "${NEWSSPOOL_DIR}/db/history.n.pag" ] && mv -f "${NEWSSPOOL_DIR}/db/history.n.pag" "${NEWSSPOOL_DIR}/db/history.pag"
			[ -f "${NEWSSPOOL_DIR}/db/history.n.hash" ] && mv -f "${NEWSSPOOL_DIR}/db/history.n.hash" "${NEWSSPOOL_DIR}/db/history.hash"
			[ -f "${NEWSSPOOL_DIR}/db/history.n.index" ] && mv -f "${NEWSSPOOL_DIR}/db/history.n.index" "${NEWSSPOOL_DIR}/db/history.index"
			su - news -c "/usr/lib/news/bin/makehistory"
		else
			NEWS_ERRFLAG="1"
			eerror
			eerror "Your installation seems to be screwed up."
			eerror "${NEWSSPOOL_DIR}/db/history does not exist, but there's"
			eerror "one of the files history.dir, history.hash or history.index"
			eerror "within ${NEWSSPOOL_DIR}/db."
			eerror "Use your backup to restore the history database."
		fi
	else
		einfo "${NEWSSPOOL_DIR}/db/history found. Leaving history database as it is."
	fi

	INNCFG_INODES="`sed -e '/innwatchspoolnodes/ ! d' /etc/news/inn.conf | sed -e 's/[^ ]*[ ]*\([^ ]*\)/\1/'`"
	INNSPOOL_INODES="`df -Pi ${NEWSSPOOL_DIR} | sed -e 's/[^ ]*[ ]*\([^ ]*\).*/\1/' | sed -e '1 d'`"
	if [ ${INNCFG_INODES} -gt ${INNSPOOL_INODES} ]
	then
		ewarn "Setting innwatchspoolinodes to zero, because the filesystem behind"
		ewarn "$NEWSSPOOL_DIR works without inodes."
		ewarn
		cp /etc/news/inn.conf /etc/news/inn.conf.OLD
		einfo "A copy of your old inn.conf has been saved to /etc/news/inn.conf.OLD."
		sed -i -e '/innwatchspoolnodes/ s/\([^ ]*\)\([ ]*\).*/\1\20/' /etc/news/inn.conf
		chown news:news /etc/news/inn.conf
		chmod 644 /etc/news/inn.conf
	fi

	INNCHECK_LINES="`su - news -c "/usr/lib/news/bin/inncheck | wc -l"`"
	if [ "${INNCHECK_LINES}" -gt 0 ]
	then
		NEWS_ERRFLAG="1"
		ewarn "inncheck most certainly found an error."
		ewarn "Please check its output:"
		eerror "`su - news -c /usr/lib/news/bin/inncheck`"
	fi

	if [ "${NEWS_ERRFLAG}" -gt 0 ]
	then
		eerror
		eerror "There were one or more errors/warnings checking your configuration."
		eerror "Please read inn's documentation and fix them accordingly."
	else
		einfo
		einfo "Inn configuration tests passed successfully."
		einfo
		ewarn "Please ensure you configured inn properly."
	fi
}
