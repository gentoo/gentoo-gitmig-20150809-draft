# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-fs/samba/samba-2.2.0a.ebuild,v 1.1 2001/06/25 16:01:22 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Samba :)"
SRC_URI="http://us1.samba.org/samba/ftp/${P}.tar.gz"
HOMEPAGE="http://www.samba.org"

DEPEND="virtual/glibc
	pam? ( >=sys-libs/pam-0.72 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"

#ssl support removed -- it doesn't work...

src_compile() { 
  local myconf
  if [ "`use pam`" ]
  then
    echo "pam support does not work atm!"
    myconf="--without-pam"
    #myconf="--with-pam"
  else
    myconf="--without-pam"
  fi
  
  cd ${S}/source

  # Disabled automout support, because it failed
  # Added -lncurses for readline detection

  try ./configure --prefix=/usr \
	--sysconfdir=/etc/smb --localstatedir=/var/log --libdir=/etc/smb --sbindir=/usr/sbin \
	--without-automount --with-utmp --without-sambabook --with-netatalk --with-smbmount \
	--with-privatedir=/etc/smb/private --with-msdfs --with-vfs --with-spinlocks --with-lockdir=/var/run/smb --with-swatdir=/usr/share/swat \
	--with-mandir=/usr/share/man ${myconf} 
  try make
}

src_install() { 
	cd ${S}/source
	dodir /usr
	dodir /etc/smb
	dodir /usr/share/swat
	dodir /usr/share/doc/${PF}/html/book
	dodir /var/log
	dodir /var/run/smb
	try make install prefix=${D}/usr BASEDIR=${D}/usr LIBDIR=${D}/etc/smb VARDIR=${D}/var/log \
		PRIVATEDIR=${D}/etc/smb/private SWATDIR=${D}/usr/share/swat \
		LOCKDIR=${D}/var/lock SBINDIR=${D}/usr/sbin MANDIR=${D}/usr/share/man
	into /usr
	cd ${S}/source/script
        exeinto /usr/sbin
	doexe convert_smbpasswd mknissmbpasswd.sh mknissmbpwdtbl.sh
	doexe mksmbpasswd.sh smbtar
        cd ${S}
	dodoc COPYING Manifest README Roadmap WHATSNEW.txt
	cd ${S}/docs
	dodoc announce history samba.lsm THANKS 
	docinto reg
	dodoc *.reg
	docinto html
	dodoc htmldocs/*.html
	docinto html/book
	dodoc htmldocs/using_samba/*.html
	docinto html/book/gifs
	dodoc htmldocs/using_samba/gifs/*
	docinto html/book/figs
	dodoc htmldocs/using_samba/figs/*
	docinto faq
	dodoc faq/*.txt
	docinto html/faq
	dodoc faq/*.html
	docinto textdocs
	dodoc textdocs/*.txt textdocs/README*
	docinto print
	dodoc textdocs/*.{tex,ps,pdf} 
	docinto sgml/faq
	dodoc faq/*.sgml
	docinto sgml/docbook/faq
	dodoc docbook/faq/*.sgml
	docinto sgml/docbook/howto
	dodoc docbook/howto/*.sgml	
	docinto sgml/docbook/manpages
	dodoc docbook/manpages/*.sgml
	docinto sgml/docbook/projdoc
	dodoc docbook/projdoc/*.sgml
	insinto /usr/share/sgml/docbook/dbsgml
	doins docbook/dbsgml/*
	insinto /usr/share/sgml/docbook/dbsgml/ent
	doins docbook/dbsgml/ent/*
	cd ${S}
	cp -a examples ${D}/usr/share/doc/${PF}
	cp examples/smb.conf.default ${D}/etc/smb/smb.conf.eg
	
	exeinto /etc/rc.d/init.d
	doexe ${FILESDIR}/samba ${FILESDIR}/svc-samba
	diropts -m0700
	dodir /etc/smb/private

	#now, we move smbmount from /usr/sbin to /sbin, and rename it to mount.smbfs
	#this allows it to work perfectly with the standard Linux mount command
	# :)

	dodir /sbin
	mv ${D}/usr/bin/smbmount ${D}/sbin/mount.smbfs


	#supervise support
	local x
	for x in smbd nmbd
	do
		dodir /var/lib/supervise/services/${x}/log
		chmod +t ${D}/var/lib/supervise/services/${x}
		exeinto /var/lib/supervise/services/${x}
		newexe ${FILESDIR}/${x}-run run
		exeinto /var/lib/supervise/services/${x}/log
		newexe ${FILESDIR}/${x}-log run
	done
}

pkg_preinst() {
	if [ "$ROOT" = "/" ]
	then
		if [ -e /etc/rc.d/init.d/svc-samba ]
		then
			/etc/rc.d/init.d/svc-samba stop
		fi
		if [ -e /etc/rc.d/init.d/samba ]
		then
			/etc/rc.d/init.d/samba stop
		fi
	fi
}

pkg_postinst() {
	#touch ${D}/etc/smb/smb.conf to create a dummy file so that people installing samba
	#just to mount smb shares don't get annoying warnings all the time

	if [ ! -e ${ROOT}etc/smb/smb.conf ]
	then
		touch ${ROOT}etc/smb/smb.conf
	fi
	
	echo "Samba installed.  To configure samba (the server) to start on boot, type:"
	echo
	echo "# rc-update add svc-samba    [ for high-availability supervised Samba -- recommended ]"
	echo "# rc-update add samba		[ for normal non-supervised Samba ]"
	echo 
	echo "If you had samba running earlier, you'll need to start it again."
	echo 
	echo "Also, please note that you must configure /etc/smb/smb.conf before Samba (the server) will "
	echo "work properly.  Mounting smb shares and the smbclient program should work immediately,"
	echo "without any tweaking required."
	echo
	echo "To mount SMB shares, type something like this.  You'll need kernel SMB support to do this:"
	echo "# mount -t smbfs -o username=drobbins,password=foo,ip=192.168.1.1 //mybox/drobbins /mnt/foo" 
	echo
	echo "An empty file exists at /etc/smb/smb.conf at this moment, so that mounting smb shares won't"
	echo "produce an annoying warning message."
	echo
	echo "Another note.  If you want to allow normal users to mount smb shares, type the following as"
	echo "root:"
	echo "# chmod u+s /usr/bin/smbmnt"
}





