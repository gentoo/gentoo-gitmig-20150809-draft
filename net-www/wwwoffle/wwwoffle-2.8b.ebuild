# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/wwwoffle/wwwoffle-2.8b.ebuild,v 1.1 2004/04/25 00:44:10 dragonheart Exp $

inherit eutils

DESCRIPTION="wwwoffle = WWW Offline Explorer, an adv. caching proxy especially suitable for nonpermanent (e.g. dialup) Internet connections"

SRC_URI="ftp://ftp.demon.co.uk/pub/unix/httpd/${P}.tgz
	ftp://ftp.ibiblio.org/pub/Linux/apps/www/servers/${P}.tgz"

HOMEPAGE="http://www.gedanken.demon.co.uk/wwwoffle"
KEYWORDS="~x86 ~sparc ~ppc ~ppc64"
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
	virtual/glibc
	app-arch/tar"

RDEPEND="sys-libs/zlib
	virtual/glibc"

pkg_setup() {
	# Add a wwwoffle user
	enewgroup wwwoffle
	enewuser wwwoffle -1 /bin/false /var/spool/wwwoffle wwwoffle
}

src_unpack(){
	unpack ${A}
	cd ${S}
	sed -i -e 's#$(TAR) xpf #$(TAR) --no-same-owner -xpf #' cache/Makefile.in
	sed -i -e "s#^docdir=.*#docdir=\$(DESTDIR)\${prefix}/share/doc/${P}#" doc/Makefile.in
	# change to user wwwoffle
	sed -i -e 's/\(run-[gu]id\)[ \t]*=[ \t]*[a-zA-Z0-9]*[ \t]*$/\1 = wwwoffle/g' \
		conf/wwwoffle.conf

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
}

src_install() {
	emake DESTDIR=${D} install || die

	# install the wwwoffled init script
	exeinto /etc/init.d
	doexe ${FILESDIR}/{wwwoffled-online,wwwoffled}

	# keep spool
	keepdir /var/spool/wwwoffle/{http,outgoing,monitor,lasttime,prevtime1,lastout,local}

	# empty dirs are removed during update
	keepdir \
	/var/spool/wwwoffle/search/{mnogosearch/db,htdig/tmp,htdig/db-lasttime,htdig/db,namazu/db}

	# del empty doc dirs
	rmdir ${D}/usr/share/doc/${P}/{it,nl,ru}

	chown -R wwwoffle:wwwoffle \
		${D}/var/spool/wwwoffle/{http,outgoing,monitor,lasttime,prevtime1,lastout,local} \
	${D}/var/spool/wwwoffle/search/{mnogosearch/db,htdig/tmp,htdig/db-lasttime,htdig/db,namazu/db}

	# for those upgrading...
	[ -f ${ROOT}/etc/wwwoffle.conf ] && \
		sed -e 's/\(run-[gu]id\)[ \t]*=[ \t]*[a-zA-Z0-9]*[ \t]*$/\1 = wwwoffle/g' \
			${ROOT}/etc/wwwoffle.conf \
			${D}/etc/wwwoffle/wwwoffle.conf
}

pkg_preinst() {

	# TODO rootjail ${ROOT}
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

pkg_postinst() {
	# fix permissions for those upgrading
	chown -R wwwoffle:wwwoffle \
		${D}/var/spool/wwwoffle/{http,outgoing,monitor,lasttime,prevtime1,lastout,local} \
	${D}/var/spool/wwwoffle/search/{mnogosearch/db,htdig/tmp,htdig/db-lasttime,htdig/db,namazu/db}

	[ -f ${T}/stopped ] && \
		ewarn "wwwoffled was stopped. /etc/init.d/wwwoffled start to restart AFTER etc-update"
}
