# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-core/nagios-core-1.1-r1.ebuild,v 1.1 2003/06/17 20:15:39 alron Exp $
inherit eutils

DESCRIPTION="Nagios $PV core - Host and service monitor cgi, docs etc..."
HOMEPAGE="http://www.nagios.org/"
SRC_URI="mirror://sourceforge/nagios/nagios-1.1.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc"
IUSE="apache2"
DEPEND=">=jpeg-6b-r2
		>=libpng-1.2.4
		>=libgd-1.8.3-r5
		>=perl-5.6.1-r7
		>=traceroute-1.4_p12
		>=mailx-8.1
		|| (
		>=apache-1.3.27-r1
		apache2 ( >=net-www/apache-2.0.43-r1 )
		)"
S="${WORKDIR}/nagios-1.1"
pkg_setup() {
	enewgroup nagios 
	enewuser nagios -1 /bin/bash /dev/null nagios
	# Old Style removed because of eutils class
	#userdel nagios 2> /dev/null
	#if ! groupmod nagios; then
	#	groupadd -g 75 nagios 2> /dev/null || \
	#		die "Failed to create nagios group"
	#fi
	#useradd -u 75 -g nagios -s /dev/null -d /var/empty -c "nagios" nagios || \
	#	die "Failed to create nagios user"
}
src_unpack() {
	unpack ${A}
	cd ${S}
	bzcat ${FILESDIR}/Makefile-distclean.diff.bz2 | patch -p1
	bzcat ${FILESDIR}/tac.cgi.diff.bz2 | patch -p1
}
src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr/nagios \
		--localstatedir=/var/nagios \
		--sysconfdir=/etc/nagios \
		--enable-embedded-perl \
		--with-perlcache \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake all || die
}

src_install() {
	dodoc Changelog INSTALLING LEGAL LICENSE README UPGRADING
#	make DESTDIR=${D} COMMAND_OPTS="" INSTALL_OPTS="" install install-config install-commandmode || die
	make DESTDIR=${D} install install-config install-commandmode || die
	if [ "`use apache2`" ] ; then
		insinto /etc/apache2/conf/modules.d
		doins ${FILESDIR}/99_nagios.conf
	else
		insinto /etc/apache/conf/addon-modules
		doins ${FILESDIR}/nagios.conf
	fi
	exeinto /etc/init.d
	doexe ${FILESDIR}/nagios
	insinto /etc/nagios
	doins ${FILESDIR}/nagios.cfg-sample
}
pkg_preinst() {
	chown -R nagios:nagios ${D}/etc/nagios || die "Failed Chown of ${D}/etc/nagios"
	touch ${D}/usr/nagios/share/ssi/.keep
	chown -R nagios:nagios ${D}/usr/nagios || die "Failed Chown of ${D}/usr/nagios"
	touch ${D}/var/nagios/.keep
	touch ${D}/var/nagios/archives/.keep
	chown -R nagios:nagios ${D}/var/nagios || die "Failed Chown of ${D}/var/nagios"
	touch ${D}/var/nagios/rw/.keep
	chown nagios:apache ${D}/var/nagios/rw || die "Failed Chown of ${D}/var/nagios/rw"
}
pkg_postinst() {
	einfo 
	einfo "Remember to edit the config files in /etc/nagios"
	einfo "Also, if you want nagios to start at boot time"
	einfo "remember to execute rc-update add nagios default"
	einfo
	einfo "To have nagios visable on the web, please do the following:"
	if [ "`use apache2`" ] ; then
		einfo "Edit /etc/conf.d/apache2 and add \"-D NAGIOS\""
	else
		einfo "1. Execute the command:"
		einfo " \"ebuild /var/db/pkg/net-analyzer/${PF}/${PF}.ebuild config\""
		einfo " 2. Edit /etc/conf.d/apache and add \"-D NAGIOS\""
	fi
	einfo
	einfo "That will make nagios's web front end visable via"
	einfo "http://localhost/nagios/"
	einfo
	if [ "`use apache2`" ] ; then
		einfo "The Apache2 config file for nagios will be in"
		einfo "/etc/apache2/conf/modules.d with the name of"
		einfo "99_nagios.conf."
	else	
		einfo "The Apache config file for nagios will be in"
		einfo "/etc/apache/conf/addon-modules/ with the name of"
		einfo "nagios.conf."
	fi
	einfo "Also, if your kernel has /proc protection, nagios"
	einfo "will not be happy as it relies on accessing the proc"
	einfo "filesystem. You can fix this by adding nagios into"
	einfo "the group wheel, but this is not recomended."
	einfo
}

pkg_config() {
	if [ "`use apache2`" ] ; then
		einfo "Edit /etc/conf.d/apache2 and add \"-D NAGIOS\""
	else
		echo "Include  conf/addon-modules/nagios.conf" \
			>> ${ROOT}/etc/apache/conf/apache.conf
		einfo
		einfo "Remember to edit /etc/conf.d/apache and add \"-D NAGIOS\""
		einfo
	fi
}
pkg_prerm() {
	/etc/init.d/nagios stop
}
