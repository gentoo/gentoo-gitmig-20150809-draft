# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xen/xen-3.0.1-r3.ebuild,v 1.1 2006/03/03 12:20:56 chrb Exp $

inherit mount-boot flag-o-matic

DESCRIPTION="The Xen virtual machine monitor and Xend daemon"
HOMEPAGE="http://xen.sourceforge.net"
SRC_URI="http://www.cl.cam.ac.uk/Research/SRG/netos/xen/downloads/xen-3.0.1-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc debug screen custom-cflags pae"

DEPEND="sys-apps/iproute2
	net-misc/bridge-utils
	dev-lang/python
	net-misc/curl
	sys-libs/zlib
	doc? (
		dev-tex/latex2html
		media-gfx/transfig
	)
	screen? (
		app-misc/screen
		app-admin/logrotate
	)
	sys-devel/dev86
	|| ( sys-fs/udev sys-apps/hotplug )"

src_unpack() {
	unpack ${A}
	# if the user *really* wants to use their own custom-cflags, let them
	if use custom-cflags; then
		einfo "User wants their own CFLAGS - removing defaults"
		for f in Makefile Rules.mk Config.mk; do
			# try and remove all the default custom-cflags
			find ${S} -name ${f} -exec sed \
				-e 's/CFLAGS\(.*\)=\(.*\)-O3\(.*\)/CFLAGS\1=\2\3/' \
				-e 's/CFLAGS\(.*\)=\(.*\)-march=i686\(.*\)/CFLAGS\1=\2\3/' \
				-e 's/CFLAGS\(.*\)=\(.*\)-fomit-frame-pointer\(.*\)/CFLAGS\1=\2\3/' \
				-e 's/CFLAGS\(.*\)=\(.*\)-g3*\s\(.*\)/CFLAGS\1=\2 \3/' \
				-e 's/CFLAGS\(.*\)=\(.*\)-O2\(.*\)/CFLAGS\1=\2\3/' \
				-i {} \;
		done
		# odd fixes
		sed -e "s/int mode/int mode=-1/" -i ${S}/tools/misc/xc_shadow.c
	fi

	cat ${FILESDIR}/gentoo-makefile-targets >> ${S}/Makefile
}

src_compile() {
	local myopt
	if use debug; then
		myopt="${myopt} debug=y"
	fi

	if use pae; then
		myopt="${myopt} XEN_TARGET_X86_PAE=y"
	fi

	if ! use custom-cflags; then
		unset CFLAGS
	fi
	filter-flags -fPIE -fstack-protector

	make ${myopt} gentoo-compile || die "compile failed"

	if use doc; then
		sh ./docs/check_pkgs || die "package check failed"
		make ${myopt} -C docs || die "compiling docs failed"
	fi
}

src_install() {
	local myopt="XEN_PYTHON_NATIVE_INSTALL=1"

	if use pae; then
		myopt="${myopt} XEN_TARGET_X86_PAE=y"
	fi

	make DESTDIR=${D} ${myopt} gentoo-install || die "install xen failed"

	if use doc; then
		make DESTDIR=${D} -C docs install || die "install docs failed"
		# Rename doc/xen to the Gentoo-style doc/xen-x.y
		mv ${D}/usr/share/doc/{${PN},${PF}}
	fi

	newinitd ${FILESDIR}/xend-init xend
	newconfd ${FILESDIR}/xend-conf xend
	newconfd ${FILESDIR}/xendomains-conf xendomains
	newinitd ${FILESDIR}/xendomains-init xendomains

	if use screen; then
		sed -i -e 's/SCREEN="no"/SCREEN="yes"/' ${D}/etc/init.d/xendomains
	fi

	# xend expects these to exist
	dodir /var/run/xenstored
	dodir /var/lib/xenstored
	dodir /var/xen/dump
}

pkg_postinst() {
	einfo "Please visit the Xen and Gentoo wiki:"
	einfo "http://gentoo-wiki.com/HOWTO_Xen_and_Gentoo"

	if use pae; then
		einfo ""
		einfo "This is a PAE build of Xen. It will *only* boot PAE kernels!"
	fi
}
