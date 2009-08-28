# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rsync/rsync-3.0.6.ebuild,v 1.4 2009/08/28 00:21:57 tanderson Exp $

inherit eutils flag-o-matic

DESCRIPTION="File transfer program to keep remote files into sync"
HOMEPAGE="http://rsync.samba.org/"
SRC_URI="http://rsync.samba.org/ftp/rsync/src/${P/_/}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="acl iconv ipv6 static xattr xinetd"

DEPEND=">=dev-libs/popt-1.5
	acl? ( virtual/acl )
	xattr? ( kernel_linux? ( sys-apps/attr ) )
	xinetd? ( sys-apps/xinetd )
	iconv? ( virtual/libiconv )"

S=${WORKDIR}/${P/_/}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch_user
}

src_compile() {
	use static && append-ldflags -static
	econf \
		--without-included-popt \
		$(use_enable acl acl-support) \
		$(use_enable xattr xattr-support) \
		$(use_enable ipv6) \
		$(use_enable iconv) \
		--with-rsyncd-conf=/etc/rsyncd.conf \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	newconfd "${FILESDIR}"/rsyncd.conf.d rsyncd
	newinitd "${FILESDIR}"/rsyncd.init.d rsyncd
	dodoc NEWS OLDNEWS README TODO tech_report.tex
	insinto /etc
	doins "${FILESDIR}"/rsyncd.conf

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/rsyncd.logrotate rsyncd

	if use xinetd ; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}"/rsyncd.xinetd rsyncd
	fi
}

pkg_postinst() {
	if egrep -qs '^[[:space:]]use chroot[[:space:]]*=[[:space:]]*(no|0|false)' \
		"${ROOT}"/etc/rsyncd.conf "${ROOT}"/etc/rsync/rsyncd.conf ; then
		ewarn "You have disabled chroot support in your rsyncd.conf.  This"
		ewarn "is a security risk which you should fix.  Please check your"
		ewarn "/etc/rsyncd.conf file and fix the setting 'use chroot'."
	fi
}
