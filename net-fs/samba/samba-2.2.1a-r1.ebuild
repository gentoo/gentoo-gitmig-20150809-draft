# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/net-fs/samba/samba-2.2.1a.ebuild,v 1.2 2001/07/25 03:20:35 lamer Exp
# $Header: /var/cvsroot/gentoo-x86/net-fs/samba/samba-2.2.1a-r1.ebuild,v 1.4 2001/08/31 03:23:39 pm Exp $


S=${WORKDIR}/${P}
DESCRIPTION="Samba :)"
SRC_URI="http://us1.samba.org/samba/ftp/${P}.tar.gz"
HOMEPAGE="http://www.samba.org"

DEPEND="virtual/glibc sys-devel/autoconf
        cups? ( net-print/cups )
	pam? ( >=sys-libs/pam-0.72 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	ssl? ( >=dev-libs/openssl-0.9.6 )"

RDEPEND="virtual/glibc
        cups? ( net-print/cups )"

# PAM support can cause lots of problems. We want the admin of the box to
# do this on his own. There is a mailing list thread on samba-devel that's
# about 40 posts long about this
#		pam? ( >=sys-libs/pam-0.72 )"

src_unpack() {
    unpack ${A}
    if [ "`use afs`" ]; then
      cd ${S}
      cat ${FILESDIR}/patch.221a.10 | patch -p0
    fi
}

src_compile() { 
  local myconf
# Again same as above, PAM and Samba not good. Consult samba.org for
# details. Only enable if you KNOW what you're doing and you really really
# wanna venture down this path.
#  if [ "`use pam`" ]
#  then
#     myconf="--with-pam"
#  else
    myconf="--without-pam"
#  fi

# Samba doesn't seem to work well with ssl support but I'll add the check 
# anyway (otherwise it seems to be built with ssl if it finds it). This should # tested. I'll mail gentoo-dev and add a todo in wiki. /Hallski

#  if [ "`use ssl`" ]
#  then
#     myconf="${myconf} --with-ssl"
#  else
     myconf="${myconf} --without-ssl"
#  fi

  cd ${S}/source
  if [ ! "`use cups`" ] ; then
    cp configure.in configure.in.orig
    sed -e "s:AC_CHECK_LIB(cups,httpConnect)::" configure.in.orig > configure.in
    autoconf
  fi
  
  if [ "`use afs`" ]; then
    myconf="$myconf --with-afs"
  fi

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
	doexe ${FILESDIR}/samba
	diropts -m0700
	dodir /etc/smb/private

	#now, we move smbmount from /usr/sbin to /sbin, and rename it to mount.smbfs
	#this allows it to work perfectly with the standard Linux mount command
	# :)

	dodir /sbin
	mv ${D}/usr/bin/smbmount ${D}/sbin/mount.smbfs

	rm -rf ${D}/usr/private
}

pkg_preinst() {
	if [ "$ROOT" = "/" ]
	then
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

