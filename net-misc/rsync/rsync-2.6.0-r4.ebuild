# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rsync/rsync-2.6.0-r4.ebuild,v 1.1 2005/03/18 02:01:59 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="File transfer program to keep remote files into sync"
HOMEPAGE="http://rsync.samba.org/"
SRC_URI="http://rsync.samba.org/ftp/rsync/old-versions/${P}.tar.gz
	http://www.imada.sdu.dk/~bardur/personal/40-patches/rsync-proxy-auth/rsync-2.5.6-proxy-auth-1.patch
	acl? ( http://www.saout.de/misc/${P}-acl.diff.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="build static acl"

RDEPEND="!build? ( >=dev-libs/popt-1.5 )
	acl? ( sys-apps/acl )"
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	epatch "${FILESDIR}"/${P}-sanitize.patch
	epatch "${DISTDIR}/${PN}-2.5.6-proxy-auth-1.patch"
	use acl && epatch "${DISTDIR}"/${P}-acl.diff.bz2

	# apply security patch from bug #60309
	epatch "${FILESDIR}"/${PN}-pathsanitize.patch
}

src_compile() {
	[ "`gcc-version`" == "2.95" ] && append-ldflags -lpthread
	use static && append-ldflags -static
	export LDFLAGS
	econf \
		$(use_with build included-popt) \
		$(use_with acl acl-support) \
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
	make DESTDIR="${D}" install || die "make install failed"
	newconfd "${FILESDIR}"/rsyncd.conf.d rsyncd
	newinitd "${FILESDIR}"/rsyncd.init.d rsyncd
	if ! use build ; then
		dodoc NEWS OLDNEWS README TODO tech_report.tex
		insinto /etc
		doins "${FILESDIR}"/rsyncd.conf
	else
		rm -r "${D}"/usr/share
	fi
}

pkg_postinst() {
	ewarn "The rsyncd.conf file has been moved for you to /etc/rsyncd.conf"
	echo
	ewarn "Please make sure you do NOT disable the rsync server running"
	ewarn "in a chroot.  Please check /etc/rsyncd.conf and make sure"
	ewarn "it says: use chroot = yes"
	echo
	einfo 'This patch enables usage of user:pass@proxy.foo:port'
	einfo 'in the RSYNC_PROXY environment variable to support'
	einfo 'the "Basic" proxy authentication scheme if you are'
	einfo 'behind a password protected HTTP proxy.'
}
