# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-core/nagios-core-1.3.ebuild,v 1.7 2006/04/17 00:16:27 eldad Exp $

inherit eutils apache-module toolchain-funcs

MY_P=${P/-core}
DESCRIPTION="Nagios Core - Check daemon, CGIs, docs"
HOMEPAGE="http://www.nagios.org/"
SRC_URI="mirror://sourceforge/nagios/${MY_P}.tar.gz
	mirror://gentoo/nagios-1.x-Makefile-distclean-gentoo.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 sparc x86"
IUSE="noweb mysql postgres perl debug apache2"

DEPEND="virtual/mailx
	!noweb? (
		>=media-libs/jpeg-6b-r3
		>=media-libs/libpng-1.2.5-r4
		>=media-libs/gd-1.8.3-r5
		${NEED_APACHE_DEPEND}
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

	enewgroup nagios

	if use noweb; then
		enewuser nagios -1 /bin/bash /dev/null nagios
	else
		enewuser nagios -1 /bin/bash /dev/null apache
		usermod -G apache nagios
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${WORKDIR}/nagios-1.x-Makefile-distclean-gentoo.diff

	# libpq-fe.h isnt in psgql/ 
	cd xdata/
	sed -i -e "s:pgsql/::" *.c
}

src_compile() {
	local myconf

	if use mysql && use postgres; then
		ewarn "Unfortunatly you can't have both MySQL and PostgreSQL enabled at the same time."
		ewarn "Using MySQL as default."

		has_version ">=sys-apps/portage-2.0.50" && (
			einfo "You can add -"
			echo
			einfo "net-analyzer/nagios-core [use flags]"
			echo
			einfo "to /etc/portage/package.use to permanently set this package's USE flags"
			einfo "More info on package.use is available on:"
			einfo "     man 5 portage"
		)
	elif use postgres ; then
		myconf="${myconf} \
			--with-pgsql-xdata \
			--with-pgsql-status \
			--with-pgsql-comments \
			--with-pgsql-extinfo \
			--with-pgsql-retention \
			--with-pgsql-downtime"

		if [ -r /usr/include/postgresql/libpq-fe.h ] ; then
			myconf="${myconf} --with-pgsql-inc=/usr/include/postgresql"
		fi
	fi

	use mysql && myconf="${myconf} \
		--with-file-perfdata \
		--with-template-extinfo \
		--with-mysql-xdata \
		--with-mysql-status \
		--with-mysql-comments \
		--with-mysql-retention \
		--with-mysql-downtime"

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

	make CC=$(tc-getCC) DESTDIR=${D} nagios contrib || die "make failed"

	if use !noweb ; then
		# Only compile the CGI's if "noweb" useflag is not set.
		make CC=$(tc-getCC) DESTDIR=${D} cgis || die
	fi

	emake -C contrib all || "contrib make filed"
}

src_install() {
	dodoc Changelog INSTALLING LEGAL LICENSE README UPGRADING contrib/htaccess.sample
	docinto contrib
	dodoc contrib/README

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

	# contribs are not configured by the configure script, we'll configure them overselves...
	find ${S}/contrib/ -type f | xargs sed -e 's:/usr/local/nagios/var/rw:/var/nagios/rw:;
						s:/usr/local/nagios/libexec:/usr/nagios/libexec:;
						s:/usr/local/nagios/etc:/etc/nagios:;
						s:/usr/local/nagios/sbin:/usr/nagios/sbin:;' -i

	insinto /usr/share/doc/${PF}/contrib
	doins -r contrib/database contrib/eventhandlers

	exeinto /etc/init.d
	doexe ${FILESDIR}/nagios

	insinto /etc/conf.d
	newins ${FILESDIR}/conf.d nagios

	chmod 644 ${S}/contrib/*.cgi
	into /usr/nagios
	for bin in `find contrib/ -type f -perm 0755 -maxdepth 1` ; do
		dobin $bin
	done

	# Apache Module
	if use !noweb; then
		if use apache2; then
			insinto ${APACHE2_MODULES_CONFDIR}
			doins ${FILESDIR}/99_nagios.conf
		else
			insinto ${APACHE1_MODULES_CONFDIR}
			doins ${FILESDIR}/nagios.conf
		fi
		if use perl; then
			into /usr/nagios
			for cgi in `find contrib/ -name "*.cgi" -maxdepth 1` ; do
				dosbin $cgi
			done
		fi
	fi

	for dir in etc/nagios usr/nagios var/nagios ; do
		chown -R nagios:nagios ${D}/${dir} || die "Failed chown of ${D}/${dir}"
	done

	keepdir /etc/nagios
	keepdir /var/nagios
	keepdir /var/nagios/archives
	keepdir /usr/nagios/share/ssi
	keepdir /var/nagios/rw
}

pkg_preinst() {
	if use noweb; then
		chown nagios:nagios ${D}/var/nagios/rw || die "Failed Chown of ${D}/var/nagios/rw"
	else
		chown nagios:apache ${D}/var/nagios/rw || die "Failed Chown of ${D}/var/nagios/rw"
	fi

	chmod 2750 ${D}/var/nagios/rw || die "Failed Chmod of ${D}/var/nagios/rw"
	chmod 0750 ${D}/etc/nagios || die "Failed chmod of ${D}/etc/nagios"
}

pkg_postinst() {
	einfo
	einfo "The example config files are located at /usr/share/doc/${PF}/sample-configs/."
	einfo
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
