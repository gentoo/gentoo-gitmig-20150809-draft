# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/cifs-utils/cifs-utils-4.8.1.ebuild,v 1.5 2011/03/27 15:10:38 klausman Exp $

EAPI=2

inherit eutils confutils linux-mod

DESCRIPTION="Tools for Managing Linux CIFS Client Filesystems"
HOMEPAGE="http://www.samba.org/linux-cifs/cifs-utils/"
SRC_URI="ftp://ftp.samba.org/pub/linux-cifs/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE="ads +caps caps-ng creds setuid"

DEPEND="!net-fs/mount-cifs
	!<net-fs/samba-3.6
	ads? ( sys-libs/talloc virtual/krb5 sys-apps/keyutils )
	caps? ( sys-libs/libcap )
	caps-ng? ( sys-libs/libcap-ng )
	creds? ( sys-apps/keyutils )"
RDEPEND="${DEPEND}"

cifs_check() {
	ebegin "Checking for CIFS support"
	linux_chkconfig_present CIFS
	eend $?

	if [[ $? -ne 0 ]] ; then
		eerror "Please enable CIFS support in your kernel config, found at:"
		eerror
		eerror "  File systems"
		eerror "	Network File Systems"
		eerror "			CIFS support"
		eerror
		eerror "and recompile your kernel ..."
		die "CIFS support not detected!"
	fi
}

pkg_setup() {
	confutils_use_conflict caps caps-ng

	if use kernel_linux; then
		linux-mod_pkg_setup
		cifs_check
	fi
}

src_configure() {
	econf \
		$(use_enable ads cifsupcall) \
		$(use_with caps libcap) \
		$(use_enable creds cifscreds)
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	# Set set-user-ID bit of mount.cifs
	if use setuid ; then
		chmod u+s "${D}"/sbin/mount.cifs
	fi
	dodoc doc/linux-cifs-client-guide.odt
}

pkg_postinst() {
	# Inform about set-user-ID bit of mount.cifs
	if use setuid ; then
		ewarn "Setting SETUID bit for mount.cifs."
		ewarn "However, there may be severe security implications. Also see:"
		ewarn "http://samba.org/samba/security/CVE-2009-2948.html"
	fi

	# Inform about upcall usage
	if use ads ; then
		ewarn "Using mount.cifs in combination with keyutils"
		ewarn "in order to mount DFS shares, you need to add"
		ewarn "the following line to /etc/request-key.conf:"
		ewarn "  create dns_resolver * * /usr/sbin/cifs.upcall %k"
		ewarn "Otherwise, your DFS shares will not work properly."
	fi
}
