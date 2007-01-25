# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xen/xen-3.0.2.ebuild,v 1.8 2007/01/25 23:07:09 genone Exp $

inherit mount-boot flag-o-matic

DESCRIPTION="The Xen virtual machine monitor"
HOMEPAGE="http://xen.sourceforge.net"
if [[ ${PV} == *_p* ]]; then
	XEN_UNSTABLE="xen-unstable-${PV#*_p}"
	SRC_URI="mirror://gentoo/${XEN_UNSTABLE}.tar.bz2"
	S="${WORKDIR}/${XEN_UNSTABLE}"
else
	SRC_URI="http://www.cl.cam.ac.uk/Research/SRG/netos/xen/downloads/${P}-src.tgz"
	S="${WORKDIR}/xen-${PV}"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug custom-cflags pae hardened"

DEPEND="sys-devel/dev86"
RDEPEND=""

RESTRICT="test"

pkg_setup() {
	if [[ -z ${XEN_TARGET_ARCH} ]]; then
		if use x86; then
			export XEN_TARGET_ARCH="x86_32"
		elif use amd64; then
			export XEN_TARGET_ARCH="x86_64"
		else
			die "Unsupported architecture!"
		fi
	fi
}


src_unpack() {
	unpack ${A}
	# if the user *really* wants to use their own custom-cflags, let them
	if use custom-cflags; then
		einfo "User wants their own CFLAGS - removing defaults"
		# try and remove all the default custom-cflags
		find "${S}" -name Makefile -o -name Rules.mk -o -name Config.mk -exec sed \
			-e 's/CFLAGS\(.*\)=\(.*\)-O3\(.*\)/CFLAGS\1=\2\3/' \
			-e 's/CFLAGS\(.*\)=\(.*\)-march=i686\(.*\)/CFLAGS\1=\2\3/' \
			-e 's/CFLAGS\(.*\)=\(.*\)-fomit-frame-pointer\(.*\)/CFLAGS\1=\2\3/' \
			-e 's/CFLAGS\(.*\)=\(.*\)-g3*\s\(.*\)/CFLAGS\1=\2 \3/' \
			-e 's/CFLAGS\(.*\)=\(.*\)-O2\(.*\)/CFLAGS\1=\2\3/' \
			-i {} \;
	fi
	if use hardened; then
		cd "${S}"
		epatch "${FILESDIR}/${PN}"-3.0.2-nopiessp.patch
	fi
}

src_compile() {
	local myopt
	use debug && myopt="${myopt} debug=y"
	use pae && myopt="${myopt} pae=y"

	if use custom-cflags; then
		filter-flags -fPIE -fstack-protector
	else
		unset CFLAGS
	fi

	# Send raw LDFLAGS so that --as-needed works
	emake LDFLAGS="$(raw-ldflags)" -C xen ${myopt} || die "compile failed"
}

src_install() {
	local myopt
	use pae && myopt="${myopt} pae=y"

	make DESTDIR="${D}" ${myopt} install-xen \
		|| die "install failed"

	# for upstream change tracking
	if [[ -n ${XEN_UNSTABLE} ]]; then
		dodoc "${S}"/XEN-VERSION
	fi
}

pkg_postinst() {
	elog "Please visit the Xen and Gentoo wiki:"
	elog "http://gentoo-wiki.com/HOWTO_Xen_and_Gentoo"

	echo
	elog "Note: xen tools have been moved to app-emulation/xen-tools;"
	elog "you need to install that package to manage your domains."

	if [[ -n ${XEN_UNSTABLE} ]]; then
		echo
		elog "This is a snapshot of the xen-unstable tree."
		elog "Please report bugs in xen itself (and not the packaging) to"
		elog "bugzilla.xensource.com"
	fi

	if use pae; then
		echo
		ewarn "This is a PAE build of Xen. It will *only* boot PAE kernels!"
	fi
}
