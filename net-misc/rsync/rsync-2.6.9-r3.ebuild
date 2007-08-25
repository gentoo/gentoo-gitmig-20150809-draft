# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rsync/rsync-2.6.9-r3.ebuild,v 1.9 2007/08/25 14:33:55 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="File transfer program to keep remote files into sync"
HOMEPAGE="http://rsync.samba.org/"
SRC_URI="http://rsync.samba.org/ftp/rsync/${P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ~ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="acl ipv6 static xinetd"

DEPEND=">=dev-libs/popt-1.5
	acl? ( kernel_linux? ( sys-apps/acl ) )
	xinetd? ( sys-apps/xinetd )"

S=${WORKDIR}/${P/_/}

src_unpack() {
	unpack ${P/_/}.tar.gz
	cd "${S}"
	if use acl ; then
		epatch patches/{acls,xattrs}.diff
		epatch "${FILESDIR}"/${P}-delete-acls-xattr.patch
		./prepare-source || die
	fi
	epatch "${FILESDIR}"/${P}-stats-fix.patch #165121
	epatch "${FILESDIR}"/${P}-fname-obo.patch #189132
}

src_compile() {
	[[ $(gcc-version) == "2.95" ]] && append-ldflags -lpthread
	use static && append-ldflags -static

	econf \
		--without-included-popt \
		$(use_enable acl acl-support) \
		$(use_enable acl xattr-support) \
		$(use_enable ipv6) \
		--with-rsyncd-conf=/etc/rsyncd.conf \
		|| die
	emake || die "emake failed"
}

pkg_preinst() {
	if [[ -e ${ROOT}/etc/rsync/rsyncd.conf ]] && [[ ! -e ${ROOT}/etc/rsyncd.conf ]] ; then
		mv "${ROOT}"/etc/rsync/rsyncd.conf "${ROOT}"/etc/rsyncd.conf
		rm -f "${ROOT}"/etc/rsync/.keep
		rmdir "${ROOT}"/etc/rsync >& /dev/null
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	newconfd "${FILESDIR}"/rsyncd.conf.d rsyncd
	newinitd "${FILESDIR}"/rsyncd.init.d rsyncd
	dodoc NEWS OLDNEWS README TODO tech_report.tex
	insinto /etc
	doins "${FILESDIR}"/rsyncd.conf
	if use xinetd ; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}"/rsyncd.xinetd rsyncd
	fi
}

pkg_postinst() {
	ewarn "The rsyncd.conf file has been moved for you to /etc/rsyncd.conf"
	echo
	ewarn "Please make sure you do NOT disable the rsync server running"
	ewarn "in a chroot.  Please check /etc/rsyncd.conf and make sure"
	ewarn "it says: use chroot = yes"
}
