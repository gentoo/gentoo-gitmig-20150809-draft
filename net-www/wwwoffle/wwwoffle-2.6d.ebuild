# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/wwwoffle/wwwoffle-2.6d.ebuild,v 1.1 2001/07/17 21:42:50 danarmak Exp $
#
# TODO: add ipv6 support
# 
# Description of accompanying patch
# ---------------------------------
# Unfortunately, wwwoffle doesn't use autoconf etc. It has a Makefile
# which we must change.
# This Makefile has variables like INSTDIR, DOCDIR, BINDIR, CONFDIR etc.
# However it uses them with sed to change its man pages and config file,
# so that they contain the actual location wwwoffle is installed to.
# This means that when we change them to /tmp/portage... ${D} we create
# two additional variables called REALSPOOLDIR and REALCONFDIR which contain
# the real install location (i.e. without ${D}) and insert them in the right
# places instead of SPOOLDIR, CONFDIR. Thus the Makefile reads from the real
# install location, but writes only under ${D}.
#
# There is another problem: the Makefile performs some checks to gracefully
# handle installing over an existing copy or an older version. 
# There's one problem with that: during installation, the Makefile backups
# the /var/spool/wwwoffle/html/ directory as html.old/ and overwrites
# the html/ dir. If an html.old/ dir already exists, the Makefile aborts.
# I didn't want to change the Makefile's default behaviour, so for now
# this ebuild forces deletion of html.old and moves the existing html/
# to html.old/ Most people won't care anyway, since the contents of html/
# aren't dynamic: they only change between wwwoffle versions.
#
# Another thing that's in the patch is support for env. var. CFLAGS.


S=${WORKDIR}/${P}

DESCRIPTION="wwwoffle = WWW Offline Explorer, an adv. caching proxy suitable for nonpermanent (e.g. DUN) Internet connections"

SRC_URI="ftp://ftp.demon.co.uk/pub/unix/httpd/${P}.tgz
	 ftp://metalab.unc.edu/pub/Linux/apps/www/servers/${P}.tgz"

HOMEPAGE="http://www.gedanken.demon.co.uk/"

DEPEND="sys-devel/flex 
	sys-libs/zlib"

src_unpack() {
    
    unpack ${A}
    cd ${S}
    
    patch -p0 <${FILESDIR}/${P}-gentoo.diff
        
}

src_compile() {
    
    try emake all
    
}

src_install () {
    
    # We make sure the wwwoffled daemon isn't running during installation
    echo "Don't mind any error messages in the next secnod or two"
    
    # This is to restart it later if it is running:
    RESTART=no
    # wwwoffle returns an error if ther's no wwwoffled daemon to kill
    wwwoffle -kill && RESTART=yes
    # In any case now the daemon isn't running, we just told it to die.
    
    # This is necessary to install over an existing installation.
    # Don't worry, no (interesting) info is lost.
    # I'm almost sure what's deleted is the backup info
    # from a previous over-installation.
    rm -rf /var/spool/wwwoffle/html.old
    mv /var/spool/wwwoffle/html /var/spool/wwwoffle/html.old
    
    # Install the files
    try make DESTDIR=${D} install
    
    # Install the wwwoffled init script
    mkdir -p ${D}/etc/rc.d/init.d
    cp ${FILESDIR}/wwwoffled ${D}/etc/rc.d/init.d
    
    # Restart the daemon if we shut it down before
    if [ ${RESTART} == yes ] ; then wwwoffled ; fi
    
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
    1. Run 'rc-update add wwwoffled'.
    2. Run 'wwwoffle -online; wwwoffle -fetch' whenever you go online
       (at boot if you're on a network) and 'wwwoffle -offline'
       when you disconnect.
    3. Configure any programs to use localhost:8080 as a proxy
       server for HTTP, HTTPS, FTP and finger.
    "
    
}