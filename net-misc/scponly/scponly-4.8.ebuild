# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/scponly/scponly-4.8.ebuild,v 1.7 2010/06/22 18:54:31 arfrever Exp $

inherit eutils multilib

DESCRIPTION="A tiny pseudoshell which only permits scp and sftp"
HOMEPAGE="http://www.sublimation.org/scponly/"
SRC_URI="mirror://sourceforge/scponly/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~mips ppc sparc x86"
IUSE="rsync subversion"

DEPEND="net-misc/openssh
	rsync? ( net-misc/rsync )
	subversion? ( dev-vcs/subversion )"

myuser="scponly"
myhome="/home/${myuser}"

pkg_setup() {
	if use subversion || use rsync ; then
		ewarn
		ewarn "read the \"SECURITY\" document in ${P}.tgz before enabling 'rsync' or 'subversion' USE flag"
		ewarn
		ebeep 5
	fi
}

src_compile() {
	econf \
		--disable-wildcards \
		--enable-chrooted-binary \
		--disable-gftp-compat \
		--with-sftp-server="/usr/$(get_libdir)/misc/sftp-server" \
		$(use_enable rsync rsync-compat) \
		$(use_enable subversion svn-compat) \
		$(use_enable subversion svnserv-compat) \
		|| die "./configure failed"
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHOR BUILDING-JAILS.TXT CHANGELOG CONTRIB README SECURITY TODO
	dodoc setup_chroot.sh
}

pkg_postinst() {
	elog "You might want to run:"
	elog "\"emerge --config =${CATEGORY}/${PF}\""
	elog "to setup the chroot."
	elog "Otherwise you will have to setup chroot manually."

	# two slashes ('//') are used by scponlyc to determine the chroot point.
	enewgroup "${myuser}"
	enewuser "${myuser}" -1 /usr/sbin/scponlyc "${myhome}//" "${myuser}"
}

pkg_config() {
	# pkg_postinst is based on ${S}/setup_chroot.sh.

	einfo "Updating /etc/shells"
	{ grep -v "^/usr/bin/scponly$" /etc/shells;
	echo "/usr/bin/scponly"
	} > "${T}"/shells
	cp "${T}"/shells /etc/shells

	{ grep -v "^/usr/sbin/scponlyc$" /etc/shells;
	echo "/usr/sbin/scponlyc"
	} > "${T}"/shells
	cp "${T}"/shells /etc/shells

	BINARIES="/usr/$(get_libdir)/misc/sftp-server /bin/ls /usr/bin/scp /bin/rm /bin/ln /bin/mv /bin/chmod /bin/chown /bin/chgrp /bin/mkdir /bin/rmdir /bin/pwd /bin/groups /usr/bin/ld /bin/echo"
	if built_with_use =${CATEGORY}/${PF} rsync; then
		BINARIES="$BINARIES /usr/bin/rsync"
	fi
	if built_with_use =${CATEGORY}/${PF} subversion; then
	    BINARIES="$BINARIES /usr/bin/svn /usr/bin/svnserve"
	fi
	LIB_LIST=`ldd $BINARIES 2> /dev/null | cut -f2 -d\> | cut -f1 -d\( | grep "^[ 	]" | sort -u`
	LDSO_LIST="/$(get_libdir)/ld.so /libexec/ld-elf.so /libexec/ld-elf.so.1 /usr/libexec/ld.so /$(get_libdir)/ld-linux.so.2 /usr/libexec/ld-elf.so.1"
	for lib in $LDSO_LIST; do
		if [ -f $lib ]; then
		    LIB_LIST="$LIB_LIST $lib"
		fi
	done
	ls /$(get_libdir)/libnss_compat* > /dev/null 2>&1
	if [ $? -eq 0 ]; then
	    LIB_LIST="$LIB_LIST /$(get_libdir)/libnss_compat*"
	fi

	ldconfig
	LIB_LIST="$LIB_LIST /etc/ld.so.cache /etc/ld.so.conf"

	if [ ! -d ${myhome} ]; then
		install -c -d ${myhome}
		chmod 755 ${myhome}
	fi
	if [ ! -d ${myhome} ]; then
		install -c -d ${myhome}/etc
		chown 0:0 ${myhome}/etc
		chmod 755 ${myhome}/etc
	fi
	if [ ! -d ${myhome}/$(get_libdir) ]; then
		install -c -d ${myhome}/$(get_libdir)
		chmod 755 ${myhome}/$(get_libdir)
	fi
	if [ ! -d ${myhome}/lib ]; then
		ln -s $(get_libdir) ${myhome}/lib
	fi
	if [ ! -d ${myhome}/usr/$(get_libdir) ]; then
		install -c -d ${myhome}/usr/$(get_libdir)
		chmod 755 ${myhome}/usr/$(get_libdir)
	fi
	if [ ! -d ${myhome}/usr/lib ]; then
		ln -s $(get_libdir) ${myhome}/usr/lib
	fi

	for bin in $BINARIES; do
		install -c -d ${myhome}/`/bin/dirname $bin`
		install -c $bin ${myhome}/$bin
	done
	for lib in $LIB_LIST; do
		install -c -d ${myhome}/`/bin/dirname $lib`
		install -c $lib ${myhome}/$lib
	done

	chown 0:0 ${myhome}
	if [ -d ${myhome}/.ssh ]; then
		chown 0:0 ${myhome}/.ssh
	fi

	if [ ! -d ${myhome}/incoming ]; then
		einfo "creating ${myhome}/incoming directory for uploading files"
		install -c -o ${myuser} -d ${myhome}/incoming
	fi
	chown $myuser:$myuser ${myhome}/incoming

	if [ ! -e ${myhome}/etc/passwd ]; then
		grep "^${myuser}" /etc/passwd > ${myhome}/etc/passwd
	fi

	# Bug 135505
	if [ ! -e ${myhome}/dev/null ]; then
		install -c -d ${myhome}/dev
		mknod -m 777 ${myhome}/dev/null c 1 3
	fi
}
