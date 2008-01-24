# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/owfs/owfs-2.7_p3.ebuild,v 1.1 2008/01/24 18:04:37 wschlich Exp $

inherit eutils

MY_P=${P/_/}

DESCRIPTION="Access 1-Wire devices like a filesystem"
SRC_URI="mirror://sourceforge/owfs/${MY_P}.tar.gz"
HOMEPAGE="http://www.owfs.org/ http://owfs.sourceforge.net/"
LICENSE="GPL-2"
DEPEND="fuse? ( sys-fs/fuse )
	perl? ( dev-lang/perl dev-lang/swig )
	php? ( dev-lang/php dev-lang/swig )
	python? ( dev-lang/python dev-lang/swig )
	tcl? ( dev-lang/tcl )
	usb? ( dev-libs/libusb )
	zeroconf? ( || ( net-dns/avahi net-misc/mDNSResponder ) )"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug fuse ftpd httpd parport perl php python server tcl usb zeroconf"

S=${WORKDIR}/${MY_P}

OWUID=${OWUID:-owfs}
OWGID=${OWGID:-owfs}

pkg_setup() {
	if use php && has_version dev-lang/php && ! built_with_use dev-lang/php cli; then
		eerror "${PN} needs the command line interface (CLI) of php"
		eerror "Please re-emerge dev-lang/php with USE=cli"
		die "need dev-lang/php built with cli USE flag"
	fi
	if use zeroconf && has_version net-dns/avahi && ! built_with_use net-dns/avahi mdnsresponder-compat; then
		eerror "You need to recompile net-dns/avahi with mdnsresponder-compat USE flag"
		die "net-dns/avahi is missing required mdnsresponder-compat support for USE=zeroconf"
	fi
	enewgroup ${OWGID} 150
	enewuser  ${OWUID} 150 -1 -1 ${OWGID}
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable fuse owfs) \
		$(use_enable ftpd owftpd) \
		$(use_enable httpd owhttpd) \
		$(use_enable parport) \
		$(use_enable perl owperl) \
		$(use_enable php owphp) \
		$(use_enable python owpython) \
		$(use_enable server owserver) \
		$(use_enable tcl owtcl) \
		$(use_enable zeroconf zero) \
		$(use_enable usb) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README NEWS ChangeLog AUTHORS
	if use server || use httpd || use ftpd || use fuse; then
		diropts -m 0750 -o ${OWUID} -g ${OWGID}
		dodir /var/run/owfs
		for i in server httpd ftpd; do
			if use ${i}; then
				newinitd "${FILESDIR}"/ow${i}.initd ow${i}
				newconfd "${FILESDIR}"/ow${i}.confd ow${i}
			fi
		done
		if use fuse; then
			dodir /var/lib/owfs
			dodir /var/lib/owfs/mnt
			newinitd "${FILESDIR}"/owfs.initd owfs
			newconfd "${FILESDIR}"/owfs.confd owfs
		fi
	fi
}

pkg_postinst() {
	if use server || use httpd || use ftpd || use fuse; then
		echo
		einfo
		einfo "Be sure to check/edit the following files,"
		einfo "e.g. to fit your 1 wire bus controller"
		einfo "device or daemon network settings:"
		for i in server httpd ftpd; do
			if use ${i}; then
				einfo "- ${ROOT%/}/etc/conf.d/ow${i}"
			fi
		done
		if use fuse; then
			einfo "- ${ROOT%/}/etc/conf.d/owfs"
		fi
		einfo
		echo
		if [[ ${OWUID} != root ]]; then
			ewarn
			ewarn "In order to allow the OWFS daemon user '${OWUID}' to read"
			ewarn "from and/or write to a 1 wire bus controller device, make"
			ewarn "sure the user has appropriate permission to access the"
			ewarn "corresponding device node/path (e.g. /dev/ttyS0), for example"
			ewarn "by adding the user to the group 'uucp' (for serial devices)"
			ewarn "or 'usb' (for USB devices accessed via usbfs on /proc/bus/usb)."
			ewarn
			if use fuse; then
				ewarn "In order to allow regular users to read from and/or write to"
				ewarn "1 wire bus devices accessible via the owfs FUSE filesystem"
				ewarn "client and its filesystem mountpoint, make sure the user is"
				ewarn "a member of the group '${OWGID}'."
				ewarn
			fi
			echo
		fi
	fi
}
