# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rsync/rsync-2.6.2.ebuild,v 1.1 2004/05/01 03:27:51 solar Exp $

inherit eutils flag-o-matic gcc

DESCRIPTION="File transfer program to keep remote files into sync"
HOMEPAGE="http://rsync.samba.org/"
SRC_URI="http://rsync.samba.org/ftp/rsync/${P}.tar.gz"
# ACL patches need to be forward ported again.
#	acl? ( http://www.saout.de/misc/${PN}-2.6.0-acl.diff.bz2 )"
#  http://www.imada.sdu.dk/~bardur/personal/patches/${PN}-proxy-auth/${PN}-2.5.6-proxy-auth-1.patch

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~hppa ~amd64 ~ia64 ~ppc64 ~s390"
# IUSE="build static acl"
IUSE="build static"

RDEPEND="virtual/glibc
	!build? ( >=dev-libs/popt-1.5 )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	acl? ( sys-apps/acl )"

src_unpack() {
	unpack "${P}.tar.gz"
	cd ${S}
	# proxy patch seems to be merged in now 2.6.2
	# epatch "${DISTDIR}/${PN}-2.5.6-proxy-auth-1.patch"
	#use acl && epatch ${DISTDIR}/${PN}-2.6.0-acl.diff.bz2

	# change confdir to /etc/rsync rather than just /etc (the --sysconfdir
	# configure option doesn't work
	sed	-i \
		-e 's|/etc/rsyncd.conf|/etc/rsync/rsyncd.conf|g' rsync.h \
			|| die "sed rsync.h failed"
	# yes, updating the man page is very important.
	sed -i \
		-e 's|/etc/rsyncd|/etc/rsync/rsyncd|g' rsyncd.conf.5 \
			|| die "sed rsyncd.conf.5 failed"
}

src_compile() {
	[ "`gcc-version`" == "2.95" ] && append-ldflags -lpthread
	use static && append-ldflags -static
	export LDFLAGS
	econf $(use_with build included-popt) \
		$(use_with acl acl-support) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	insinto /etc/conf.d && newins "${FILESDIR}/rsyncd.conf.d" rsyncd
	exeinto /etc/init.d && newexe "${FILESDIR}/rsyncd.init.d" rsyncd
	if ! use build ; then
		dodir /etc/rsync
		dodoc NEWS OLDNEWS README TODO tech_report.tex
		if [ ! -e /etc/rsync/rsyncd.conf ] ; then
			insinto /etc/rsync
			doins "${FILESDIR}/rsyncd.conf"
		fi
	else
		rm -rf "${D}/usr/share"
	fi
}

pkg_postinst() {
	ewarn "Please make sure you do NOT disable the rsync server running"
	ewarn "in a chroot.  Please check /etc/rsync/rsyncd.conf and make sure"
	ewarn "it says: use chroot = yes"
}
