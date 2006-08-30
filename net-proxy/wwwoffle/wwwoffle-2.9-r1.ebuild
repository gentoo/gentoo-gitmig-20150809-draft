# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/wwwoffle/wwwoffle-2.9-r1.ebuild,v 1.5 2006/08/30 19:50:59 corsair Exp $

inherit eutils

DESCRIPTION="wwwoffle = WWW Offline Explorer, an adv. caching proxy especially suitable for nonpermanent (e.g. dialup) Internet connections"
SRC_URI="http://www.gedanken.freeserve.co.uk/download-wwwoffle/${P}.tgz"
HOMEPAGE="http://www.gedanken.demon.co.uk/wwwoffle"

KEYWORDS="~amd64 ppc ppc64 sparc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="gnutls ipv6 zlib"

RDEPEND="gnutls? ( net-libs/gnutls )
	zlib? ( sys-libs/zlib )"
DEPEND="dev-lang/perl
	sys-devel/flex
	${RDEPEND}"

# Unsure whether to depend on >=www-misc/htdig-3.1.6-r4 or not

pkg_setup() {
	# Add a wwwoffle user
	enewgroup wwwoffle
	enewuser wwwoffle -1 -1 /var/spool/wwwoffle wwwoffle
}

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-gcc41.patch"
	epatch "${FILESDIR}/${P}-reload.patch"
	sed -i -e 's#$(TAR) xpf #$(TAR) --no-same-owner -xpf #' \
		"${S}/cache/Makefile.in"
}

src_compile() {
	# TODO confdir back to default /etc/wwwoffle
	# allows to change config file using web interface.

	econf $(use_with zlib) $(use_with gnutls) \
		$(use_with ipv6) || die "econf failed"
	emake || die "emake failed"

	if [ -f "${ROOT}/etc/wwwoffle.conf" ] ;	then
		einfo "Upgrading current configuration file"
		cp "${ROOT}/etc/wwwoffle.conf" conf/wwwoffle.conf
		conf/upgrade-config.pl conf/wwwoffle.conf

		# Hack to stop regeneration of config file
		touch conf/conf-file

		einfo "Changing the default user (and group) to wwwoffle"
		sed -i -e 's/\(run-[gu]id\)[ \t]*=[ \t]*[a-zA-Z0-9]*[ \t]*$/\1 = wwwoffle/g' \
			conf/wwwoffle.conf
	else
		einfo "Changing the default user (and group) to wwwoffle"
		sed -i -e 's/#\(run-[gu]id\)[ \t]*=[ \t]*[a-zA-Z0-9]*[ \t]*$/\1 = wwwoffle/g' \
			conf/wwwoffle.conf.template
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# documentation fix
	# del empty doc dirs
	rmdir "${D}/usr/doc/${PN}"/{it,nl,ru}
	dodir /usr/share/doc
	mv "${D}/usr/doc/wwwoffle" "${D}/usr/share/doc/${PF}"

	#Updated configuration file
	#if [ -f "${ROOT}/etc/wwwoffle.conf" ]; then
	#	mv "${D}/etc/wwwoffle.conf" "${D}/etc/wwwoffle.conf.updated"
	#fi

	# install the wwwoffled init script
	newinitd "${FILESDIR}/${PN}.initd" wwwoffled
	newinitd "${FILESDIR}/${PN}-online.initd" wwwoffled-online
	newconfd "${FILESDIR}/${PN}-online.confd" wwwoffled-online

	keepdir /var/spool/wwwoffle/{http,outgoing,monitor,lasttime,lastout,local}
	for number in 1 2 3 4 5 6 7 8 9; do
		keepdir "/var/spool/wwwoffle/prevtime${number}" "/var/spool/wwwoffle/prevout${number}"
	done

	# empty dirs are removed during update
	keepdir \
		/var/spool/wwwoffle/search/{mnogosearch/db,htdig/tmp,htdig/db-lasttime,htdig/db,namazu/db}

	touch \
		"${D}/var/spool/wwwoffle/search/htdig/wwwoffle-htdig.log" \
		"${D}/var/spool/wwwoffle/search/mnogosearch/wwwoffle-mnogosearch.log" \
		"${D}/var/spool/wwwoffle/search/namazu/wwwoffle-namazu.log"

	chown -R wwwoffle:wwwoffle "${D}/var/spool/wwwoffle" "${D}/etc/wwwoffle"

	# TODO htdig indexing as part of initscripts

	# robots.txt modification - /var/spool/wwwoffle/html/en
	# 		- remove Disallow: /index
	sed -i -e "s|Disallow:.*/index|#Disallow: /index|" "${D}/var/spool/wwwoffle/html/en/robots.txt"

	rmdir "${D}/usr/doc"
	chmod -R o-w "${D}/var/spool/wwwoffle" #some file have w permission for world!
}

pkg_preinst() {
	# Add a wwwoffle user - required here for binary packages
	enewgroup wwwoffle
	enewuser wwwoffle -1 -1 /var/spool/wwwoffle wwwoffle

	# TODO maybe rootjail ${ROOT}
	source /etc/init.d/functions.sh
	if [ -L "${svcdir}/started/wwwoffled" ]; then
		einfo "The wwwoffled init script is running. I'll stop it, merge the new files and
		restart the script."
		/etc/init.d/wwwoffled stop
		# Just to be sure...
		start-stop-daemon --stop --quiet --name wwwoffled
		touch "${T}/stopped"
	fi
}

pkg_postinst() {
	# fix permissions for those upgrading

	for number in 1 2 3 4 5 6 7 8 9;
	do
		[ ! -d "${ROOT}/var/spool/wwwoffle/prevtime${number}" ] && \
			keepdir "${ROOT}/var/spool/wwwoffle/prevtime${number}"
		[ ! -d "${ROOT}/var/spool/wwwoffle/prevout${number}" ] && \
			keepdir "${ROOT}/var/spool/wwwoffle/prevout${number}"
	done

	chown -R wwwoffle:wwwoffle "${ROOT}/var/spool/wwwoffle" "${ROOT}/etc/wwwoffle"

	# Need to sumbit patch upstream to allow this.
	#fowners root:wwwoffle /var/spool/wwwoffle
	#fowners wwwoffle:wwwoffle /var/spool/wwwoffle

	[ -f "${T}/stopped" ] && \
		ewarn "wwwoffled was stopped. /etc/init.d/wwwoffled start to restart AFTER etc-update"

	einfo "wwwoffled should run as an ordinary user now. The run-uid and run-gid should be set"
	einfo "to \"wwwoffle\" in your /etc/wwwoffle/wwwoffle.conf. Please uncomment this if it hasn't been already"

	einfo "This is for your own security. Otherwise wwwoffle is run as root which is relay bad if"
	einfo "there is an exploit in this program that allows remote/local users to execute arbitary"
	einfo "commands as the root user."

	if [ -f "${ROOT}/etc/wwwoffle.conf" ]; then
		ewarn "Configuration file is /etc/wwwoffle/wwwoffle.conf now"
		ewarn "Suggest you move ${ROOT}etc/wwwoffle.conf"
	fi

	# if htdig - run script for full database index
	# TODO
}
