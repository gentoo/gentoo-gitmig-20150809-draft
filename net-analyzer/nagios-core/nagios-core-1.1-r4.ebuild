# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-core/nagios-core-1.1-r4.ebuild,v 1.11 2004/03/21 14:12:18 mboman Exp $

inherit eutils

MY_P=${P/-core}
DESCRIPTION="Nagios core - Host and service monitor cgi, docs etc..."
HOMEPAGE="http://www.nagios.org/"
SRC_URI="mirror://sourceforge/nagios/${MY_P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~amd64"
IUSE="gd apache2 perl mysql postgres debug"

DEPEND=">=net-mail/mailx-8.1
	apache2? ( >=net-www/apache-2.0.43-r1 )
	gd? (
		>=media-libs/jpeg-6b-r3
		>=media-libs/libpng-1.2.5-r4
		>=media-libs/libgd-1.8.3-r5
	)
	perl? ( >=perl-5.6.1-r7 )
	mysql? ( >=dev-db/mysql-3.23.56 )
	postgres? ( >=dev-db/postgresql-7.3.2 )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewgroup nagios
	enewuser nagios -1 /bin/bash /dev/null nagios
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/Makefile-distclean.diff.bz2
	[ `use gd` ] && epatch ${FILESDIR}/tac.cgi.diff.bz2
}

src_compile() {
	local myconf

	use mysql && myconf="${myconf} --with-mysql-xdata \
	--with-mysql-status --with-mysql-comments --with-mysql-extinfo \
	--with-mysql-retention --with-mysql-downtime"

	use postgres && myconf="${myconf} --with-pgsql-xdata \
	--with-pgsql-status --with-pgsql-comments --with-pgsql-extinfo \
	--with-pgsql-retention --with-pgsql-downtime"

	use perl && myconf="${myconf} --enable-embedded-perl --with-perlcache"

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
		emake all || die "make failed"
}

src_install() {
	dodoc Changelog INSTALLING LEGAL LICENSE README UPGRADING
	if [ -n "`use gd`" ]; then
		make DESTDIR=${D} fullinstall install-config || die
		if [ -n "`use apache2`" ]; then
			insinto /etc/apache2/conf/modules.d
			doins ${FILESDIR}/99_nagios.conf
		else
			insinto /etc/apache/conf/addon-modules
			doins ${FILESDIR}/nagios.conf
		fi
	else
		make DESTDIR=${D} fullinstall install-config || die
		rm -rf ${D}/usr/nagios/{sbin,share}/*
	fi
	exeinto /etc/init.d
	doexe ${FILESDIR}/nagios
	insinto /etc/nagios
	doins ${FILESDIR}/nagios.cfg-sample
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
	chown -R nagios:nagios ${D}/etc/nagios || die "Failed Chown of ${D}/etc/nagios"
	keepdir /usr/nagios/share/ssi
	chown -R nagios:nagios ${D}/usr/nagios || die "Failed Chown of ${D}/usr/nagios"
	keepdir /var/nagios/archives
	chown -R nagios:nagios ${D}/var/nagios || die "Failed Chown of ${D}/var/nagios"
	keepdir /var/nagios/rw
	chown nagios:apache ${D}/var/nagios/rw || die "Failed Chown of ${D}/var/nagios/rw"
}

pkg_postinst() {
	einfo
	einfo "Remember to edit the config files in /etc/nagios"
	einfo "Also, if you want nagios to start at boot time"
	einfo "remember to execute rc-update add nagios default"
	einfo
	if [ -n "`use gd`" ]; then
		einfo "This does not include cgis that are perl-dependent"
		einfo "Currently traceroute.cgi is perl-dependent"
		einfo "To have ministatus.cgi requires copying of ministatus.c"
		einfo "to cgi directory for compiling"
		if [ -n "`use apache2`" ]; then
			einfo "To have nagios visable on the web, please do the following:"
			einfo "Edit /etc/conf.d/apache2 and add \"-D NAGIOS\""
			einfo "The Apache2 config file for nagios will be in"
			einfo "/etc/apache2/conf/modules.d with the name of"
			einfo "99_nagios.conf."
		else
			einfo "1. Execute the command:"
			einfo " \"ebuild /var/db/pkg/net-analyzer/${PF}/${PF}.ebuild config\""
			einfo " 2. Edit /etc/conf.d/apache and add \"-D NAGIOS\""
			einfo "The Apache config file for nagios will be in"
			einfo "/etc/apache/conf/addon-modules/ with the name of"
			einfo "nagios.conf."
		fi
		einfo
		einfo "That will make nagios's web front end visable via"
		einfo "http://localhost/nagios/"
		einfo
	fi
	einfo "Also, if your kernel has /proc protection, nagios"
	einfo "will not be happy as it relies on accessing the proc"
	einfo "filesystem. You can fix this by adding nagios into"
	einfo "the group wheel, but this is not recomended."
	einfo
}

pkg_config() {
	if [ "`use gd`" ]; then
		if [ "`use apache2`" ]; then
			einfo "Edit /etc/conf.d/apache2 and add \"-D NAGIOS\""
		fi
		echo "Include  conf/addon-modules/nagios.conf" >> ${ROOT}/etc/apache/conf/apache.conf
		einfo
		einfo "Remember to edit /etc/conf.d/apache and add \"-D NAGIOS\""
		einfo
	fi
}

pkg_prerm() {
	/etc/init.d/nagios stop
}
