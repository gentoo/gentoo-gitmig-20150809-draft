# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rsync/rsync-2.6.0.ebuild,v 1.1 2004/01/03 16:34:38 vapier Exp $

inherit eutils flag-o-matic gcc

DESCRIPTION="File transfer program to keep remote files into sync"
HOMEPAGE="http://rsync.samba.org/"
SRC_URI="http://rsync.samba.org/ftp/rsync/${P}.tar.gz
	http://www.imada.sdu.dk/~bardur/personal/patches/${PN}-proxy-auth/${PN}-2.5.6-proxy-auth-1.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64"

DEPEND="virtual/glibc
	>=sys-apps/sed-4
	!build? ( >=dev-libs/popt-1.5 )"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${DISTDIR}/${PN}-2.5.6-proxy-auth-1.patch

	# change confdir to /etc/rsync rather than just /etc (the --sysconfdir
	# configure option doesn't work
	sed	-i 's|/etc/rsyncd.conf|/etc/rsync/rsyncd.conf|g' rsync.h
	# yes, updating the man page is very important.
	sed -i 's|/etc/rsyncd|/etc/rsync/rsyncd|g' rsyncd.conf.5
}

src_compile() {
	[ "`gcc-version`" == "2.95" ] && append-ldflags -lpthread
	use static && append-ldflags -static
	econf `use_with build included-popt` || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	insinto /etc/conf.d && newins ${FILESDIR}/rsyncd.conf.d rsyncd
	exeinto /etc/init.d && newexe ${FILESDIR}/rsyncd.init.d rsyncd
	if [ ! `use build` ] ; then
		dodir /etc/rsync
		dodoc COPYING NEWS OLDNEWS README TODO tech_report.tex
		if [ ! -e /etc/rsync/rsyncd.conf ] ; then
			insinto /etc/rsync
			doins ${FILESDIR}/rsyncd.conf
		fi
	else
		rm -rf ${D}/usr/share
	fi
}

pkg_postinst() {
	ewarn "Please make sure you do NOT disable the rsync server running"
	ewarn "in a chroot.  Please check /etc/rsync/rsyncd.conf and make sure"
	ewarn "it says: use chroot = yes"

	einfo 'This patch enables usage of user:pass@proxy.foo:port'
	einfo 'in the RSYNC_PROXY environment variable to support'
	einfo 'the "Basic" proxy authentication scheme if you are'
	einfo 'behind a password protected HTTP proxy.'
}
