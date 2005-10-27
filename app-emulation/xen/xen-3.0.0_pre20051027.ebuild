# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xen/xen-3.0.0_pre20051027.ebuild,v 1.1 2005/10/27 16:40:23 chrb Exp $

inherit mount-boot

DESCRIPTION="The Xen virtual machine monitor and Xend daemon"
HOMEPAGE="http://xen.sourceforge.net"
DATE="20051027"
SRC_URI="mirror://gentoo/xen-unstable-${DATE}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc debug screen"

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

src_compile() {
	local myopt
	if use debug; then
		myopt="${myopt} debug=y"
	fi

	unset CFLAGS
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
