# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/apache/apache-2.0.48-r2.ebuild,v 1.3 2004/04/06 01:02:27 zul Exp $

inherit flag-o-matic
has_version =sys-libs/glibc-2.2* && filter-flags -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE

DESCRIPTION="Apache Web Server, Version 2.0.x"
HOMEPAGE="http://www.apache.org/"

S="${WORKDIR}/httpd-${PV}"
SRC_URI="http://www.apache.org/dist/httpd/httpd-${PV}.tar.gz"
KEYWORDS="~x86 ~ppc ~alpha ~hppa ~mips ~sparc ~amd64"
LICENSE="Apache-1.1"
SLOT="2"

#Standard location for Gentoo Linux
DATADIR="/var/www/localhost"

DEPEND="dev-util/yacc
	dev-lang/perl
	sys-libs/zlib
	dev-libs/expat
	dev-libs/openssl
	berkdb? ( sys-libs/db )
	gdbm? ( sys-libs/gdbm )
	!mips? ( ldap? ( =net-nds/openldap-2* ) )"
IUSE="berkdb gdbm ldap"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	patch -p1 <${FILESDIR}/apache-2.0.48-gentoo.diff || die

	# Fixes ipv6 error message when apache starts
	if use ipv6
	then
		epatch ${FILESDIR}/httpd-2.0.48-ipv6.patch || die
	fi

	#avoid utf-8 charset problems
	export LC_CTYPE=C

	#the -1 shortcut is obsolete
	perl -pi -e 's|head -1|head -n 1|;' srclib/apr/build/buildcheck.sh

	#give it the stamp
	perl -pi -e 's|" PLATFORM "|Gentoo/Linux|;' server/core.c
	#fix perl with perl!
	find -type f | xargs perl -pi -e \
		"s|/usr/local/bin/perl|/usr/bin/perl|g; \
		s|/usr/local/bin/perl5|/usr/bin/perl|g; \
		s|/path/to/bin/perl|/usr/bin/perl|g;"
	#dont want this cruft in /usr/bin
	perl -pi -e 's|\@exp_bindir\@(/envvars)|\@exp_installbuilddir\@\1|;' \
		support/apachectl.in

	#setup the filesystem layout config
	local prefix=/usr
	cat >>config.layout <<-EOF
	<Layout Gentoo>
	prefix:          ${prefix}
	exec_prefix:     ${prefix}
	bindir:          ${prefix}/bin
	sbindir:         ${prefix}/sbin
	libdir:          ${prefix}/lib
	libexecdir:      ${prefix}/lib/apache2/modules
	mandir:          ${prefix}/share/man
	infodir:         ${prefix}/share/info
	includedir:      ${prefix}/include/apache2
	installbuilddir: ${prefix}/lib/apache2/build
	datadir:         ${DATADIR}
	errordir:        ${DATADIR}/error
	iconsdir:        ${DATADIR}/icons
	htdocsdir:       ${DATADIR}/htdocs
	cgidir:          ${DATADIR}/cgi-bin
	manualdir:       /usr/share/doc/${PF}/manual
	sysconfdir:      /etc/apache2/conf
	localstatedir:   /var
	runtimedir:      /var/run
	logfiledir:      /var/log/apache2
	proxycachedir:   /var/cache/apache2
	</Layout>
	EOF

	#gotta do these next two as well :\
	cat >>srclib/apr/config.layout <<-EOF
	<Layout Gentoo>
	prefix:          ${prefix}
	exec_prefix:     ${prefix}
	bindir:          ${prefix}/bin
	sbindir:         ${prefix}/sbin
	libdir:          ${prefix}/lib
	libexecdir:      ${prefix}/lib/apache2/modules
	mandir:          ${prefix}/share/man
	sysconfdir:      /etc/apache2/conf
	datadir:         ${DATADIR}
	installbuilddir: ${prefix}/lib/apache2/build
	includedir:      ${prefix}/include/apache2
	localstatedir:   /var
	libsuffix:       -\${APR_MAJOR_VERSION}
	</Layout>
	EOF

	cat >>srclib/apr-util/config.layout <<-EOF
	<Layout Gentoo>
	prefix:          ${prefix}
	exec_prefix:     ${prefix}
	bindir:          ${prefix}/bin
	sbindir:         ${prefix}/sbin
	libdir:          ${prefix}/lib
	libexecdir:      ${prefix}/lib/apache2/modules
	mandir:          ${prefix}/share/man
	sysconfdir:      /etc/apache2/conf
	datadir:         ${DATADIR}
	installbuilddir: ${prefix}/lib/apache2/build
	includedir:      ${prefix}/include/apache2
	localstatedir:   /var
	libsuffix:       -\${APRUTIL_MAJOR_VERSION}
	</Layout>
	EOF

	./buildconf || die "buildconf failed"
}

src_compile() {
	local myconf
	use !mips && use ldap && \
		myconf="--with-ldap --enable-auth-ldap=shared --enable-ldap=shared"

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
	./configure \
		--with-suexec-safepath="/usr/local/bin:/usr/bin:/bin" \
		--with-suexec-logfile=/var/log/apache2/suexec_log \
		--with-suexec-bin=/usr/sbin/suexec2 \
		--with-suexec-userdir=public_html \
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
		--with-mpm=${MPM:=prefork} \
		--enable-layout=Gentoo \
		--with-program-name=apache2 \
		--host=${CHOST} ${myconf} || die "bad ./configure"
		#--with-mpm={worker|prefork|perchild|leader|threadpool}

	emake || die "problem compiling Apache2 :("

	#build ssl version of apache bench (ab-ssl)
	cd support; rm -f ab .libs/ab ab.lo ab.o
	make ab CFLAGS="${CFLAGS} -DUSE_SSL -lcrypto -lssl \
		-I/usr/include/openssl -L/usr/lib" || die
	mv ab ab-ssl; mv .libs/ab .libs/ab-ssl; rm -f ab.lo ab.o
	make ab || die
}

src_install () {
	local i
	make DESTDIR=${D} install || die
	dodoc ABOUT_APACHE CHANGES INSTALL LAYOUT \
		LICENSE README* ${FILESDIR}/robots.txt

	#bogus values pointing at /var/tmp/portage
	perl -pi -e "s/(APR_SOURCE_DIR=).*/\1\"\"/" ${D}/usr/bin/apr-config
	perl -pi -e "s/(APU_SOURCE_DIR=).*/\1\"\"/" ${D}/usr/bin/apu-config
	perl -pi -e "s/(APU_BUILD_DIR=).*/\1\"\"/" ${D}/usr/bin/apu-config

	#protect the suexec binary
	local gid=`getent group apache |cut -d: -f3`
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
		doexe ${FILESDIR}/2.0.40/$i
	done
	exeinto /usr/lib/ssl/apache2-mod_ssl
	doexe ${FILESDIR}/2.0.40/gentestcrt.sh

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
		doins ${FILESDIR}/2.0.40/$i
	done
	use !mips && use ldap && doins ${FILESDIR}/2.0.40/46_mod_ldap.conf

	#drop in a convenient link to the manual
	dosym /usr/share/doc/${PF}/manual ${DATADIR}/htdocs/manual

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
	mv -v usr/sbin/log_server_status usr/sbin/log_server_status2
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
	insinto /etc/conf.d; newins ${FILESDIR}/2.0.48-r1/apache2.confd apache2
	exeinto /etc/init.d; newexe ${FILESDIR}/2.0.48-r1/apache2.initd apache2
	insinto /etc/apache2; doins ${FILESDIR}/2.0.40/apache2-builtin-mods
	insinto /etc/apache2/conf
	doins ${FILESDIR}/2.0.40/commonapache2.conf
	doins ${FILESDIR}/2.0.48-r1/apache2.conf
	insinto /etc/apache2/conf/vhosts
	doins ${FILESDIR}/2.0.40/virtual-homepages.conf
	doins ${FILESDIR}/2.0.40/dynamic-vhosts.conf
	doins ${FILESDIR}/2.0.40/vhosts.conf

	# Added by Jason Wever <weeve@gentoo.org>
	# A little sedfu to fix bug #7172 for sparc64s
	if [ ${ARCH} = "sparc" ]
	then
		sed -i -e '13a\AcceptMutex fcntl' \
			${D}/etc/apache2/conf/apache2.conf
	fi
}

parse_modules_config() {
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
	parse_modules_config ${FILESDIR}/2.0.40/apache2-builtin-mods || \
	return 1
}

pkg_postinst() {
	#empty dirs...
	install -d -m0755 -o apache -g apache ${ROOT}/var/lib/dav
	install -d -m0755 -o root -g root ${ROOT}/var/log/apache2
	install -d -m0755 -o root -g root ${ROOT}/var/cache/apache2

	if use ssl; then
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

	einfo
	einfo "Please remember to update your config files in /etc/apache2"
	einfo "as --datadir has been changed to ${DATADIR}, and ServerRoot"
	einfo "has changed to /usr/lib/apache2!"
	einfo

	local list=""
	for i in lib logs modules extramodules; do
		local d="/etc/apache2/${i}"
		[ -s "${d}" ] && list="${list} ${d}"
	done
	if [ -n "${list}" ]; then
		einfo "You should delete these old symlinks: ${list}"
	fi
}
