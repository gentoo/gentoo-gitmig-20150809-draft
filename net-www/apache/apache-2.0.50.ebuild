# Copyright 1999-2004 Gentoo Foundation.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/apache/apache-2.0.50.ebuild,v 1.8 2004/08/03 16:39:08 agriffis Exp $

inherit flag-o-matic eutils fixheadtails gnuconfig

PATCH_LEVEL="${PV}"
S="${WORKDIR}/httpd-${PV}"
DESCRIPTION="Apache Web Server, Version 2.0.x"
HOMEPAGE="http://www.apache.org/"
SRC_URI="http://www.apache.org/dist/httpd/httpd-${PV}.tar.gz
	http://dev.gentoo.org/~zul/apache/apache-patches-${PV}.tar.bz2
	mirror://gentoo/apache-patches-${PV}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="x86 ~ppc sparc ~mips alpha arm hppa ~amd64 ia64 ~s390 ~ppc64"
IUSE="berkdb gdbm ldap threads ipv6 doc static ssl"

#Standard location for Gentoo Linux
DATADIR="/var/www/localhost"

DEPEND="dev-util/yacc
	dev-lang/perl
	sys-libs/zlib
	dev-libs/expat
	dev-libs/openssl
	>=sys-apps/sed-4
	berkdb? ( sys-libs/db )
	gdbm? ( sys-libs/gdbm )
	!mips? ( ldap? ( =net-nds/openldap-2* ) )
	selinux? ( sec-policy/selinux-apache )"

apache_setup_vars() {
	# Sets the USERDIR to default.
	USERDIR="public_html"
	einfo "DATADIR is set to: ${DATADIR}"
	einfo "USERDIR is set to: $USERDIR"
}

set_filter_flags () {
	CFLAGS="${CFLAGS/  / }"
	has_version =sys-libs/glibc-2.2* && filter-flags -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
}

src_unpack() {
	set_filter_flags

	unpack ${A} || die
	cd ${S} || die
	epatch ${WORKDIR}/00_gentoo_base.patch || die
	epatch ${WORKDIR}/03_redhat_xfsz.patch || die
	epatch ${WORKDIR}/04_ssl_makefile.patch || die

	if use ipv6; then
		epatch ${WORKDIR}/01_gentoo_ipv6.patch || die
	fi

	if use berkdb; then
		einfo "Enabling berkdb."
		if has_version '=sys-libs/db-4*'; then
			einfo "Enabling db4"
			myconf="${myconf} --with-dbm=db4 --with-berkely-db=/usr"
		elif has_version '=sys-libs/db-3*'; then
			einfo "Enabling db3"
			myconf="${myconf} --with-dbm=db3 --with-berkely-db=/usr"
		elif has_version '=sys-libs/db-2'; then
			einfo "Enabling db2"
			myconf="${myconf} --with-dbm=db2 --with-berkely-db=/usr"
		fi
	else
		echo "Disabling berkdb"
	fi

	#avoid utf-8 charset problems
	export LC_CTYPE=C

	ht_fix_file srclib/apr/build/buildcheck.sh

	#give it the stamp
	sed -i -e 's:(" PLATFORM "):(Gentoo/Linux):g' server/core.c

	#fix perl with perl!
	find -type f | xargs perl -pi -e \
		"s|/usr/local/bin/perl|/usr/bin/perl|g; \
		s|/usr/local/bin/perl5|/usr/bin/perl|g; \
		s|/path/to/bin/perl|/usr/bin/perl|g;"
	#dont want this cruft in /usr/bin
	sed -i -e 's:@exp_bindir@:@exp_installbuilddir:g' support/apachectl.in

	#setup the filesystem layout config
	cat ${FILESDIR}/common/config.layout >> config.layout
	sed -i -e 's:version:${PF}:g' config.layout

	cat ${FILESDIR}/common/apr-config.layout >> srclib/apr/config.layout
	cat ${FILESDIR}/common/apr-util-config.layout >> srclib/apr-util/config.layout

	sed -i -e "s:/var/www/localhost:${DATADIR}:g" srclib/apr/config.layout
	sed -i -e "s:/var/www/localhost:${DATADIR}:g" srclib/apr-util/config.layout

	WANT_AUTOCONF_2_5=1 WANT_AUTOCONF=2.5 ./buildconf || die "buildconf failed"
}

src_compile() {
	set_filter_flags
	apache_setup_vars

	# Detect mips and uclibc systems properly
	gnuconfig_update

	local myconf
	if use ldap; then
		if use mips; then
			eerror "Sorry, LDAP support isn't available yet for MIPS"
			eerror "Test out OpenLDAP and report it via BugZilla!"
			eerror "Continuing in 5 seconds"
			sleep 5s
		else
			einfo "Enabling LDAP"
			if use static; then
			  myconf="--with-ldap --enable-auth-ldap=static --enable-ldap=static"
			else
			  myconf="--with-ldap --enable-auth-ldap=shared --enable-ldap=shared"
			fi
		fi
	fi

	if use ipv6; then
		einfo "Enabling ipv6"
		myconf="${myconf} --enable-vp4"
	else
		myconf="${myconf} --disable-ipv6"
	fi

	if use threads; then
		einfo "Enabling threads support"
		myconf="${myconf} --with-mpm=worker"
	else
		myconf="${myconf} --with-mpm=${MPM:=prefork}"
	fi

	select_modules_config || die "determining modules"

	# Fix for bug #24215 - robbat2@gentoo.org, 30 Oct 2003
	# We pre-load the cache with the correct answer!  This avoids
	# it violating the sandbox.  This may have to be changed for
	# non-Linux systems or if sem_open changes on Linux.  This
	# hack is built around documentation in /usr/include/semaphore.h
	# and the glibc (pthread) source
	echo 'ac_cv_func_sem_open=${ac_cv_func_sem_open=no}' >> ${S}/config.cache

	# Workaround for bug #32444 - robbat2@gentoo.org, 28 Nov 2003
	# Apache2 tries to build SCTP support even when all the parts of it aren't there
	# So for the moment we tell it to ignore SCTP support
	echo 'ac_cv_sctp=${ac_cv_sctp=no}' >> ${S}/config.cache
	echo 'ac_cv_header_netinet_sctp_h=${ac_cv_header_netinet_sctp_h=no}' >> ${S}/config.cache
	echo 'ac_cv_header_netinet_sctp_uio_h=${ac_cv_header_netinet_sctp_uio_h=no}' >> ${S}/config.cache

	SSL_BASE="SYSTEM" \
	WANT_AUTOCONF_2_5=1 WANT_AUTOCONF=2.5
	./configure \
		--with-suexec-safepath="/usr/local/bin:/usr/bin:/bin" \
		--with-suexec-logfile=/var/log/apache2/suexec_log \
		--with-suexec-bin=/usr/sbin/suexec2 \
		--with-suexec-userdir=${USERDIR} \
		--with-suexec-caller=apache \
		--with-suexec-docroot=/var/www \
		--with-suexec-uidmin=1000 \
		--with-suexec-gidmin=100 \
		--with-suexec-umask=077 \
		--enable-suexec=shared \
		\
		${MY_BUILTINS} \
		\
		--cache-file=${S}/config.cache \
		--with-perl=/usr/bin/perl \
		--with-expat=/usr \
		--with-ssl=/usr \
		--with-z=/usr \
		--with-port=80 \
		--enable-layout=Gentoo \
		--with-program-name=apache2 \
		--with-devrandom=/dev/urandom \
		--host=${CHOST} ${myconf} || die "bad ./configure please submit bug report to bugs.gentoo.org. Include your config.layout."
		#--with-mpm={worker|prefork|perchild|leader|threadpool}

	# we don't want to try and recompile the ssl_expr_parse.c file, because
	# the lex source is broken
	touch modules/ssl/ssl_expr_scan.c

	emake || die "problem compiling Apache2 :("

	#build ssl version of apache bench (ab-ssl)
	cd support; rm -f ab .libs/ab ab.lo ab.o
	make ab CFLAGS="${CFLAGS} -DUSE_SSL -lcrypto -lssl \
		-I/usr/include/openssl -L/usr/lib" || die
	mv ab ab-ssl; mv .libs/ab .libs/ab-ssl; rm -f ab.lo ab.o
	make ab || die
}

src_install () {
	set_filter_flags

	local i
	make DESTDIR=${D} install || die
	dodoc ABOUT_APACHE CHANGES INSTALL LAYOUT \
		LICENSE README* ${FILESDIR}/robots.txt

	#bogus values pointing at /var/tmp/portage
	sed -i -e 's:APR_SOURCE_DIR=.*:APR_SOURCE_DIR=:g' ${D}/usr/bin/apr-config
	sed -i -e 's:APU_SOURCE_DIR=.*:APU_SOURCE_DIR=:g' ${D}/usr/bin/apu-config
	sed -i -e 's:APU_BUILD_DIR=.*:APU_BUILD_DIR=:g' ${D}/usr/bin/apu-config

	#protect the suexec binary
	local gid=`id -g apache`
	[ -z "${gid}" ] && gid=81
	fowners root:${gid} /usr/sbin/suexec
	fperms 4710 /usr/sbin/suexec

	#apxs needs this to pickup the right lib for install
	dosym /usr/lib /usr/lib/apache2/lib
	dosym /var/log/apache2 /usr/lib/apache2/logs
	dosym /usr/lib/apache2-extramodules /usr/lib/apache2/extramodules
	dosym /etc/apache2/conf /usr/lib/apache2/conf

	cd ${S}
	#Credits to advx.org people for these scripts. Heck, thanks for
	#the nice layout and everything else ;-)
	exeinto /usr/sbin
	for i in apache2logserverstatus apache2splitlogfile
	do
		doexe ${FILESDIR}/2.0.49/$i
	done
	exeinto /usr/lib/ssl/apache2-mod_ssl
	doexe ${FILESDIR}/2.0.49/gentestcrt.sh

	#some more scripts
	exeinto /usr/sbin
	for i in split-logfile list_hooks.pl logresolve.pl log_server_status
	do
		doexe ${S}/support/$i
	done
	#the ssl version of apache bench
	doexe support/.libs/ab-ssl

	#move some mods to extramodules
	dodir /usr/lib/apache2-extramodules
	for i in mod_ssl.so mod_ldap.so mod_auth_ldap.so
	do
		[ -x ${D}/usr/lib/apache2/modules/$i ] && \
		mv ${D}/usr/lib/apache2/modules/$i ${D}/usr/lib/apache2-extramodules
	done

	#modules.d config file snippets
	insinto /etc/apache2/conf/modules.d
	for i in 40_mod_ssl.conf 41_mod_ssl.default-vhost.conf 45_mod_dav.conf
	do
		doins ${FILESDIR}/2.0.49/$i
	done
	use !mips && use ldap && doins ${FILESDIR}/2.0.49/46_mod_ldap.conf

	#drop in a convenient link to the manual
	if use doc; then
		MANUAL_VERSION="2.0.50"
		insinto /etc/apache2/conf/modules.d
		doins ${FILESDIR}/00_apache_manual.conf
		dosym /usr/share/doc/${PF}/manual ${DATADIR}/htdocs/manual
		sed -i -e "s:2.0.49:${MANUAL_VERSION}:" ${D}/etc/apache2/conf/modules.d/00_apache_manual.conf
		else
		rm -rf ${D}/usr/share/doc/${PF}/manual
	fi

	#SLOT=2!!!
	cd ${D}
	mv -v usr/sbin/apachectl usr/sbin/apache2ctl
	mv -v usr/sbin/htdigest usr/sbin/htdigest2
	mv -v usr/sbin/htpasswd usr/sbin/htpasswd2
	mv -v usr/sbin/logresolve usr/sbin/logresolve2
	mv -v usr/sbin/apxs usr/sbin/apxs2
	mv -v usr/sbin/ab usr/sbin/ab2
	mv -v usr/sbin/ab-ssl usr/sbin/ab2-ssl
	mv -v usr/sbin/suexec usr/sbin/suexec2
	mv -v usr/sbin/rotatelogs usr/sbin/rotatelogs2
	mv -v usr/sbin/dbmmanage usr/sbin/dbmmanage2
	mv -v usr/sbin/checkgid usr/sbin/checkgid2
	mv -v usr/sbin/split-logfile usr/sbin/split-logfile2
	mv -v usr/sbin/list_hooks.pl usr/sbin/list_hooks2.pl
	mv -v usr/sbin/logresolve.pl usr/sbin/logresolve2.pl

	# do the man pages
	mv -v usr/share/man/man1/htdigest.1 usr/share/man/man1/htdigest2.1
	mv -v usr/share/man/man1/htpasswd.1 usr/share/man/man1/htpasswd2.1
	mv -v usr/share/man/man1/dbmmanage.1 usr/share/man/man1/dbmmanage2.1
	mv -v usr/share/man/man8/ab.8 usr/share/man/man8/ab2.8
	mv -v usr/share/man/man8/apxs.8 usr/share/man/man8/apxs2.8
	mv -v usr/share/man/man8/apachectl.8 usr/share/man/man8/apache2ctl.8
	mv -v usr/share/man/man8/httpd.8 usr/share/man/man8/apache2.8
	mv -v usr/share/man/man8/logresolve.8 usr/share/man/man8/logresolve2.8
	mv -v usr/share/man/man8/rotatelogs.8 usr/share/man/man8/rotatelogs2.8
	mv -v usr/share/man/man8/suexec.8 usr/share/man/man8/suexec2.8

	#tidy up
	mv ${D}/usr/sbin/envvars* ${D}/usr/lib/apache2/build
	dodoc ${D}/etc/apache2/conf/*-std.conf
	rm -f ${D}/etc/apache2/conf/*.conf
	rm -rf ${D}/var/run ${D}/var/log

	#config files
	insinto /etc/conf.d; newins ${FILESDIR}/2.0.49/apache2.confd apache2
	exeinto /etc/init.d; newexe ${FILESDIR}/2.0.49/apache2.initd apache2
	insinto /etc/apache2; doins ${FILESDIR}/2.0.49/apache2-builtin-mods
	insinto /etc/apache2/conf
	doins ${FILESDIR}/2.0.49/commonapache2.conf
	doins ${FILESDIR}/2.0.49/apache2.conf
	insinto /etc/apache2/conf/vhosts
	doins ${FILESDIR}/2.0.49/virtual-homepages.conf
	doins ${FILESDIR}/2.0.49/dynamic-vhosts.conf
	doins ${FILESDIR}/2.0.49/vhosts.conf

	# Added by Jason Wever <weeve@gentoo.org>
	# A little sedfu to fix bug #7172 for sparc64s
	if [ ${ARCH} = "sparc" ]
	then
		sed -i -e '13a\AcceptMutex fcntl' \
			${D}/etc/apache2/conf/apache2.conf
	fi
}

parse_modules_config() {
	set_filter_flags

	local filename=$1
	local name=""
	local dso=""
	local disable=""
	[ -f ${filename} ] || return 1
	for i in `cat $filename | sed "s/^#.*//"` ; do
		if [ $i == "-" ] ; then
			disable="true"
		elif [ -z "$name" ] && [ ! -z "`echo $i | grep "mod_"`" ] ; then
			name=`echo $i | sed "s/mod_//"`
		elif [ "$disable" ] && ( [ $i == "static" ] || [ $i == "shared" ] ) ; then
			MY_BUILTINS="${MY_BUILTINS} --disable-$name"
			name="" ; disable=""
		elif [ $i == "static" ] ; then
			MY_BUILTINS="${MY_BUILTINS} --enable-$name=yes"
			name="" ; disable=""
		elif [ $i == "shared" ] ; then
			MY_BUILTINS="${MY_BUILTINS} --enable-$name=shared"
			name="" ; disable=""
		fi
	done
	einfo "${filename} options:\n${MY_BUILTINS}"
}

select_modules_config() {
	parse_modules_config /etc/apache2/apache2-builtin-mods || \
	parse_modules_config ${FILESDIR}/2.0.49/apache2-builtin-mods || \
	return 1
}

pkg_postinst() {
	set_filter_flags

	#empty dirs...
	install -d -m0755 -o apache -g apache ${ROOT}/var/lib/dav
	install -d -m0755 -o root -g root ${ROOT}/var/log/apache2
	install -d -m0755 -o apache -g apache ${ROOT}/var/cache/apache2

	if use ssl; then
	#	install -d -m0755 -o root -g root ${ROOT}/etc/apache2/conf/ssl
	install -d -m0755 -o root -g root ${ROOT}/etc/apache2/conf/ssl
		cd ${ROOT}/etc/apache2/conf/ssl
		einfo
		einfo "Generating self-signed test certificate in /etc/apache2/conf/ssl..."
		yes "" 2>/dev/null | ${ROOT}/usr/lib/ssl/apache2-mod_ssl/gentestcrt.sh >/dev/null 2>&1
		einfo
	fi

	if has_version '=net-www/apache-1*' ; then
	ewarn
	ewarn "Please add the 'apache2' flag to your USE variable and (re)install"
	ewarn "any additional DSO modules you may wish to use with Apache-2.x."
	ewarn "Addon modules are configured in /etc/apache2/conf/modules.d/"
	ewarn
	fi

	# Check to see if this is an upgrade
	if [ -d /home/httpd ];
	then
	einfo
	einfo "Please remember to update your config files in /etc/apache2"
	einfo "as --datadir has been changed to ${DATADIR}, and ServerRoot"
	einfo "has changed to /usr/lib/apache2!"
	einfo
	fi

	local list=""
	for i in lib logs modules extramodules; do
		local d="/etc/apache2/${i}"
		[ -s "${d}" ] && list="${list} ${d}"
	done
	if [ -n "${list}" ]; then
		einfo "You should delete these old symlinks: ${list}"
	fi
}
