# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-core/nagios-core-1.2-r3.ebuild,v 1.5 2004/10/22 10:47:01 eldad Exp $

inherit eutils

MY_P=${P/-core}
DESCRIPTION="Nagios Core - Check daemon, CGIs, docs"
HOMEPAGE="http://www.nagios.org/"
SRC_URI="mirror://sourceforge/nagios/${MY_P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE="noweb mysql postgres perl debug apache2"

DEPEND="virtual/mailx
	!noweb? (
		>=media-libs/jpeg-6b-r3
		>=media-libs/libpng-1.2.5-r4
		>=media-libs/gd-1.8.3-r5

		apache2? ( >=net-www/apache-2.0.43-r1 )
		!apache2? ( <net-www/apache-2 )
	)

	perl? ( >=dev-lang/perl-5.6.1-r7 )
	mysql? ( >=dev-db/mysql-3.23.56 )
	postgres? ( !mysql? ( >=dev-db/postgresql-7.3.2 ) )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	# If there's a gd lib on the system, it will try to build with it.
	# check if gdlib-config is on, and then check its output.
	if [[ -x /usr/bin/gdlib-config ]]; then
		if [[ ! $(gdlib-config --libs | grep -- -ljpeg) ]]; then
			eerror "Your gd has been compiled without jpeg support."
			eerror "Please re-emerge gd:"
			eerror "# USE="jpeg" emerge gd"
			die "pkg_setup failed"
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/submit_check_result_via_nsca.patch

	epatch ${FILESDIR}/Makefile-distclean.diff.bz2
	cp ${FILESDIR}/nagios.cfg-sample.gz ./
	gunzip nagios.cfg-sample.gz
}

src_compile() {
	local myconf

	if use mysql && use postgres; then
		ewarn "Unfortunatly you can't have both MySQL and PostgreSQL enabled at the same time."
		ewarn "Using MySQL as default."

		has_version ">=sys-apps/portage-2.0.50" && (
			einfo "You can add -"
			echo ""
			einfo "net-analyzer/nagios-core [use flags]"
			echo ""
			einfo "to /etc/portage/package.use to permanently set this package's USE flags"
			einfo "More info on package.use is available on:"
			einfo "     man 5 portage"
		)
	elif use postgres ; then
		myconf="${myconf} --with-pgsql-xdata"

		if [ -r /usr/include/postgresql/pgsql/libpq-fe.h ] ; then
			myconf="${myconf} --with-pgsql-inc=/usr/include/postgresql"
		fi
	fi

	use mysql && myconf="${myconf} --with-mysql-xdata"

	use perl && myconf="${myconf} \
		--enable-embedded-perl \
		--with-perlcache"

	if use debug; then
		myconf="${myconf} --enable-DEBUG0"
		myconf="${myconf} --enable-DEBUG1"
		myconf="${myconf} --enable-DEBUG2"
		myconf="${myconf} --enable-DEBUG3"
		myconf="${myconf} --enable-DEBUG4"
		myconf="${myconf} --enable-DEBUG5"
	fi

	if use noweb; then
		myconf="${myconf} --with-command-grp=nagios"
	else
		myconf="${myconf} --with-command-grp=apache"
	fi

	./configure ${myconf} \
		--host=${CHOST} \
		--prefix=/usr/nagios \
		--localstatedir=/var/nagios \
		--sysconfdir=/etc/nagios \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "./configure failed"

	make DESTDIR=${D} nagios contrib || die "make failed"

	use noweb || make DESTDIR=${D} cgis # Only compile the CGI's if "noweb" useflag is not set.
}

src_install() {
	dodoc Changelog INSTALLING LEGAL LICENSE README UPGRADING

	if use noweb; then
		sed -i -e 's/cd $(SRC_CGI) && $(MAKE) $@/# line removed due to noweb use flag/' Makefile
		sed -i -e 's/cd $(SRC_HTM) && $(MAKE) $@/# line removed due to noweb use flag/' Makefile
	fi

	make DESTDIR=${D} install
	make DESTDIR=${D} install-config
	make DESTDIR=${D} install-commandmode

	docinto sample-configs
	dodoc ${D}/etc/nagios/*
	rm ${D}/etc/nagios/*

	dodoc ${S}/nagios.cfg-sample

	exeinto /etc/init.d
	doexe ${FILESDIR}/nagios

	insinto /etc/conf.d
	newins ${FILESDIR}/conf.d nagios

	insinto /usr/nagios/contrib
	doins contrib/*

	#contribs are not configured by the configure script, we'll configure them overselves...
	find ${S}/contrib/ -type f | xargs sed -e 's:/usr/local/nagios/var/rw:/var/nagios/rw:;
						s:/usr/local/nagios/libexec:/usr/nagios/libexec:;
						s:/usr/local/nagios/etc:/etc/nagios:;
						s:/usr/local/nagios/sbin:/usr/nagios/sbin:;' -i

	insinto /usr/nagios/contrib/database
	doins contrib/database/*

	exeinto /usr/nagios/contrib/eventhandlers
	doexe contrib/eventhandlers/*

	exeinto /usr/nagios/contrib/eventhandlers/distributed-monitoring
	doexe contrib/eventhandlers/distributed-monitoring/*

	exeinto /usr/nagios/contrib/eventhandlers/redundancy-scenario1
	doexe contrib/eventhandlers/redundancy-scenario1/*

	for dir in etc/nagios usr/nagios var/nagios usr/nagios/contrib
	do
		chown -R nagios:nagios ${D}/${dir} || die "Failed chown of ${D}/${dir}"
	done

	#Apache Module
	if use !noweb; then
		if use apache2; then
			insinto /etc/apache2/conf/modules.d
			doins ${FILESDIR}/99_nagios.conf
		else
			insinto /etc/apache/conf/addon-modules
			doins ${FILESDIR}/nagios.conf
		fi
	fi
}

pkg_preinst() {
	einfo "Sample config files installed by default will always"
	einfo "include cgi.cfg"
	einfo "The sample configs can be found in /usr/share/doc/${PF}/sample-configs/"

	keepdir /var/nagios
	keepdir /var/nagios/archives
	keepdir /usr/nagios/share/ssi
	keepdir /var/nagios/rw

	enewgroup nagios

	if use noweb; then
		enewuser nagios -1 /bin/bash /dev/null nagios
		chown nagios:nagios ${D}/var/nagios/rw || die "Failed Chown of ${D}/var/nagios/rw"
	else
		enewuser nagios -1 /bin/bash /dev/null apache
		usermod -G apache nagios
		chown nagios:apache ${D}/var/nagios/rw || die "Failed Chown of ${D}/var/nagios/rw"
	fi
}

pkg_postinst() {
	einfo
	einfo "Remember to edit the config files in /etc/nagios"
	einfo "Also, if you want nagios to start at boot time"
	einfo "remember to execute:"
	einfo "  rc-update add nagios default"
	einfo

	if use !noweb; then
		einfo "This does not include cgis that are perl-dependent"
		einfo "Currently traceroute.cgi is perl-dependent"
		einfo "To have ministatus.cgi requires copying of ministatus.c"
		einfo "to cgi directory for compiling."

		if use apache2; then
			einfo " Edit /etc/conf.d/apache2 and add \"-D NAGIOS\""
		else
			einfo " Edit /etc/conf.d/apache and add \"-D NAGIOS\""
			einfo " Edit /etc/apache/conf/apache.conf and add \"Include  conf/addon-modules/nagios.conf\""
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

	if use mysql && use postgres; then
		ewarn "Unfortunatly you can't have both MySQL and PostgreSQL enabled at the same time."
		ewarn "as a default, MySQL support was built."
		ewarn "To build nagios with PostgreSQL you'll have to emerge nagios without the mysql useflag."
	fi

	einfo
	einfo "If you are using distributed monitoring, check the contrib scripts."
	einfo "configure the central nagios server for the nsca in /etc/conf.d/nagios."
	einfo
	einfo "If your kernel has /proc protection, nagios"
	einfo "will not be happy as it relies on accessing the proc"
	einfo "filesystem. You can fix this by adding nagios into"
	einfo "the group wheel, but this is not recomended."
	einfo
}

pkg_prerm() {
	/etc/init.d/nagios stop
}
