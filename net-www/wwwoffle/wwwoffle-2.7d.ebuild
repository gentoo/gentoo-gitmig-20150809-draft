# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/wwwoffle/wwwoffle-2.7d.ebuild,v 1.1 2002/07/29 15:13:53 danarmak Exp $

S=${WORKDIR}/${P}

DESCRIPTION="wwwoffle = WWW Offline Explorer, an adv. caching proxy especially suitable for nonpermanent (e.g. dialup) Internet connections"

SRC_URI="ftp://ftp.demon.co.uk/pub/unix/httpd/${P}.tgz
	 ftp://metalab.unc.edu/pub/Linux/apps/www/servers/${P}.tgz"

HOMEPAGE="http://www.gedanken.demon.co.uk/"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="sys-devel/flex 
	sys-libs/zlib
	sys-devel/gcc
	virtual/glibc"


src_compile() {
    
    local myconf
    use ipv6	&& myconf="$myconf --with-ipv6" 	|| myconf="$myconf --without-ipv6"
    ./configure $myconf --prefix=/usr --with-confdir=/etc	|| die
    
    emake || die
    
}

src_install () {
    
    # Install the files
    make prefix=${D}/usr SPOOLDIR=${D}/var/spool/wwwoffle CONFDIR=${D}/etc install || die
    
    cd ${D}/etc
    mv wwwoffle.conf 1
    sed -e "s:${D}::" 1 > wwwoffle.conf
    rm 1
    
    # Install the wwwoffled init script
    exeinto /etc/init.d
    doexe ${FILESDIR}/{wwwoffled-online,wwwoffled}
    
    # someday i'll make it use the file in /etc. for now we at least get
    # config file protection this way.
    dosym /etc/wwwoffle.conf /var/spool/wwwoffle/wwwoffle.conf
    
}

pkg_preinst() {

    source /etc/init.d/functions.sh
    if [ -L ${svcdir}/started/wwwoffled ]; then
	einfo "The wwwoffled init script is running. I'll stop it, merge the new files and
restart the script."
	/etc/init.d/wwwoffled stop
	touch ${T}/restart
    fi

}

pkg_postinst() {
    
    if [ -f "${T}/restart" ]; then
	einfo "Starting the wwwoffled initscript again..."
	/etc/init.d/wwwoffled start
	rm ${T}/restart
    fi
    
    # This simply prints out some useful instructions.
    einfo "
    
    -----------
    What's Next
    -----------
    
    You have successfully installed wwwoffle.
    
    To configure it, read and edit /etc/wwwoffle.conf.
    It's well commented and very powerful. Alternatively, browse to
    http://localhost:8080 and you'll be presented with a webform-based
    configuration interface.
    
    To start using wwwoffle:
    1. rc-update add wwwoffled to boot.
    2. rc-update add wwwoffled-online to your 'online' runlevels.
    3. Configure any programs to use localhost:8080 as a proxy server
       for HTTP, HTTPS, FTP and finger.
"
    
}

