# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/wwwoffle/wwwoffle-2.6d.ebuild,v 1.3 2001/10/20 17:36:22 danarmak Exp $

S=${WORKDIR}/${P}

DESCRIPTION="wwwoffle = WWW Offline Explorer, an adv. caching proxy suitable for nonpermanent (e.g. DUN) Internet connections"

SRC_URI="ftp://ftp.demon.co.uk/pub/unix/httpd/${P}.tgz
	 ftp://metalab.unc.edu/pub/Linux/apps/www/servers/${P}.tgz"

HOMEPAGE="http://www.gedanken.demon.co.uk/"

DEPEND="sys-devel/flex 
	sys-libs/zlib
	sys-devel/gcc
	virtual/glibc"

src_unpack() {
    
    unpack ${A}
    cd ${S}
    
    patch -p0 <${FILESDIR}/${P}-gentoo.diff
    
    if [ "`use ipv6 `" ]; then
	cp Makefile 2
	sed -e 's/USE_IPV6=0/USE_IPV6=1/' 2 > Makefile
	rm 2
    fi
        
}

src_compile() {
    
    emake all || die
    
}

src_install () {
    
    # This is necessary to install over an existing installation.
    # Don't worry, no (interesting) info is lost.
    # what's deleted is the backup info from a previous over-installation.
    rm -rf /var/spool/wwwoffle/html.old
    mv /var/spool/wwwoffle/html /var/spool/wwwoffle/html.old
    
    # Install the files
    make DESTDIR=${D} install || die
    
    # Install the wwwoffled init script
    insinto /etc/rc.d/init.d
    newins ${FILESDIR}/wwwoffled.rc5 wwwoffled
    chmod a+x ${D}/etc/rc.d/init.d/wwwoffled
    
}

pkg_postinst() {
    
    # This simply prints out some useful instructions.
    echo "
    
    -----------
    What's Next
    -----------
    
    You have successfully installed wwwoffle.
    
    To configure it, read and edit /var/spool/wwwoffle/wwwoffle.conf.
    It's well commented and very powerful.
    
    To start using wwwoffle:
    1. Run 'rc-update add wwwoffled <runlevels>'.
    2. Run 'wwwoffle -online; wwwoffle -fetch' whenever you go online
       (at boot if you're on a network) and 'wwwoffle -offline'
       when you disconnect.
    3. Configure any programs to use localhost:8080 as a proxy
       server for HTTP, HTTPS, FTP and finger.
    "
    
}