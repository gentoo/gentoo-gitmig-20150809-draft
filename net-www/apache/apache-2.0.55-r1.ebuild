# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/apache/apache-2.0.55-r1.ebuild,v 1.11 2006/04/19 17:24:59 chtekk Exp $

inherit eutils gnuconfig multilib

# latest gentoo apache files
GENTOO_PATCHNAME="gentoo-apache-${PVR}"
GENTOO_PATCHSTAMP="20060115"
GENTOO_DEVSPACE="vericgar"
GENTOO_PATCHDIR="${WORKDIR}/${GENTOO_PATCHNAME}"

DESCRIPTION="The Apache Web Server"
HOMEPAGE="http://httpd.apache.org/"
SRC_URI="mirror://apache/httpd/httpd-${PV}.tar.bz2
	http://dev.gentoo.org/~${GENTOO_DEVSPACE}/dist/apache/${GENTOO_PATCHNAME}-${GENTOO_PATCHSTAMP}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE="apache2 debug doc ldap mpm-leader mpm-peruser mpm-prefork mpm-threadpool mpm-worker no-suexec ssl static-modules threads selinux"

RDEPEND="dev-lang/perl
	|| ( ~dev-libs/apr-0.9.12 ~dev-libs/apr-0.9.7 )
	|| ( ~dev-libs/apr-util-0.9.12 ~dev-libs/apr-util-0.9.7 )
	dev-libs/expat
	net-www/gentoo-webroot-default
	app-misc/mime-types
	sys-libs/zlib
	ssl? ( dev-libs/openssl )
	selinux? ( sec-policy/selinux-apache )
	!mips? ( ldap? ( =net-nds/openldap-2* ) )"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.59-r4"

S="${WORKDIR}/httpd-${PV}"

big_fat_warnings() {

	if use ldap && ! built_with_use 'dev-libs/apr-util' ldap; then
		eerror "dev-libs/apr-util is missing LDAP support. For apache to have"
		eerror "ldap support, apr-util must be built with the ldap USE-flag"
		eerror "enabled."
		die "ldap USE-flag enabled while not supported in apr-util"
	fi

	if use mpm-peruser; then
		ewarn " -BIG- -FAT- -WARNING-"
		ewarn ""
		ewarn "The peruser (USE=mpm-peruser) MPM is considered highly experimental"
		ewarn "and are not (yet) supported, nor are they recommended for production"
		ewarn "use.  You have been warned!"
		ewarn
		ewarn "Continuing in 5 seconds.."
		sleep 5
	fi

	ewarn ""
	ewarn "LFS support has been removed due to incompatibilites with other packages."
	ewarn "You _will_ have to re-emerge any Apache modules you have installed, or"
	ewarn "they will likely misbehave/segfault."
	ewarn ""
	ewarn ""
	ewarn "Multiple MPM support has been disabled due to problems with external"
	ewarn "modules.  If you have relied on this functionality you will need"
	ewarn "to find another solution.  The Gentoo Apache team apologizes for"
	ewarn "any inconvienence this may cause you."
	ewarn ""
}

pkg_setup() {
	big_fat_warnings
	select_mpms
}

src_unpack() {
	unpack ${A} || die
	cd ${S} || die

	# Use correct multilib libdir in gentoo patches
	sed -i -e "s:/usr/lib:/usr/$(get_libdir):g" \
		${GENTOO_PATCHDIR}/{conf/httpd.conf,init/*,patches/config.layout} \
		|| die "sed failed"

	EPATCH_SUFFIX="patch"
	epatch ${GENTOO_PATCHDIR}/patches/[0-9]* || die "internal ebuild error"

	# avoid utf-8 charset problems
	export LC_CTYPE=C

	# setup the filesystem layout config
	cat ${GENTOO_PATCHDIR}/patches/config.layout >> config.layout
	sed -i -e 's:version:${PF}:g' config.layout

	# peruser need to build conf
	WANT_AUTOCONF=2.5 ./buildconf || die "buildconf failed"
}

src_compile() {
	setup_apache_vars

	# Detect mips and uclibc systems properly
	gnuconfig_update

	local modtype
	if useq static-modules; then
		modtype="static"
	else
		modtype="shared"
	fi

	select_modules_config || die "determining modules"

	local myconf
	useq ldap && myconf="${myconf} --enable-auth-ldap=${modtype} --enable-ldap=${modtype}"
	useq ssl && myconf="${myconf} --with-ssl=/usr  --enable-ssl=${modtype}"

	# Fix for bug #24215 - robbat2@gentoo.org, 30 Oct 2003
	# We pre-load the cache with the correct answer!  This avoids
	# it violating the sandbox.  This may have to be changed for
	# non-Linux systems or if sem_open changes on Linux.  This
	# hack is built around documentation in /usr/include/semaphore.h
	# and the glibc (pthread) source
	echo 'ac_cv_func_sem_open=${ac_cv_func_sem_open=no}' >> ${S}/config.cache

	if useq no-suexec; then
		myconf="${myconf} --disable-suexec"
	else
		myconf="${myconf}
				--with-suexec-safepath="/usr/local/bin:/usr/bin:/bin" \
				--with-suexec-logfile=/var/log/apache2/suexec_log \
				--with-suexec-bin=/usr/sbin/suexec2 \
				--with-suexec-userdir=${USERDIR} \
				--with-suexec-caller=apache \
				--with-suexec-docroot=/var/www \
				--with-suexec-uidmin=1000 \
				--with-suexec-gidmin=100 \
				--with-suexec-umask=077 \
				--enable-suexec=shared"
	fi

	# common confopts
	myconf="${myconf} \
			--with-apr=/usr \
			--with-apr-util=/usr \
			--cache-file=${S}/config.cache \
			--with-perl=/usr/bin/perl \
			--with-expat=/usr \
			--with-z=/usr \
			--with-port=80 \
			--enable-layout=Gentoo \
			--with-program-name=apache2 \
			--with-devrandom=/dev/urandom \
			--host=${CHOST} ${MY_BUILTINS}"

	# debugging support
	if useq debug ; then
		myconf="${myconf} --enable-maintainer-mode"
	fi

	./configure --with-mpm=${mpm} ${myconf} || die "bad ./configure please submit bug report to bugs.gentoo.org. Include your config.layout and config.log"

	# we don't want to try and recompile the ssl_expr_parse.c file, because
	# the lex source is broken
	touch modules/ssl/ssl_expr_scan.c

	# as decided on IRC-AGENDA-10.2004, we use httpd.conf as standard config file name
	sed -i -e 's:apache2\.conf:httpd.conf:' include/ap_config_auto.h

	emake || die "problem compiling apache2"

	# build ssl version of apache bench (ab-ssl)
	if useq ssl; then
		cd support
		rm -f ab .libs/ab ab.lo ab.o
		make ab CFLAGS="${CFLAGS} -DUSE_SSL -lcrypto -lssl -I/usr/include/openssl -L/usr/$(get_libdir)" || die
		mv ab ab-ssl
		rm -f ab.lo ab.o
		make ab || die
	fi
}

pkg_preinst() {
	# setup apache user and group
	enewgroup apache 81
	enewuser apache 81 -1 /var/www apache
}

src_install () {
	# general install
	make DESTDIR=${D} install || die
	dodoc ABOUT_APACHE CHANGES INSTALL LAYOUT LICENSE README* ${GENTOO_PATCHDIR}/docs/robots.txt

	# protect the suexec binary
	if ! useq no-suexec; then
		fowners root:apache /usr/sbin/suexec
		fperms 4710 /usr/sbin/suexec
	fi

	# apxs needs this to pickup the right lib for install
	dosym /usr/$(get_libdir) /usr/$(get_libdir)/apache2/lib
	dosym /var/log/apache2 /usr/$(get_libdir)/apache2/logs
	dosym /etc/apache2 /usr/$(get_libdir)/apache2/conf

	# Credits to advx.org people for these scripts. Heck, thanks for
	# the nice layout and everything else ;-)
	exeinto /usr/sbin
	for i in apache2logserverstatus apache2splitlogfile; do
		doexe ${GENTOO_PATCHDIR}/scripts/${i}
	done
	# gentestcrt.sh only if USE=ssl
	useq ssl && doexe ${GENTOO_PATCHDIR}/scripts/gentestcrt.sh

	# some more scripts
	for i in split-logfile list_hooks.pl logresolve.pl log_server_status; do
		doexe ${S}/support/${i}
	done

	# the ssl version of apache bench
	useq ssl && doexe support/ab-ssl

	# install mpm bins
	doexe ${S}/apache2

	# modules.d config file snippets
	insinto /etc/apache2/modules.d
	doins ${GENTOO_PATCHDIR}/conf/modules.d/45_mod_dav.conf
	useq ldap && doins ${GENTOO_PATCHDIR}/conf/modules.d/46_mod_ldap.conf
	if useq ssl; then
		doins ${GENTOO_PATCHDIR}/conf/modules.d/40_mod_ssl.conf
		doins ${GENTOO_PATCHDIR}/conf/modules.d/41_mod_ssl.default-vhost.conf
	fi

	# drop in a convenient link to the manual
	if useq doc; then
		insinto /etc/apache2/modules.d
		doins ${GENTOO_PATCHDIR}/conf/modules.d/00_apache_manual.conf
		sed -i -e "s:2.0.49:${PVR}:" ${D}/etc/apache2/modules.d/00_apache_manual.conf
	else
		rm -rf ${D}/usr/share/doc/${PF}/manual
	fi

	# SLOT=2
	cd ${D}
	for i in htdigest htpasswd logresolve apxs ab rotatelogs dbmmanage checkgid split-logfile; do
		mv -v usr/sbin/${i} usr/sbin/${i}2
	done
	mv -v usr/sbin/apachectl usr/sbin/apache2ctl
	mv -v usr/sbin/list_hooks.pl usr/sbin/list_hooks2.pl
	mv -v usr/sbin/logresolve.pl usr/sbin/logresolve2.pl
	useq ssl && mv -v usr/sbin/ab-ssl usr/sbin/ab2-ssl
	useq no-suexec || mv -v usr/sbin/suexec usr/sbin/suexec2

	# do the man pages
	for i in htdigest.1 htpasswd.1 dbmmanage.1; do
		mv -v usr/share/man/man1/${i} usr/share/man/man1/${i/./2.}
	done
	for i in ab.8 apxs.8 logresolve.8 rotatelogs.8; do
		mv -v usr/share/man/man8/${i} usr/share/man/man8/${i/./2.}
	done
	useq no-suexec || mv -v usr/share/man/man8/suexec.8 usr/share/man/man8/suexec2.8
	mv -v usr/share/man/man8/apachectl.8 usr/share/man/man8/apache2ctl.8
	mv -v usr/share/man/man8/httpd.8 usr/share/man/man8/apache2.8

	# tidy up
	mv usr/sbin/envvars* usr/$(get_libdir)/apache2/build
	dodoc etc/apache2/*-std.conf
	rm -f etc/apache2/*.conf
	rm -f etc/apache2/mime.types
	rm -rf var/run var/log

	# we DEPEND on net-www/gentoo-webroot-default for sharing this by now
	rm -rf var/www/localhost

	# config files
	newconfd ${GENTOO_PATCHDIR}/init/apache2.confd apache2
	newinitd ${GENTOO_PATCHDIR}/init/apache2.initd apache2

	insinto /etc/logrotate.d
	newins ${GENTOO_PATCHDIR}/scripts/apache2-logrotate apache2

	insinto /etc/apache2
	doins ${GENTOO_PATCHDIR}/conf/apache2-builtin-mods
	doins ${GENTOO_PATCHDIR}/conf/httpd.conf

	insinto /etc/apache2/vhosts.d
	doins ${GENTOO_PATCHDIR}/conf/vhosts.d/00_default_vhost.conf

	keepdir /etc/apache2/vhosts.d
	keepdir /etc/apache2/modules.d

	# fix bug 92348
	fperms 755 /usr/sbin/apache2logserverstatus
	fperms 755 /usr/sbin/apache2splitlogfile

	# empty dirs
	for i in /var/lib/dav /var/log/apache2 /var/cache/apache2; do
		keepdir ${i}
		fowners apache:apache ${i}
		fperms 755 ${i}
	done

	# We'll be needing /etc/apache2/ssl if USE=ssl
	useq ssl && keepdir /etc/apache2/ssl

}

pkg_postinst() {
	# setup apache user and group
	# we do this twice for binary packages
	enewgroup apache 81
	enewuser apache 81 -1 /var/www apache

	# Automatically generate test ceritificates if ssl USE flag is being set
	if useq ssl -a !-e ${ROOT}/etc/apache2/ssl/server.crt; then
		cd ${ROOT}/etc/apache2/ssl
		einfo
		einfo "Generating self-signed test certificate in /etc/apache2/ssl..."
		yes "" 2>/dev/null | \
			${ROOT}/usr/sbin/gentestcrt.sh >/dev/null 2>&1 || \
			die "gentestcrt.sh failed"
		einfo
	fi

	# Check for dual/upgrade install
	if has_version '=net-www/apache-1*' || ! use apache2 ; then
		ewarn
		ewarn "Please add the 'apache2' flag to your USE variable and (re)install"
		ewarn "any additional DSO modules you may wish to use with Apache-2.x."
		ewarn "Addon modules are configured in /etc/apache2/modules.d/"
		ewarn
	fi

	# Check for obsolete symlinks
	local list=""
	for i in lib logs modules extramodules; do
		local d="/etc/apache2/${i}"
		[ -s "${d}" ] && list="${list} ${d}"
	done
	[ -n "${list}" ] && einfo "You should delete these old symlinks: ${list}"

	if has_version '<net-www/apache-2.0.54-r30' && has_version '>=net-www/apache-2.0.0' ; then
		einfo "Configuration locations have changed, you will need to migrate"
		einfo "your configuration from /etc/apache2/conf/apache2.conf and"
		einfo "/etc/apache2/conf/commonapache2.conf to /etc/apache2/httpd.conf."
		einfo
		einfo "Apache now checks for the old configuration and refuses to start"
		einfo "if it exists. You must remove the old configuration first"
		einfo
		einfo "You should also at this time rebuild all your modules"
		einfo
		einfo "For more information, see"
		einfo "    http://www.gentoo.org/doc/en/apache-upgrading.xml"
		einfo
	fi

	big_fat_warnings
}

setup_apache_vars() {
	# actually we do not provide a very dynamic way of those vars
	# however, you may predefine them in shell before emerging
	# to override the official default locations

	# standard location for Gentoo Linux
	DATADIR="${DATADIR:-/var/www/localhost}"
	USERDIR="${USERDIR:-public_html}"

	einfo "DATADIR is set to: ${DATADIR}"
	einfo "USERDIR is set to: ${USERDIR}"
}

mpm_die() {
	eerror "You attempted to specify the MPM $1, but MPM $2 was already specified."
	eerror "The apache ebuilds no longer support multiple MPM installations.  Please choose"
	eerror "one MPM and reinstall."
	die "More than one MPM was specified."
}

try_mpm() {
	local nmpm=$1

	if [ -z "${nmpm}" ]; then
		die "mpm to try not specified!"
	fi

	if [ "x${mpm}" != "x" -a "x${mpm}" != "x${nmpm}" ]; then
		mpm_die ${nmpm} ${mpm}
	fi

	mpm="${nmpm}"
}

select_mpms() {
	useq mpm-prefork && try_mpm prefork
	useq mpm-worker && try_mpm worker
	useq mpm-peruser && try_mpm peruser
	useq mpm-threadpool && try_mpm threadpool
	useq mpm-leader && try_mpm leader

	if [ "x${mpm}" = "x" ]; then
		if useq threads; then
			einfo "Threads specified without a mpm-specification, using mpm-worker."
			mpm="worker"
		else
			einfo "No MPM style was specified, defaulting to mpm-prefork."
			mpm="prefork"
		fi
	fi
}

parse_modules_config() {
	local name=""
	local disable=""
	[ -f ${1} ] || return 1

	for i in `cat $1 | sed "s/^#.*//"`; do
		if [ $i == "-" ]; then
			disable="true"
		elif [ -z "$name" ] && [ ! -z "`echo $i | grep "mod_"`" ]; then
			name=`echo $i | sed "s/mod_//"`
		elif [ "$disable" ] && ( [ $i == "static" ] || [ $i == "shared" ] ); then
			MY_BUILTINS="${MY_BUILTINS} --disable-$name"
			name="" ; disable=""
		elif [ $i == "static" ] || useq static-modules; then
			MY_BUILTINS="${MY_BUILTINS} --enable-$name=yes"
			name="" ; disable=""
		elif [ $i == "shared" ]; then
			MY_BUILTINS="${MY_BUILTINS} --enable-$name=shared"
			name="" ; disable=""
		fi
	done

	einfo "${1} options:\n${MY_BUILTINS}"
}

select_modules_config() {
	parse_modules_config /etc/apache2/apache2-builtin-mods || \
	parse_modules_config ${GENTOO_PATCHDIR}/conf/apache2-builtin-mods || \
	return 1
}

# vim:ts=4
