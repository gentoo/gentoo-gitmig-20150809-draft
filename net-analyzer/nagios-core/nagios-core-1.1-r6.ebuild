# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-core/nagios-core-1.1-r6.ebuild,v 1.2 2004/02/15 11:45:49 tigger Exp $

inherit eutils

DESCRIPTION="Nagios ${PV} core - Host and service monitor cgi, docs etc..."
HOMEPAGE="http://www.nagios.org/"
SRC_URI="mirror://sourceforge/nagios/nagios-1.1.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE="noweb mysql postgres perl debug apache2"

DEPEND=">=net-mail/mailx-8.1
	!noweb? (
		>=media-libs/jpeg-6b-r3
		>=media-libs/libpng-1.2.5-r4
		>=media-libs/libgd-1.8.3-r5

		apache2? ( >=net-www/apache-2.0.43-r1 )
		!apache2? ( <net-www/apache-2 )
	)

	perl? ( >=dev-lang/perl-5.6.1-r7 )
	mysql? ( >=dev-db/mysql-3.23.56 )
	postgres? ( >=dev-db/postgresql-7.3.2 )"

S="${WORKDIR}/nagios-${PV}"

pkg_setup() {
	enewgroup nagios
	enewuser nagios -1 /bin/bash /dev/null nagios
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/Makefile-distclean.diff.bz2
	use noweb || epatch ${FILESDIR}/tac.cgi.diff.bz2
}

src_compile() {
	if [ -n "`use mysql`" -a -n "`use postgres`" ]; then
		eerror "Unfortunatly you can't have both MySQL and PostgreSQL enabled at the same time."
		eerror "You have to remove either 'mysql' or 'postgres' from your USE flags before emerging this."

		has_version ">=sys-apps/portage-2.0.50" && (
			einfo "You can add:"
			einfo "net-analyzer/nagios-core [use flags]"
			einfo "to the file:"
			einfo "/etc/portage/package.use"
			einfo "to permamently set this package's USE flags"
		)

		exit 1
	fi

	local myconf

	use mysql && myconf="${myconf} \
		--with-mysql-xdata \
		--with-mysql-status \
		--with-mysql-comments \
		--with-mysql-extinfo \
		--with-mysql-retention \
		--with-mysql-downtime"

	use postgres && myconf="${myconf} \
		--with-pgsql-xdata \
		--with-pgsql-status \
		--with-pgsql-comments \
		--with-pgsql-extinfo \
		--with-pgsql-retention \
		--with-pgsql-downtime"

	use perl && myconf="${myconf} \
		--enable-embedded-perl \
		--with-perlcache"

	if [ -n "`use debug`" ]; then
		myconf="${myconf} --enable-DEBUG0"
		myconf="${myconf} --enable-DEBUG1"
		myconf="${myconf} --enable-DEBUG2"
		myconf="${myconf} --enable-DEBUG3"
		myconf="${myconf} --enable-DEBUG4"
		myconf="${myconf} --enable-DEBUG5"
	fi

	./configure ${myconf} \
		--host=${CHOST} \
		--prefix=/usr/nagios \
		--localstatedir=/var/nagios \
		--sysconfdir=/etc/nagios \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "./configure failed"

	make DESTDIR=${D} nagios contrib

	use noweb || make DESTDIR=${D} cgis # Only compile the CGI's if "noweb" useflag is not set.
}

src_install() {
	dodoc Changelog INSTALLING LEGAL LICENSE README UPGRADING

	use noweb && (
		sed -i -e 's/cd $(SRC_CGI) && $(MAKE) $@/# line removed due to noweb use flag/' Makefile
		sed -i -e 's/cd $(SRC_HTM) && $(MAKE) $@/# line removed due to noweb use flag/' Makefile
	)

	make DESTDIR=${D} install
	make DESTDIR=${D} install-config
	make DESTDIR=${D} install-commandmode

	docinto sample-configs
	dodoc ${D}/etc/nagios/*
	rm ${D}/etc/nagios/*

	dodoc ${FILESDIR}/nagios.cfg-sample

	exeinto /etc/init.d
	doexe ${FILESDIR}/nagios

	insinto /usr/nagios/contrib
	doins contrib/*

	insinto /usr/nagios/contrib/database
	doins contrib/database/*

	insinto /usr/nagios/contrib/eventhandlers
	doins contrib/eventhandlers/*

	insinto /usr/nagios/contrib/eventhandlers/distributed-monitoring
	doins contrib/eventhandlers/distributed-monitoring/*

	insinto /usr/nagios/contrib/eventhandlers/redundancy-scenario1
	doins contrib/eventhandlers/redundancy-scenario1/*
}

pkg_preinst() {
	einfo "Sample config files installed by default will always"
	einfo "include cgi.cfg"
	einfo "The sample configs can be found in /usr/share/doc/${PF}/sample-configs/"
	chown -R nagios:nagios ${D}/etc/nagios || die "Failed Chown of ${D}/etc/nagios"
	keepdir /usr/nagios/share/ssi
	chown -R nagios:nagios ${D}/usr/nagios || die "Failed Chown of ${D}/usr/nagios"
	keepdir /var/nagios
	keepdir /var/nagios/archives
	chown -R nagios:nagios ${D}/var/nagios || die "Failed Chown of ${D}/var/nagios"
	keepdir /var/nagios/rw
	chown nagios:apache ${D}/var/nagios/rw || die "Failed Chown of ${D}/var/nagios/rw"
}

pkg_postinst() {
	einfo
	einfo "Remember to edit the config files in /etc/nagios"
	einfo "Also, if you want nagios to start at boot time"
	einfo "remember to execute:"
	einfo "  rc-update add nagios default"
	einfo

	if [ -z "`use noweb`"]; then
		einfo "This does not include cgis that are perl-dependent"
		einfo "Currently traceroute.cgi is perl-dependent"
		einfo "To have ministatus.cgi requires copying of ministatus.c"
		einfo "to cgi directory for compiling."

		einfo "1. Execute the command:"
		einfo " \"ebuild /var/db/pkg/net-analyzer/${PF}/${PF}.ebuild config\""

		if [ -z "`use apache2`" ]; then
			insinto /etc/apache2/conf/modules.d
			doins ${FILESDIR}/99_nagios.conf

			einfo " 2. Edit /etc/conf.d/apache and add \"-D NAGIOS\""
		else
			insinto /etc/apache/conf/addon-modules
			doins ${FILESDIR}/nagios.conf
			echo "Include  conf/addon-modules/nagios.conf" >> ${ROOT}/etc/apache/conf/apache.conf

			einfo " 2. Edit /etc/conf.d/apache2 and add \"-D NAGIOS\""
		fi

		einfo
		einfo "That will make nagios's web front end visable via"
		einfo "http://localhost/nagios/"
		einfo
	else
		einfo "Please note that you have installed Nagios without web interface."
		einfo "Please don't file any bugs about having no web interface when you do this."
		einfo "Thank you!"
	fi

	einfo "If your kernel has /proc protection, nagios"
	einfo "will not be happy as it relies on accessing the proc"
	einfo "filesystem. You can fix this by adding nagios into"
	einfo "the group wheel, but this is not recomended."
	einfo
}

pkg_prerm() {
	/etc/init.d/nagios stop
}
