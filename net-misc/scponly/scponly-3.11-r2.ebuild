# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/scponly/scponly-3.11-r2.ebuild,v 1.1 2004/07/28 00:00:29 matsuu Exp $

inherit eutils

DESCRIPTION="A tiny psuedoshell which only permits scp and sftp"
SRC_URI="http://www.sublimation.org/scponly/${P}.tgz"
HOMEPAGE="http://www.sublimation.org/scponly/"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
IUSE=""

DEPEND="virtual/libc
	net-misc/openssh"

src_compile() {
	PATH="${PATH}:/usr/lib/misc" ./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--sysconfdir=/etc \
		--enable-rsync-compat \
		--enable-chrooted-binary \
		|| die "./configure failed"

	emake || die
}

src_install() {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		CONFDIR=${D}/etc/scponly \
		install || die

	dodoc AUTHOR CHANGELOG CONTRIB README TODO
}

pkg_postinst() {
	# pkg_postinst is based on ${S}/setup_chroot.sh.

	local myuser="scponly"
	local myhome="/home/${myuser}"

	einfo "Updating /etc/shells"
	{ grep -v "^/usr/bin/scponly$" /etc/shells;
	echo "/usr/bin/scponly"
	} > ${T}/shells
	mv -f ${T}/shells /etc/shells

	{ grep -v "^/usr/sbin/scponlyc$" /etc/shells;
	echo "/usr/sbin/scponlyc"
	} > ${T}/shells
	mv -f ${T}/shells /etc/shells

	BINARIES="/usr/lib/misc/sftp-server /bin/ls /usr/bin/scp /bin/rm /bin/ln /bin/mv /bin/chmod /bin/chown /bin/chgrp /bin/mkdir /bin/rmdir /bin/pwd /bin/groups /usr/bin/ld /bin/echo /usr/bin/rsync"
	LIB_LIST=`/usr/bin/ldd $BINARIES 2> /dev/null | /bin/cut -f2 -d\> | /bin/cut -f1 -d\( | /bin/grep "^ " | /bin/sort -u`
	LDSO_LIST="/lib/ld.so /libexec/ld-elf.so /libexec/ld-elf.so.1 /usr/libexec/ld.so /lib/ld-linux.so.2 /usr/libexec/ld-elf.so.1"
	for lib in $LDSO_LIST; do
		if [ -f $lib ]; then
			LIB_LIST="$LIB_LIST $lib"
		fi
	done
	/bin/ls /lib/libnss_compat* > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		LIB_LIST="$LIB_LIST /lib/libnss_compat*"
	fi

	ldconfig
	LIB_LIST="$LIB_LIST /etc/ld.so.cache /etc/ld.so.conf"

	enewgroup ${myuser}
	enewuser ${myuser} -1 /usr/sbin/scponlyc ${myhome} ${myuser}
	if [ ! -d ${myhome} ]; then
		/bin/install -c -d ${myhome}
		/bin/chmod 755 ${myhome}
	fi
	if [ ! -d ${myhome} ]; then
		/bin/install -c -d ${myhome}/etc
		/bin/chown 0:0 ${myhome}/etc
		/bin/chmod 755 ${myhome}/etc
	fi
	for bin in $BINARIES; do
		/bin/install -c -d ${myhome}/`/bin/dirname $bin`
		/bin/install -c $bin ${myhome}/$bin
	done
	for lib in $LIB_LIST; do
		/bin/install -c -d ${myhome}/`/bin/dirname $lib`
		/bin/install -c $lib ${myhome}/$lib
	done

	/bin/chown 0:0 ${myhome}
	if [ -d ${myhome}/.ssh ]; then
		/bin/chown 0:0 ${myhome}/.ssh
	fi

	if [ ! -d ${myhome}/incoming ]; then
		einfo "creating ${myhome}/incoming directory for uploading files"
		/bin/install -c -o ${myuser} -d ${myhome}/incoming
	fi
	/bin/chown $myuser:$myuser ${myhome}/incoming

	grep "^${myuser}" /etc/passwd > ${myhome}/etc/passwd

	einfo ""
	einfo "if you experience a warning with winscp regarding groups, please install"
	einfo "the provided hacked out fake groups program into your chroot, like so:"
	einfo "cp groups ${myhome}/bin/groups"
}
