# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-core/nagios-core-1.0-r1.ebuild,v 1.1 2003/02/12 06:32:53 alron Exp $
DESCRIPTION="Nagios $PV core - Host and service monitor cgi, docs etc..."
HOMEPAGE="http://www.nagios.org/"
SRC_URI="mirror://sourceforge/nagios/nagios-1.0.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc"
IUSE=""
DEPEND=">=jpeg-6b-r2
		>=libpng-1.2.4
		>=libgd-1.8.3-r5
		>=perl-5.6.1-r7
		>=traceroute-1.4_p12
		>=mailx-8.1
		>=apache-1.3.27-r1"
S="${WORKDIR}/nagios-1.0"

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
	make DESTDIR=${D} COMMAND_OPTS="" INSTALL_OPTS="" install install-config install-commandmode || die
	insinto /etc/apache/conf/addon-modules
	doins ${FILESDIR}/nagios.conf
	exeinto /etc/init.d
	doexe ${FILESDIR}/nagios
	insinto /etc/nagios
	doins ${FILESDIR}/nagios.cfg-sample
}
pkg_preinst() {

    userdel nagios 2> /dev/null
    if ! groupmod nagios; then
        groupadd -g 75 nagios 2> /dev/null || \
            die "Failed to create nagios group"
    fi
    useradd -u 75 -g nagios -s /dev/null -d /var/empty -c "nagios" nagios || \
        die "Failed to create nagios user"
	chown -R nagios:nagios ${D}/etc/nagios || die "Failed Chown of ${D}/etc/nagios"
	chown -R nagios:nagios ${D}/usr/nagios || die "Failed Chown of ${D}/usr/nagios"
	chown -R nagios:nagios ${D}/var/nagios || die "Failed Chown of ${D}/var/nagios"
	chown nagios:apache ${D}/var/nagios/rw || die "Failed Chown of ${D}/var/nagios/rw"
}
pkg_postinst() {
	einfo 
	einfo "Remember to edit the config files in /etc/nagios"
	einfo "Also, if you want nagios to start at boot time"
	einfo "remember to execute rc-update add nagios default"
	einfo
	einfo "To have nagios visable on the web, please do the following:"
	einfo "1. Execute the command:"
	einfo " \"ebuild /var/db/pkg/net-analyzer/${PF}/${PF}.ebuild config\""
	einfo " 2. Edit /etc/conf.d/apache and add \"-D NAGIOS\""
	einfo
	einfo "That will make nagios's web front end visable via"
	einfo "http://localhost/nagios/"
	einfo
	einfo "The Apache config file for nagios will be in"
	einfo "/etc/apache/conf/addon-modules/ with the name of"
	einfo "nagios.conf."
	einfo "Also, if your kernel has /proc protection, nagios"
	einfo "will not be happy as it relies on accessing the proc"
	einfo "filesystem."
	einfo
}

pkg_config() {
		echo "Include  conf/addon-modules/nagios.conf" \
			>> ${ROOT}/etc/apache/conf/apache.conf
	einfo
	einfo "Remember to edit /etc/conf.d/apache and add \"-D NAGIOS\""
	einfo
}
pkg_prerm() {
	/etc/init.d/nagios stop
}
