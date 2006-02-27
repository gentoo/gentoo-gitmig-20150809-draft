# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/scponly/scponly-4.6.ebuild,v 1.1 2006/02/27 15:08:47 matsuu Exp $

inherit eutils

DESCRIPTION="A tiny pseudoshell which only permits scp and sftp"
HOMEPAGE="http://www.sublimation.org/scponly/"
SRC_URI="http://www.sublimation.org/scponly/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="subversion"

DEPEND="virtual/libc
	net-misc/openssh
	subversion? ( dev-util/subversion )"

myuser="scponly"
myhome="/home/${myuser}"

src_compile() {
	PATH="${PATH}:/usr/$(get_libdir)/misc" \
	econf \
		--enable-scp-compat \
		--enable-winscp-compat \
		--enable-rsync-compat \
		--enable-chrooted-binary \
		$(use_enable subversion svn-compat) \
		$(use_enable subversion svnserv-compat) \
		|| die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHOR BUILDING-JAILS.TXT CHANGELOG CONTRIB README TODO
	dodoc setup_chroot.sh
}

pkg_preinst() {
	enewgroup ${myuser}
	enewuser ${myuser} -1 /usr/sbin/scponlyc ${myhome} ${myuser}
}

pkg_postinst() {
	einfo "You might want to run:"
	einfo "\"emerge --config =${CATEGORY}/${PF}\""
	einfo "to setup the chroot."
	einfo "Otherwise you will have to setup chroot manually."
}

pkg_config() {
	# pkg_postinst is based on ${S}/setup_chroot.sh.

	einfo "Updating /etc/shells"
	{ grep -v "^/usr/bin/scponly$" /etc/shells;
	echo "/usr/bin/scponly"
	} > ${T}/shells
	mv -f ${T}/shells /etc/shells

	{ grep -v "^/usr/sbin/scponlyc$" /etc/shells;
	echo "/usr/sbin/scponlyc"
	} > ${T}/shells
	mv -f ${T}/shells /etc/shells

	BINARIES="/usr/$(get_libdir)/misc/sftp-server /bin/ls /usr/bin/scp /bin/rm /bin/ln /bin/mv /bin/chmod /bin/chown /bin/chgrp /bin/mkdir /bin/rmdir /bin/pwd /bin/groups /usr/bin/ld /bin/echo /usr/bin/rsync"
	if built_with_use ${PN} subversion; then
	    BINARIES="$BINARIES /usr/bin/svn /usr/bin/svnserve"
	fi
	LIB_LIST=`/usr/bin/ldd $BINARIES 2> /dev/null | /bin/cut -f2 -d\> | /bin/cut -f1 -d\( | /bin/grep "^ " | /bin/sort -u`
	LDSO_LIST="/$(get_libdir)/ld.so /libexec/ld-elf.so /libexec/ld-elf.so.1 /usr/libexec/ld.so /$(get_libdir)/ld-linux.so.2 /usr/libexec/ld-elf.so.1"
	for lib in $LDSO_LIST; do
		if [ -f $lib ]; then
		    LIB_LIST="$LIB_LIST $lib"
		fi
	done
	/bin/ls /$(get_libdir)/libnss_compat* > /dev/null 2>&1
	if [ $? -eq 0 ]; then
	    LIB_LIST="$LIB_LIST /$(get_libdir)/libnss_compat*"
	fi

	ldconfig
	LIB_LIST="$LIB_LIST /etc/ld.so.cache /etc/ld.so.conf"

	if [ ! -d ${myhome} ]; then
		/bin/install -c -d ${myhome}
		/bin/chmod 755 ${myhome}
	fi
	if [ ! -d ${myhome} ]; then
		/bin/install -c -d ${myhome}/etc
		/bin/chown 0:0 ${myhome}/etc
		/bin/chmod 755 ${myhome}/etc
	fi
	if [ ! -d ${myhome}/$(get_libdir) ]; then
		/bin/install -c -d ${myhome}/$(get_libdir)
		/bin/chmod 755 ${myhome}/$(get_libdir)
	fi
	if [ ! -d ${myhome}/lib ]; then
		/usr/bin/ln -s $(get_libdir) ${myhome}/lib
	fi
	if [ ! -d ${myhome}/usr/$(get_libdir) ]; then
		/bin/install -c -d ${myhome}/usr/$(get_libdir)
		/bin/chmod 755 ${myhome}/usr/$(get_libdir)
	fi
	if [ ! -d ${myhome}/usr/lib ]; then
		/usr/bin/ln -s $(get_libdir) ${myhome}/usr/lib
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

	einfo "if you experience a warning with winscp regarding groups, please install"
	einfo "the provided hacked out fake groups program into your chroot, like so:"
	einfo "cp groups ${myhome}/bin/groups"
}
