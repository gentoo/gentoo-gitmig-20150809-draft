# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/wwwoffle/wwwoffle-2.8b.ebuild,v 1.9 2004/07/28 01:44:21 dragonheart Exp $

inherit eutils

DESCRIPTION="wwwoffle = WWW Offline Explorer, an adv. caching proxy especially suitable for nonpermanent (e.g. dialup) Internet connections"

SRC_URI="ftp://ftp.demon.co.uk/pub/unix/httpd/${P}.tgz
	ftp://ftp.ibiblio.org/pub/Linux/apps/www/servers/${P}.tgz"

HOMEPAGE="http://www.gedanken.demon.co.uk/wwwoffle"
KEYWORDS="x86 sparc ~ppc ~ppc64"
SLOT="0"
LICENSE="GPL-2"
IUSE="ipv6"

DEPEND=">=sys-apps/sed-4
	sys-apps/gawk
	sys-apps/grep
	dev-lang/perl
	sys-devel/flex
	sys-libs/zlib
	sys-devel/gcc
	virtual/libc
	app-arch/tar"

RDEPEND="sys-libs/zlib
	virtual/libc"

src_unpack(){
	unpack ${A}
	cd ${S}
	sed -i -e 's#$(TAR) xpf #$(TAR) --no-same-owner -xpf #' cache/Makefile.in
	sed -i -e "s#^docdir=.*#docdir=\$(DESTDIR)\${prefix}/share/doc/${P}#" doc/Makefile.in


	### adjust path for htdig - /usr/share/webapps/${PF}/cgi-bin/ 
	## (as per http://www.gentoo.org/proj/en/glep/glep-0011.html)
	## Not impliemented yet.

	echo '/usr/share/webapps/*/cgi-bin/htsearch -c /var/spool/wwwoffle/search/htdig/conf/htsearch.conf' \
		>  cache/search/htdig/scripts/wwwoffle-htsearch
	chmod a+x cache/search/htdig/scripts/wwwoffle-htsearch
}

src_compile() {

	local myconf
	myconf="`use_with ipv6`"
	econf --with-confdir=/etc ${myconf} || die
	emake || die

	local conffile=conf/wwwoffle.conf.template
	if [ -f ${ROOT}/etc/wwwoffle.conf ]
	then
		einfo "Upgrading current configuration file"
		cp ${ROOT}/etc/wwwoffle.conf conf/wwwoffle.conf
		conf/upgrade-config.pl conf/wwwoffle.conf
		# Hack to stop regeneration of config file
		touch conf/conf-file
		conffile=conf/wwwoffle.conf
	fi
	# change to user wwwoffle
	einfo "Changing the default user (and group) to wwwoffle"
	sed -i -e 's/\(run-[gu]id\)[ \t]*=[ \t]*[a-zA-Z0-9]*[ \t]*$/\1 = wwwoffle/g' \
		${conffile}
}

pkg_preinst() {

	# Add a wwwoffle user - required here for binary packages
	enewgroup wwwoffle
	enewuser wwwoffle -1 /bin/false /var/spool/wwwoffle wwwoffle

	# TODO maybe rootjail ${ROOT}
	source /etc/init.d/functions.sh
	if [ -L ${svcdir}/started/wwwoffled ]; then
		einfo "The wwwoffled init script is running. I'll stop it, merge the new files and
		restart the script."
		/etc/init.d/wwwoffled stop
		# Just to be sure...
		start-stop-daemon --stop --quiet --name wwwoffled
		touch ${T}/stopped
	fi
}


src_install() {
	emake DESTDIR=${D} install || die

	# install the wwwoffled init script
	exeinto /etc/init.d
	doexe ${FILESDIR}/wwwoffled
	newexe  ${FILESDIR}/wwwoffled-online-${PV} wwwoffled-online

	# keep spool
	keepdir /var/spool/wwwoffle/{http,outgoing,monitor,lasttime,prevtime[1-9],prevout[1-9],lastout,local}

	fowners root:wwwoffle /var/spool/wwwoffle
	# empty dirs are removed during update
	keepdir \
	/var/spool/wwwoffle/search/{mnogosearch/db,htdig/tmp,htdig/db-lasttime,htdig/db,namazu/db}

	# del empty doc dirs
	rmdir ${D}/usr/share/doc/${P}/{it,nl,ru}

	chown -R wwwoffle:wwwoffle \
	${D}/var/spool/wwwoffle/{http,outgoing,monitor,lasttime,prevtime[1-9],prevout[1-9],lastout,local} \
	${D}/var/spool/wwwoffle/search/{mnogosearch/db,htdig/tmp,htdig/db-lasttime,htdig/db,namazu/db}

	dodir /etc/conf.d
	local config=${D}/etc/conf.d/wwwoffled-online
	echo -e "\n\n# Enter the interface that connects you to the outside world" >> ${config}
	echo '# This will correspond to /etc/init.d/net.${IFACE}' >> ${config}
	echo -e "\n# IMPORTANT: Be sure to run depscan.sh after modifiying IFACE" >>  ${config}
	echo "IFACE=ppp0" >> ${config}

}

pkg_postinst() {
	# fix permissions for those upgrading
	chown -R wwwoffle:wwwoffle \
	${ROOT}/var/spool/wwwoffle/{http,outgoing,monitor,lasttime,prevtime[1-9],prevout[1-9],lastout,local} \
	${ROOT}/var/spool/wwwoffle/search/{mnogosearch/db,htdig/tmp,htdig/db-lasttime,htdig/db,namazu/db}

	chown root:wwwoffle /var/spool/wwwoffle
	[ -f ${T}/stopped ] && \
		ewarn "wwwoffled was stopped. /etc/init.d/wwwoffled start to restart AFTER etc-update"


	einfo "wwwoffled should run as an ordinary user now. The run-uid and run-gid should be set"
	einfo "to \"wwwoffle\" in your /etc/wwwoffle.conf. Please uncomment this if it hasn't been already"

	einfo "This is for your own security. Otherwise wwwoffle is run as root which is relay bad if"
	einfo "there is an exploit in this program that allows remote/local users to execute arbitary"
	einfo "commands as the root user."

}
