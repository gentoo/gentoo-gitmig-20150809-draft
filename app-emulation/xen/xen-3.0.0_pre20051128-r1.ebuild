# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xen/xen-3.0.0_pre20051128-r1.ebuild,v 1.1 2005/11/30 22:23:24 chrb Exp $

inherit mount-boot flag-o-matic

DESCRIPTION="The Xen virtual machine monitor and Xend daemon"
HOMEPAGE="http://xen.sourceforge.net"
DATE="20051128"
SRC_URI="mirror://gentoo/xen-unstable-${DATE}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc debug screen cflags"

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
	sys-devel/dev86"

S="${WORKDIR}/xen-unstable-${DATE}"

src_unpack() {
	unpack ${A}
	# if the user *really* wants to use their own cflags, let them
	if use cflags; then
		einfo "User wants their own CFLAGS - removing defaults"
		for f in Makefile Rules.mk Config.mk; do
			# try and remove all the default cflags
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
}

src_compile() {
	local myopt
	if use debug; then
		myopt="${myopt} debug=y"
	fi

	filter-flags -fPIE -fstack-protector
	if ! use cflags; then
		unset CFLAGS
	fi

	make ${myopt} -C xen || die "compiling xen failed"
	make ${myopt} -C tools || die "compiling tools failed"

	if use doc; then
		sh ./docs/check_pkgs || die "package check failed"
		make ${myopt} -C docs || die "compiling docs failed"
	fi
}

src_install() {
	make DESTDIR=${D} -C xen install || die "installing xen failed"

	make DESTDIR=${D} XEN_PYTHON_NATIVE_INSTALL=1 -C tools install \
	    || die "installing tools failed"

	if use doc; then
		make DESTDIR=${D} -C docs install \
			|| die "installing docs failed"
		# Rename doc/xen to the Gentoo-style doc/xen-x.y
		mv ${D}/usr/share/doc/{${PN},${PF}}
	fi

	# bind xend to localhost per default
	sed -i -e "s/\((xend-address  *\)'')/\1\'localhost\')/" \
		${D}/etc/xen/xend-config.sxp

	newinitd ${FILESDIR}/xend-init xend
	newconfd ${FILESDIR}/xend-conf xend
	newconfd ${FILESDIR}/xendomains-conf xendomains
	newinitd ${FILESDIR}/xendomains-init xendomains

	# for upstream change tracking
	dodoc ${S}/XEN-VERSION

	if use screen; then
		sed -i -e 's/SCREEN="no"/SCREEN="yes"/' ${D}/etc/init.d/xendomains
	fi
}

pkg_postinst() {
	einfo "Please visit the Xen and Gentoo wiki:"
	einfo "http://gentoo-wiki.com/HOWTO_Xen_and_Gentoo"
}
